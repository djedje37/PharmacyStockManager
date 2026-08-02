//
//  VATRate.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 13/06/2026.
//

/// VAT category applied to a product.
/// Maps to the source pharmacy system's 2-tier VAT coding (1 = exempt, 2 = 18%).
enum VATRate: Int, Codable, CaseIterable {
    case exempt = 1
    case standard = 2

    /// The actual percentage applied for price calculations.
    var percentage: Double {
        switch self {
        case .exempt: return 0
        case .standard: return 18
        }
    }
   
   var displayLabel: String {
      switch self {
      case .exempt: return "Exonéré"
      case .standard: return "18%"
      }
   }
}
