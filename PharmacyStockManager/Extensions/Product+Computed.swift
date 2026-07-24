//
//  Product+Computed.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 22/07/2026.
//

import Foundation
extension Product {
   
   /// calculate for a product units sold in a specific period, based on exit movements
   /// Parameters:
   ///  - overLastDays: Int , days limit
   ///  Returns:
   ///  - Int: unit sold number
   func unitsSold(overLastDays: Int = 30) -> Int {
      let cutoff = Calendar.current.date(byAdding: .day, value: -overLastDays, to: .now) ?? .now
      return movements
         .filter{$0.type == .exit && $0.date >= cutoff }
         .reduce(0) {$0 + $1.quantity }
      
   }
   
   /// Calculate the average units sold by day over the period
   ///  Parameters:
   ///   - overLastDays: Int, period limit
   ///   Returns:
   ///   - Double: :the result 
   func rotationRate(overLastDays: Int = 30) -> Double {
      guard overLastDays > 0 else { return 0 }
      return Double(unitsSold(overLastDays: overLastDays)) / Double(overLastDays)
   }
      
}
