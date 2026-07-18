//
//  DateFormatter.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 05/07/2026.
//

import Foundation


extension DateFormatter {
    /// Formatter for 'yyyy-MM-dd' date strings, as used in the seed JSON data.
    static let seedDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

