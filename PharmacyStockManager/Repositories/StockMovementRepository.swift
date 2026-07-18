//
//  StockMovementRepository.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 09/07/2026.
//

import SwiftData
import Foundation

class StockMovementRepository {
   private let context: ModelContext
   init(context: ModelContext) {
      self.context = context
   }
   
   func fetchAll() throws -> [StockMovement] {
      try context.fetch(FetchDescriptor<StockMovement>())
   }
   
   /// retrieve the last stock movements
   ///  Parameters:
   ///   - number: Int , correspond to th number of stock movement we want
   ///   Returns:
   ///   - [StockMovement] : Array of last StockMovement
   func getLastMovements(number: Int) throws -> [StockMovement] {
      
      let lastStockMovements : [StockMovement]
      
      let stockMovememnts = try self.fetchAll()
      
      var descriptor = FetchDescriptor<StockMovement>(sortBy: [
         SortDescriptor(\.date, order: .reverse)])
      
      descriptor.fetchLimit = number
      return try context.fetch(descriptor)

   }
   
   
}
