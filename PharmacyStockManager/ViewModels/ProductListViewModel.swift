//
//  ProductListViewModel.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 14/06/2026.
//

import SwiftData
import Foundation


@Observable
@MainActor
class ProductListViewModel {
   
   private let productRepository : ProductRepository
   var state: ViewState<[Product]> = .loading
   init(productRepository: ProductRepository) {
      self.productRepository = productRepository
   }
   
   func loadProducts() async {
      do {
         let product = try productRepository.fetchAll()
         state = .loaded(product)
         
      } catch {
         state = .error(error.localizedDescription)
      }
   }

}


