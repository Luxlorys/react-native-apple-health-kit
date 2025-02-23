import Foundation
import HealthKit

@objc public class AppleHealthKitManager: NSObject {

    let healthStore = HKHealthStore()
    let permissions = HealthKitPermissions()
    let queries = HealthKitQueries()

    @objc public func requestHealthKitPermissions(completion: @escaping (Bool, Error?) -> Void) {
        permissions.requestPermissions(completion: completion)
    }

    @objc public func getSteps(daysBefore: NSNumber, completion: @escaping (NSArray?, Error?) -> Void) {
        queries.getSteps(daysBefore: daysBefore.intValue) { result, error in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let stepsData = result?["steps"] as? [[String: Any]] else {
                completion(nil, NSError(domain: "HealthKit", code: -2, userInfo: [NSLocalizedDescriptionKey: "Invalid steps data"]))
                return
            }
            completion(stepsData as NSArray, nil)
        }
    }

    @objc public func getHeartRate(daysBefore: NSNumber, completion: @escaping (NSArray?, Error?) -> Void) {
        queries.getHeartRate(daysBefore: daysBefore.intValue) { result, error in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let heartRateData = result?["heartRate"] as? [[String: Any]] else {
                completion(nil, NSError(domain: "HealthKit", code: -2, userInfo: [NSLocalizedDescriptionKey: "Invalid heart rate data"]))
                return
            }
            completion(heartRateData as NSArray, nil)
        }
    }


    @objc public func getMeasurements(completion: @escaping ([String: AnyObject]?) -> Void) {
        queries.getMeasurements(completion: completion)
    }
}
