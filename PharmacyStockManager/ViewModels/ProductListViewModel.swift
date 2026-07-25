//
//  ProductListViewModel.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 14/06/2026.
//

import SwiftData
import Foundation


enum ProductFilter: String, CaseIterable {
    case all = "Tous"
    case lowStock = "Stock faible"
    case expiringSoon = "Péremption proche"
    case reimbursed = "Remboursé"
}

@Observable
@MainActor
class ProductListViewModel {
   
   private let productRepository : ProductRepository
   var state: ViewState<[Product]> = .loading
   
   var searchText: String = ""
   var activeFilter: ProductFilter = .reimbursed
   
   var selectedCategory: ProductCategory? // nil => all catgories
   
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
      
      var results = products

      if let selectedCategory {
         results = results.filter { $0.category == selectedCategory }
      }

      switch activeFilter {
      case .all:
         break
      case .lowStock:
         results = results.filter(\.isLowStock)
      case .expiringSoon:
         let cutoff = Calendar.current.date(byAdding: .day, value: 30, to: .now) ?? .now
         results = results.filter { ($0.nearestExpiration ?? .distantFuture) <= cutoff }

      case .reimbursed:
         results = results.filter(\.isReimbursed)
      }
      
      
      if (!searchText.isEmpty) {
         results = results.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.cip.contains(searchText)
            
         }
      }
      
      
      return results

   }

}


