import HealthKit

class HealthKitQueries {
    private let healthStore = HKHealthStore()

    func getSteps(daysBefore: Int, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let calendar = Calendar(identifier: .gregorian)
        let endDate = Date()
        let startDate = calendar.date(byAdding: .day, value: -daysBefore, to: endDate)!
        let anchorDate = calendar.startOfDay(for: endDate)
        let interval = DateComponents(day: 1)

        let query = HKStatisticsCollectionQuery(
            quantityType: HKQuantityType(.stepCount),
            quantitySamplePredicate: HKQuery.predicateForSamples(withStart: startDate, end: endDate),
            anchorDate: anchorDate,
            intervalComponents: interval
        )

        query.initialResultsHandler = { _, results, error in
            if let error = error {
                completion(nil, error)
                return
            }

            var stepsDictionaries: [[String: Any]] = []

            results?.enumerateStatistics(from: startDate, to: endDate) { statistics, _ in
                if let stepCount = statistics.sumQuantity()?.doubleValue(for: HKUnit.count()) {
                    stepsDictionaries.append([
                        "dateString": getShortStringDate(statistics.startDate),
                        "stepCount": stepCount
                    ])
                }
            }

            do {
                let validStepsDictionaries = try checkIsEmptyArray(stepsDictionaries, "Steps read access denied")
                completion(["steps": validStepsDictionaries], nil)
            } catch {
                completion(nil, error)
            }
        }

        healthStore.execute(query)
    }

    func getHeartRate(daysBefore: Int, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let quantityType = HKObjectType.quantityType(forIdentifier: .heartRate)!
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let calendar = Calendar(identifier: .gregorian)

        let endDate = Date()
        let startDate = calendar.date(byAdding: .day, value: -daysBefore, to: endDate)!

        let sampleQuery = HKSampleQuery(
            sampleType: quantityType,
            predicate: HKQuery.predicateForSamples(withStart: startDate, end: endDate),
            limit: HKObjectQueryNoLimit,
            sortDescriptors: [sortDescriptor]
        ) { _, results, error in
            guard let samples = results as? [HKQuantitySample] else {
                completion(nil, error)
                return
            }

            var heartRateDict: [String: [Double]] = [:]

            for sample in samples {
                let dateKey = getShortStringDate(sample.startDate)
                let bpm = sample.quantity.doubleValue(for: HKUnit(from: "count/min"))
                heartRateDict[dateKey, default: []].append(bpm)
            }

            var heartRateDictionaries: [[String: Any]] = []
            for (date, values) in heartRateDict {
                let avgHeartRate = values.reduce(0, +) / Double(values.count)
                heartRateDictionaries.append(["dateString": date, "heartRate": avgHeartRate])
            }

            do {
                let validDictionaries = try checkIsEmptyArray(heartRateDictionaries, "Heart rate read access denied")
                completion(["heartRate": validDictionaries], nil)
            } catch {
                completion(nil, error)
            }
        }

        healthStore.execute(sampleQuery)
    }
  
  private func getHeight(completion: @escaping (Double?) -> Void) {
      let heightType = HKQuantityType.quantityType(forIdentifier: .height)!
      let query = HKSampleQuery(sampleType: heightType, predicate: nil, limit: 1, sortDescriptors: nil) { (query, results, error) in
          if let result = results?.first as? HKQuantitySample {
              let heightInMeters = result.quantity.doubleValue(for: HKUnit.meter())
              completion(heightInMeters)
          } else {
              completion(nil)
          }
      }
      healthStore.execute(query)
  }

    private func getBiologicalSex(completion: @escaping (HKBiologicalSexObject?) -> Void) {
        do {
            let biologicalSex = try healthStore.biologicalSex()
            completion(biologicalSex)
        } catch {
            completion(nil)
        }
    }

    private func getDateOfBirth(completion: @escaping (DateComponents?) -> Void) {
        do {
            let dateOfBirth = try healthStore.dateOfBirthComponents()
            completion(dateOfBirth)
        } catch {
            completion(nil)
        }
    }

    private func getBodyMass(completion: @escaping (Double?) -> Void) {
        let bodyMassType = HKQuantityType.quantityType(forIdentifier: .bodyMass)!
        let query = HKSampleQuery(sampleType: bodyMassType, predicate: nil, limit: 1, sortDescriptors: nil) { (query, results, error) in
            if let result = results?.first as? HKQuantitySample {
                let bodyMassInKilograms = result.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
                completion(bodyMassInKilograms)
            } else {
                completion(nil)
            }
        }
        healthStore.execute(query)
    }

  @objc public func getMeasurements(completion: @escaping ([String: AnyObject]?) -> Void) {
      var healthData: [String: Any?] = [
          "bodyMass": nil,
          "height": nil,
          "biologicalSex": nil,
          "dateOfBirth": nil
      ]

      let dispatchGroup = DispatchGroup()

      // Fetch Height
      dispatchGroup.enter()
      getHeight { height in
          healthData["height"] = height
          dispatchGroup.leave()
      }

      // Fetch Biological Sex
      dispatchGroup.enter()
      getBiologicalSex { biologicalSex in
          if let biologicalSex = biologicalSex {
              healthData["biologicalSex"] = biologicalSexToString(biologicalSex.biologicalSex)
          }
          dispatchGroup.leave()
      }

      // Fetch Date of Birth
      dispatchGroup.enter()
      getDateOfBirth { dateOfBirth in
          if let dateOfBirth = dateOfBirth {
              healthData["dateOfBirth"] = dateComponentsToString(dateOfBirth)
          }
          dispatchGroup.leave()
      }

      // Fetch Body Mass
      dispatchGroup.enter()
      getBodyMass { bodyMass in
          healthData["bodyMass"] = bodyMass
          dispatchGroup.leave()
      }

      // Notify when all tasks are done
      dispatchGroup.notify(queue: .main) {
          // Convert [String: Any?] to [String: AnyObject]
          let objectiveCHealthData = healthData.mapValues { value in
              if let value = value {
                  return value as AnyObject
              } else {
                  return NSNull()
              }
          }
          completion(objectiveCHealthData)
      }
  }
}
