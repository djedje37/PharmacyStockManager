//
//  CurrencyFormatter.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 18/07/2026.
//

import Foundation
extension Double {
   
   private static let fcfaToEuroRate = 655.957

   // TODO: currency and conversion in relief of locale zone 
   var fcfaToEuro: Double {
      self / Self.fcfaToEuroRate
   }
   
   var euroToFcfa : Double {
      self * Self.fcfaToEuroRate
   }
   
    var euroFormatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "EUR"
        formatter.locale = Locale(identifier: "fr_FR")
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
   
   var euroFormattedInt: String {
       let formatter = NumberFormatter()
       formatter.numberStyle = .currency
       formatter.currencyCode = "EUR"
       formatter.locale = Locale(identifier: "fr_FR")
       formatter.maximumFractionDigits = 0
       return formatter.string(from: NSNumber(value: Int(self))) ?? "\(self)"
   }
}
