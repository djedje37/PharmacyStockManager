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
   
   var searchText: String = ""
   
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

   var filterProducts: [Product] {
      guard case .loaded(let products) = state else {
         return []
      }

      if searchText.isEmpty {
         return products
      } else {
         return products.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.cip.contains(searchText)
            
         }
      }
   }

}


