//
//  StockService.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 25/07/2026.
//

import Foundation
import SwiftData
enum StockError: Error, LocalizedError {

    case invalidQuantity
    case insufficientStock
    case productNotFound

    var errorDescription: String? {
        switch self {
        case .invalidQuantity:
            return "La quantité doit être supérieure à zéro."

        case .insufficientStock:
            return "Le stock disponible est insuffisant."

        case .productNotFound:
            return "Le produit n'existe pas."
        }
    }
}
class StockService {
   private let batchRepository : BatchRepository
   private let movementRepository : StockMovementRepository
   private let modelContext : ModelContext
   
   init(batchRepository: BatchRepository, movementRepository: StockMovementRepository, modelContext: ModelContext) {
      self.batchRepository = batchRepository
      self.movementRepository = movementRepository
      self.modelContext = modelContext
   }
   
   func addMovement(product : Product, quantity: Int, type: MovementType, expirationDate: Date, purchasePrice: Double) throws {
      
      // Validate rules
      
      guard quantity > 0 else {throw StockError.invalidQuantity }
      
      switch type {
      case .entry:
         // create new batch
         let batch = Batch(quantity: quantity, expirationDate: expirationDate, receivedDate: .now, purchasePrice: purchasePrice, product: product)
         batchRepository.insert(batch: batch)
         
      case .exit:
         guard  product.totalStock >= quantity else {throw StockError.insufficientStock}
         // Change batch quantity : take account of exit
         // by updating batch quantity
         let sortedBatches = product.batches.filter { $0.quantity > 0 }.sorted { $0.expirationDate < $1.expirationDate }
         
         var remaining = quantity
         for batch in sortedBatches {
            guard remaining > 0 else { break }
            let taken = min(batch.quantity, remaining)
            batch.quantity -= taken   // Action A : update Batch
            remaining = remaining - taken
         }
         
      }
      
      // Create Movement
      let movement = StockMovement(type: type, quantity: quantity, date: .now, product: product)
      
      movementRepository.insert(movement: movement)
      try modelContext.save()
      
   }
   
}
