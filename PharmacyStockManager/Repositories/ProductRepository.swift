//
//  ProductRepository.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 08/07/2026.
//

import SwiftData
import Foundation

class ProductRepository {
   private let context: ModelContext
   init(context: ModelContext) {
      self.context = context
   }

   // METHODS: CRUD
   func fetchAll() throws -> [Product] {
      try context.fetch(FetchDescriptor<Product>())
   }
   
   func insert(_ product: Product) {
      context.insert(product)
   }
   
   
   func add(_ product: Product) throws {
      context.insert(product)
      try context.save()
   }
   
   
   func delete(_ product: Product) throws {
      context.delete(product)
      try context.save()
   }
   
   func save() throws {
      try context.save()
   }
   
   // Methods:
   
   func countProducts() throws -> Int {
      try context.fetchCount(FetchDescriptor<Product>())
   }
   
   func exists(cip: String) throws -> Bool {
      let descriptor = FetchDescriptor<Product>(predicate: #Predicate { $0.cip == cip })
      return try context.fetchCount(descriptor) > 0
   }
   
   
   // TODO: implement
 /*  func search(name: String) throws -> [Product]

     func fetchLowStockProducts() throws -> [Product]

     func fetchExpiringProducts(before date: Date) throws -> [Product]
*/

   
   
}
