//
//  HealthKitPermissions.swift
//  ReactNativeAppleHealthKit
//
//  Created by Andrei on 24.02.2025.
//

import HealthKit

class HealthKitPermissions {
    let healthStore = HKHealthStore()

    func requestPermissions(completion: @escaping (Bool, Error?) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            let error = NSError(domain: "HealthKit", code: -1, userInfo: [NSLocalizedDescriptionKey: "HealthKit is not available on this device."])
            completion(false, error)
            return
        }

        var allTypes: Set = [
          HKObjectType.quantityType(forIdentifier: .heartRate)!,
          HKObjectType.quantityType(forIdentifier: .stepCount)!,
          HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
          HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!,
          HKQuantityType.quantityType(forIdentifier: .height)!,
          HKQuantityType.quantityType(forIdentifier: .bodyMass)!,
          HKSampleType.characteristicType(forIdentifier: .biologicalSex)!,
          HKSampleType.characteristicType(forIdentifier: .dateOfBirth)!
      ]

        healthStore.requestAuthorization(toShare: [], read: allTypes, completion: completion)
    }
  
  func checkAvailability(completion: @escaping (Bool) -> Void) {
    if HKHealthStore.isHealthDataAvailable() {
      completion(true)
    } else {
      let error = NSError(domain: "HealthKit", code: -1, userInfo: [NSLocalizedDescriptionKey: "HealthKit is not available on this device."])
      completion(false)
    }
  }
}
