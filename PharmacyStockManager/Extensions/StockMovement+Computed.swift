//
//  StockMovement+Computed.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 22/07/2026.
//

import SwiftUI

extension StockMovement {
   var icon : String {
      switch type {
      case .entry:
         return "arrow.down"
      case .exit:
         return "arrow.up"
      }
   }
   
   var color : Color {
      switch type {
      case .entry:
         return .green
      case .exit:
         return .red
      }
   }
   
   var quantityText : String {
      let unitLabel = quantity > 1 ? "unités" : "unité"
      let sign = type == .entry ? "+" : "-"
      return "\(sign)\(quantity)\n\(unitLabel)"
   }
   
   
   var title : String  {
      switch type {
      case .entry:
         return "Entrée"
         
      case .exit:
         return "Sortie"
      }
   }

}
extension Array where Element == StockMovement {
    func groupedByDay() -> [(date: Date, movements: [StockMovement])] {
        let grouped = Dictionary(grouping: self) { movement in
            Calendar.current.startOfDay(for: movement.date)
        }
        return grouped
            .map { (date: $0.key, movements: $0.value) }
            .sorted { $0.date > $1.date }
    }
}
