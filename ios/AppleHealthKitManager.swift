import Foundation
import HealthKit

@objc public class AppleHealthKitManager: NSObject {

    let healthStore = HKHealthStore()

    @objc public func requestHealthKitPermissions(completion: @escaping (Bool, Error?) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            let error = NSError(domain: "HealthKit", code: -1, userInfo: [NSLocalizedDescriptionKey: "HealthKit is not available on this device."])
            completion(false, error)
            return
        }

        let allTypes: Set = [
            HKQuantityType.workoutType(),
            HKQuantityType(.activeEnergyBurned),
            HKQuantityType(.distanceCycling),
            HKQuantityType(.distanceWalkingRunning),
            HKQuantityType(.distanceWheelchair),
            HKQuantityType(.heartRate),
            HKQuantityType(.stepCount),
        ]

        healthStore.requestAuthorization(toShare: [], read: allTypes) { success, error in
            if let error = error {
                completion(false, error)
            } else {
                completion(success, nil)
            }
        }
    }

  @objc public func getSteps(daysBefore: NSNumber, completion: @escaping (NSArray?, Error?) -> Void) {
        let calendar = Calendar(identifier: .gregorian)
        let endDate = Date()
    let startDate = calendar.date(byAdding: .day, value: daysBefore.intValue * -1, to: endDate)!
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
                    let stepDictionary: [String: Any] = [
                        "datestring": getShortStringDate(statistics.startDate),
                        "stepCount": stepCount
                    ]
                    stepsDictionaries.append(stepDictionary)
                }
            }

            let filteredStepsDictionaries = filterNonZeroStepsDictionaries(stepsDictionaries)
            do {
                let validStepsDictionaries = try checkStepsArrayDictionaries(filteredStepsDictionaries, "Steps read access denied")
                completion(validStepsDictionaries as NSArray, nil)
            } catch {
                completion(nil, error)
            }
        }

        healthStore.execute(query)
    }

}
