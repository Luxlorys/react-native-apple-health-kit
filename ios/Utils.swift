//
//  Utils.swift
//  AppleHealthKit
//
//  Created by Andrei on 23.02.2025.
//

import Foundation

func filterNonZeroStepsDictionaries(_ stepsDictionaries: [[String: Any]]) -> [[String: Any]] {
    return stepsDictionaries.filter { dictionary in
        if let stepCount = dictionary["stepCount"] as? Double {
            return stepCount > 0.0
        }
        return false
    }
}

func checkStepsArrayDictionaries(_ array: [[String: Any]], _ errorMessage: NSString) throws -> [[String: Any]] {
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
