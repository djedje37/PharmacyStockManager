//
//  ProductSeeder.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 08/07/2026.
//

import Foundation
import SwiftData


struct ProductSeeder {
   
   
   private let context: ModelContext
   private let dataSource: JSONProductDataSource
   private let batchGenerator: BatchGenerationService

   init(
       context: ModelContext,
       dataSource: JSONProductDataSource = JSONProductDataSource(),
       batchGenerator: BatchGenerationService = BatchGenerationService()
   ) {
       self.context = context
       self.dataSource = dataSource
       self.batchGenerator = batchGenerator
   }

   func seedIfNeeded() throws {
      print("Database seedIfNeeded seeded")
       let existingCount = try context.fetchCount(FetchDescriptor<Product>())

       guard existingCount == 0 else {
           print("Database already seeded")
           return
       }

       let seedProducts = try dataSource.loadProducts()

       for seed in seedProducts {
          print("seed seed", seed)
           try insert(seed)
       }
      print("Database seeded finish")
       try context.save()
   }
   
   private func insert(_ seed: SeederProduct) throws {

       let category = ProductCategory(rawValue: seed.category) ?? .autre
       let vatRate = VATRate(rawValue: seed.vatRate) ?? .exempt

       let product = Product(
           cip: seed.cip,
           name: seed.name,
           category: category,
           reimbursementBase: seed.reimbursementBase,
           vatRate: vatRate,
           geoCode: seed.geoCode,
           publicPrice: seed.publicPrice,
           alertThreshold: seed.alertThreshold
       )

       context.insert(product)

       let expirationDate = seed.knownExpirationDate.flatMap {
           DateFormatter.seedDateFormat.date(from: $0)
       }

       let batchPlans = batchGenerator.generatePlans(
           stock: seed.currentStock,
           purchasePrice: seed.purchasePrice,
           knowExpirationDate: expirationDate
       )

       for plan in batchPlans {

           let batch = Batch(
               quantity: plan.quantity,
               expirationDate: plan.expirationDate,
               receivedDate: plan.receivedDate,
               purchasePrice: plan.purchasePrice
           )

           batch.product = product

           context.insert(batch)
       }

      if let lastSaleString = seed.lastSaleDate,
         let lastSaleDate = DateFormatter.seedDateFormat.date(from: lastSaleString) {
          let movement = StockMovement(type: .exit, quantity: 1, date: lastSaleDate, product: product)
          context.insert(movement)
      }

   }
   
   
/*   static func seedIfNeeded(context: ModelContext) {
      let existingCount = (try? context.fetchCount(FetchDescriptor<Product>())) ?? 0
      
      guard existingCount == 0 else {
         print("DB already initialized \(existingCount) products in database")
         return
      }
      
      do {
         let seedProducts = try SeedLoader.loadSeedProducts()
         for seedProduct in seedProducts {
            insert(seedProduct, into: context)
           
         }
         try context.save()
         print("Seed end: \(seedProducts.count) products inserted")
      } catch {
         print("Error on seeder \(error)")
      }
      
   }
   
   private static func insert(_ seed: SeederProduct, into context: ModelContext) {
      let category = ProductCategory(rawValue: seed.category) ?? .autre
      let vatRate = VATRate(rawValue: seed.vatRate) ?? .exempt
      
      let product = Product(
         cip: seed.cip,
         name: seed.name,
         category: category,
         reimbursementBase: seed.reimbursementBase,
         vatRate: vatRate,
         geoCode: seed.geoCode,
         publicPrice: seed.publicPrice,
         alertThreshold: seed.alertThreshold
      )
      context.insert(product)
      
      var knowExpirationDate  : Date?
      if let knownExpirationDateString = seed.knownExpirationDate {
         knowExpirationDate = DateFormatter.seedDateFormat.date(from: knownExpirationDateString)
      }
      
      let batchsPlans = BatchGenerator.generatePlans(
          stock: seed.currentStock,
          purchasePrice: seed.purchasePrice,
          knowExpirationDate: knowExpirationDate
      )
      for batchsPlan in batchsPlans {
          let batch = Batch(
              quantity: batchsPlan.quantity,
              expirationDate: batchsPlan.expirationDate,
              receivedDate: batchsPlan.receivedDate,
              purchasePrice: batchsPlan.purchasePrice
          )
          batch.product = product
          context.insert(batch)
      }
      
      if let lastSaleString = seed.lastSaleDate,
         let lastSaleDate = DateFormatter.seedDateFormat.date(from: lastSaleString) {
          let movement = StockMovement(type: .exit, quantity: 1, date: lastSaleDate, product: product)
          context.insert(movement)
      }
   }*/
}
