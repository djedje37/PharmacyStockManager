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
            case .loaded(_):
               
               if(viewModel.filterProducts.isEmpty) {
                  if (viewModel.searchText.isEmpty) {
                     ContentUnavailableView("Aucun Produit", systemImage: "pills")
                  } else {
                     ContentUnavailableView.search(text: viewModel.searchText)
                  }
               } else {
                  List(viewModel.filterProducts) { product in
                     NavigationLink(value: product){
                        ProductRowView(product: product)
                     }
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
         .searchable(text: $viewModel.searchText, prompt: "Rechercher un produit")
         
      }
      .task {
         await viewModel.loadProducts()
      }

         
   
   }
}

#Preview {
   ProductListView(dependencyContainer: .preview)
}
