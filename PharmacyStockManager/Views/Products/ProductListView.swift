//
//  ProductListView.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 09/07/2026.
//

import SwiftUI

struct ProductListView: View {
   
   @State private var viewModel : ProductListViewModel
   @State private var showingAddProduct : Bool = false
   
   
   let makeProductFormView: (Product?) -> ProductFormView
   let dependencyContainer : AppDependencyContainer
   init(dependencyContainer: AppDependencyContainer) {
      _viewModel = State(wrappedValue: dependencyContainer.makeProductListViewModel())
      
      
      self.dependencyContainer = dependencyContainer
      self.makeProductFormView = { product in
         ProductFormView(dependencyContainer: dependencyContainer, product: product)
      }
   }
   
   private var filterChips: some View {
      ScrollViewReader { proxy in
         ScrollView(.horizontal, showsIndicators: false) {
             HStack(spacing: 8) {
                 ForEach(ProductFilter.allCases, id: \.self) { filter in
                     FilterChip(
                         title: filter.rawValue,
                         isSelected: viewModel.activeFilter == filter
                     ) {
                         viewModel.activeFilter = filter
                     }
                 }
             }
             .padding(.horizontal, 16)
             .padding(.vertical, 8)
         }
         .onChange(of: viewModel.activeFilter, { _, newFilter in
            withAnimation(.easeInOut(duration: 0.3)) {
               proxy.scrollTo(newFilter, anchor: .center)
            }
            
            
         })
         .onAppear() {
            DispatchQueue.main.async {
               withAnimation(.easeInOut(duration: 0.3)) {
                  proxy.scrollTo(viewModel.activeFilter, anchor: .center)
               }
            }
         }
         
      }

   }
   
   private var productList: some View {
      List(viewModel.filterProducts) { product in
         NavigationLink(value: product) {
            ProductRowView(product: product)
         }
         .listRowBackground(RoundedRectangle(cornerRadius: 16)
            .fill(Color(.secondarySystemGroupedBackground))
            .padding(.vertical, 8))
         .listRowSeparator(.hidden)
      }
      .listStyle(.plain)
   }
   
   var body: some View {
      NavigationStack {
         
         filterChips
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
                  productList
               }
               
             //  .listStyle(.plain)
            case .error(let error):
               ContentUnavailableView(error, systemImage: "exclamationmark.triangle")
               
            }
         }
         .navigationTitle("ProductList")
         .navigationDestination(for: Product.self) { product in
            ProductDetailView(dependencyContainer: dependencyContainer, product: product)
         }
         .searchable(text: $viewModel.searchText, prompt: "Rechercher un produit")
         .toolbar {
            
            ToolbarItem(placement: .topBarLeading) {
               Button {
                  // action
                  showingAddProduct = true
               } label : {
                  Image(systemName: "plus")
               }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
               Menu {
                  Button("Toutes les catégories") {
                     viewModel.selectedCategory = nil
                  }
                  
                  Divider()
                  
                  ForEach(ProductCategory.allCases, id: \.self) { category in
                     Button {
                        viewModel.selectedCategory = category
                     } label : {
                        if (viewModel.selectedCategory == category) {
                           Label(category.rawValue, systemImage: "checkmark")
                        } else {
                           Text(category.rawValue)
                        }
                     }
                     
                  }
               } label: {
                  Image(systemName: viewModel.selectedCategory == nil ? "line.3.horizontal.decrease.circle" : "line.3.horizontal.decrease.circle.fill")
               }
            }
         }
         .sheet(isPresented: $showingAddProduct, onDismiss: {
            Task {
               await viewModel.loadProducts()
            }
         }){
            makeProductFormView(nil)
         }
      }
      .task {
         await viewModel.loadProducts()
      }

   }
}

/*#Preview {
   ProductListView(dependencyContainer: .preview)
}
*/
