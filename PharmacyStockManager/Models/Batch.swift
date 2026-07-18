//
//  Batch.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 07/06/2026.
//

import Foundation

import SwiftData

// MARK: - Batch

/// A physical batch (lot) of a product currently held in stock.
/// A product may have one or many batches

@Model
class Batch {
   var quantity : Int
   
   var expirationDate: Date
   var receivedDate: Date
   
   var purchasePrice: Double
   var product: Product?
   

   init(quantity: Int, expirationDate: Date, receivedDate: Date, purchasePrice: Double, product: Product? = nil) {
      self.quantity = quantity
      self.expirationDate = expirationDate
      self.receivedDate = receivedDate
      self.purchasePrice = purchasePrice
      self.product = product
   }
   
  /* var publicPrice : Double // price depend on batch or same ?
   var alertThreshold: Double // also calculated
   var lastSaleDate: Date  // maybe in batch*/
}
