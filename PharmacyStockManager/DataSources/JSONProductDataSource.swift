//
//  JSONProductDataSource.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 21/06/2026.
//

import Foundation

enum JSONProductDataSourceError: Error {
    case fileNotFound
    case decodingFailed(Error)
}

struct JSONProductDataSource {
   init() {}
   
   func loadProducts() throws -> [SeederProduct]{
      guard let url = Bundle.main.url(forResource: "seed_products", withExtension: "json") else {
         throw JSONProductDataSourceError.fileNotFound
      }
      
      do {
         let data = try Data(contentsOf: url)
         let decoder = JSONDecoder()
         let response = try decoder.decode([SeederProduct].self, from: data)
         return response
      } catch {
         throw JSONProductDataSourceError.decodingFailed(error)
      }
      
   }
}
