//
//  AddMovementViewModel.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 25/07/2026.
//

import SwiftData
import Foundation

@MainActor
@Observable
class AddMovementViewModel {
   
   private let stockService : StockService
   
   var selectedProduct : Product?
   
   var movementType : MovementType = .entry
   
   var quantity: Int = 0
   
   var expirationDate: Date = .now.addingTimeInterval(180 * 86400)
   
   var purchasePrice: Double = 0
   
   var errorMessage: String?
   
   
   init(stockService: StockService) {
      self.stockService = stockService
   }
   
   
   func submit() -> Bool {
      errorMessage = nil
      
      guard let product = selectedProduct else {
         errorMessage = "Sélectionne un produit"
         return false
      }
      
      guard  quantity > 0 else {
         errorMessage = "Quantité invalide"
         return false
      }
      
      
      do {
         try stockService.addMovement(product: product, quantity: quantity, type: movementType, expirationDate: expirationDate, purchasePrice: purchasePrice)
            
         self.resetForm()
         return true
         
      } catch {
         errorMessage = error.localizedDescription
         return false
      }

   }
   
   private func resetForm() {
       selectedProduct = nil
       quantity = 0
       purchasePrice = 0
   }
   
   
   
}
