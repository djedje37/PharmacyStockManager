//
//  BatchRepository.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 09/07/2026.
//

import SwiftData
import Foundation

class BatchRepository {
   private let context: ModelContext
   init(context: ModelContext) {
      self.context = context
   }
   
   func fetchAll() throws -> [Batch] {
      try context.fetch(FetchDescriptor<Batch>())
   }
   
   /// retrieve batches which will be expired soon
   ///  Parameters:
   ///   - days: Int, limit in number of day
   ///  Returns:
   /// - [Batch]  : array of batches corresponding to the search
   func getExpiringBatches(days: Int) throws -> [Batch] {
      let today = Date()
      let calendar = Calendar.current
      
      let limitDate = calendar.date(byAdding: .day, value: days, to: today) ?? today
      
      
      let predicate = #Predicate<Batch> {
         $0.expirationDate >= today &&
         $0.expirationDate < limitDate
      }
      
      let descriptor = FetchDescriptor<Batch>(predicate: predicate)
      
      
      return try context.fetch(descriptor)
      
      
   }
   
   
   /// retrieve batches which have been expired 
   ///  Returns:
   /// - [Batch]  : array of batches corresponding to the search
   func getExpiredBatches() throws -> [Batch] {
      let today = Date()
      let calendar = Calendar.current
      

      let predicate = #Predicate<Batch> {
         $0.expirationDate < today
      }
      
      let descriptor = FetchDescriptor<Batch>(predicate: predicate)
      
      
      return try context.fetch(descriptor)
      
      
   }
   
}
