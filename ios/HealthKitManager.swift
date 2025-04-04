//
//  HealthKitManager.swift
//  ReactNativeAppleHealthKit
//
//  Created by Andrei on 24.02.2025.
//

import Foundation
import HealthKit

@objc public class HealthKitManager: NSObject {

  private let healthStore = HKHealthStore()
  private let permissions = HealthKitPermissions()
  private let queries = HealthKitQueries()

  @objc public func requestHealthKitPermissions(completion: @escaping (Bool, Error?) -> Void) {
      permissions.requestPermissions(completion: completion)
  }

  @objc public func getSteps(daysBefore: NSNumber, completion: @escaping (NSArray?, Error?) -> Void) {
      queries.getStepsQuery(daysBefore: daysBefore.intValue) { result, error in
          if let error = error {
              completion(nil, error)
              return
          }

          guard let stepsData = result else {
              completion(nil, NSError(domain: "HealthKit", code: -2, userInfo: [NSLocalizedDescriptionKey: "Invalid steps data"]))
              return
          }
          completion(stepsData as NSArray, nil)
      }
  }

  @objc public func getHeartRate(daysBefore: NSNumber, completion: @escaping (NSArray?, Error?) -> Void) {
      queries.getHeartRateQuery(daysBefore: daysBefore.intValue) { result, error in
          if let error = error {
              completion(nil, error)
              return
          }

          guard let heartRateData = result else {
              completion(nil, NSError(domain: "HealthKit", code: -2, userInfo: [NSLocalizedDescriptionKey: "Invalid heart rate data"]))
              return
          }
          completion(heartRateData as NSArray, nil)
      }
  }


  @objc public func getMeasurements(completion: @escaping ([String: AnyObject]?) -> Void) {
      queries.getMeasurementsQuery(completion: completion)
  }
  
  @objc public func checkAvailability(completion: @escaping (Bool) -> Void) {
    permissions.checkAvailability(completion: completion)
  }
}
