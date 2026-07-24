//
//  ProductListView.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 09/07/2026.
//

import SwiftUI

struct ProductListView: View {
   
   @State private var viewModel : ProductListViewModel
   
   init(dependencyContainer: AppDependencyContainer) {
      _viewModel = State(wrappedValue: dependencyContainer.makeProductListViewModel())
   }
   var body: some View {
      NavigationStack {
         
         Group {
            switch viewModel.state {
            case .loading:
               ProgressView()
            case .loaded(let products):
               List(products) { product in
                  NavigationLink(value: product){
                     ProductRowView(product: product)
                  }
               }
             //  .listStyle(.plain)
            case .error(let error):
               ContentUnavailableView(error, systemImage: "exclamationmark.triangle")
               
            }
         }
         .navigationTitle("ProductList")
         .navigationDestination(for: Product.self) { product in
            ProductDetailView(product: product)
         }
         
      }
      .task {
         await viewModel.loadProducts()
      }

         
   
   }
}

#Preview {
   ProductListView(dependencyContainer: .preview)
}
