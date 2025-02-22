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
        HKQuantityType(.heartRate)
    ]
      
    healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { success, error in
          if let error = error {
              completion(false, error)
          } else {
            completion(success, nil)
          }
      }
  }
    
  @objc public func getStepsCountForCurrentDay(completion: @escaping (NSNumber?, Error?) -> Void) {
      let stepType = HKQuantityType(.stepCount)
      
      let calendar = Calendar(identifier: .gregorian)
      let startDate = calendar.startOfDay(for: Date())
      let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date())
      
      let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
        if let error = error {
          completion(nil, error)
          return
        }
        
        if let result = result, let sum = result.sumQuantity() {
          let stepCount = sum.doubleValue(for: HKUnit.count())
          completion(NSNumber(value: stepCount), nil)
        } else {
          let error = NSError(domain: "HealthKit", code: -1, userInfo: [NSLocalizedDescriptionKey: "No step data found for today."])
          completion(nil, error)
        }
      }
  }

  @objc public func getStepsCountForLast30Days(completion: @escaping (NSArray?, Error?) -> Void) {
      let stepType = HKQuantityType(.stepCount)
      
      let calendar = Calendar(identifier: .gregorian)
      let endDate = Date()
      let startDate = calendar.date(byAdding: .day, value: -30, to: endDate)!
      let anchorDate = calendar.startOfDay(for: endDate)
      let interval = DateComponents(day: 1)
      
      let query = HKStatisticsCollectionQuery(
        quantityType: stepType,
        quantitySamplePredicate: HKQuery.predicateForSamples(withStart: startDate, end: endDate),
        anchorDate: anchorDate,
        intervalComponents: interval
      )
      
      query.initialResultsHandler = { _, results, error in
        if let error = error {
          completion(nil, error)
          return
        }
        
        var stepsArray: [NSNumber] = []
        
        results?.enumerateStatistics(from: startDate, to: endDate) { statistics, _ in
          let stepCount = statistics.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0.0
          stepsArray.append(NSNumber(value: stepCount))
        }
        
        completion(stepsArray as NSArray, nil)
      }
      
      self.healthStore.execute(query)
  }
}
