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
         return "arrow.down.circle.fill"
      case .exit:
         return "arrow.up.circle.fill"
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
      switch type {
      case .entry:
         return "+\(quantity) unité(s)"
      case .exit:
         return "-\(quantity) unité(s)"
      }
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
