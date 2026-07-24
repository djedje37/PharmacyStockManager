//
//  Product.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 06/06/2026.
//


import Foundation
import SwiftData


// MARK: Product
/// To represent a pharmaceutical product
@Model
class Product  {
   @Attribute(.unique) var cip: String
   var name : String
   var category : ProductCategory
   
   var reimbursementBase : Double
   var vatRate: VATRate = VATRate.exempt
   var geoCode: String?

   // price depend on batch can change on time
   // in second time can be nice to create a Model PriceHistory to logs all price history
   var publicPrice : Double
   
   // Quantity if product is under it, must generate an alert 
   var alertThreshold: Int
   
   // All physical stock batches received for this product.
   // When delete a product, shoud delete all related batchs
   @Relationship(deleteRule: .cascade, inverse: \Batch.product)
   var batches: [Batch] = []
   
   // Full history of stock entries (receptions) and exits (sales) for this product.
   // When delete a product, shoud delete all related stockMovement
   @Relationship(deleteRule: .cascade, inverse: \StockMovement.product)
   var movements: [StockMovement] = []
   
   
   
   // MARK: Computed properties
   
   // Total quantity currently in stock, summed across all active batches
   var totalStock : Int {
      batches.reduce(0) {
         $0 + $1.quantity
      }
   }
   
   var stockValueAtCost: Double {
      batches.reduce(0.0) { $0 + ($1.purchasePrice * Double($1.quantity)) }
   }
   
   var stockValueAtRetail: Double {
      batches.reduce(0.0) { $0 + (self.publicPrice * Double($1.quantity)) }
   }
   
   var isLowStock: Bool {
      totalStock <= alertThreshold
   }
   
   var averagePurchasePrice: Double {
      guard totalStock > 0 else { return 0 }
      return stockValueAtCost / Double(totalStock)
   }
   
   var isReimbursed : Bool {
      reimbursementBase > 0
   }
   
   // The soonest expiration date among all batches for a product
   // TO detect the most urgent expiration warning for a product
   var nearestExpiration: Date? {
      batches.map(\.expirationDate).min()
   }



   init(cip: String, name: String, category: ProductCategory, reimbursementBase: Double, vatRate: VATRate, geoCode: String? = nil, publicPrice: Double, alertThreshold: Int) {
      self.cip = cip
      self.name = name
      self.category = category
      self.reimbursementBase = reimbursementBase
      self.vatRate = vatRate
      self.geoCode = geoCode
      self.publicPrice = publicPrice
      self.alertThreshold = alertThreshold
   }
   
}
