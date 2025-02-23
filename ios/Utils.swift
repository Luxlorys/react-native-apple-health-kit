//
//  Utils.swift
//  AppleHealthKit
//
//  Created by Andrei on 23.02.2025.
//

import Foundation
import HealthKit

func filterNonZeroDictionaries(_ stepsDictionaries: [[String: Any]]) -> [[String: Any]] {
    return stepsDictionaries.filter { dictionary in
        if let stepCount = dictionary["stepCount"] as? Double {
            return stepCount > 0.0
        }
        return false
    }
}

func checkIsEmptyArray(_ array: [[String: Any]], _ errorMessage: NSString) throws -> [[String: Any]] {
    if array.isEmpty {
        throw NSError(domain: "com.yourapp.healthkit", code: -1, userInfo: [NSLocalizedDescriptionKey: errorMessage])
    }
    return array
}

func getShortStringDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short

    return formatter.string(from: date)
}

func dateComponentsToString(_ dateComponents: DateComponents) -> String {
    let calendar = Calendar.current
    if let date = calendar.date(from: dateComponents) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    return "Unknown"
}

func biologicalSexToString(_ biologicalSex: HKBiologicalSex) -> String {
    switch biologicalSex {
    case .female:
        return "Female"
    case .male:
        return "Male"
    case .other:
        return "Other"
    default:
        return "Not Set"
    }
}
