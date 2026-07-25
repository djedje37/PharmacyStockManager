//
//  StockMovementView.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 04/07/2026.
//

import SwiftUI

struct StockMovementView: View {
   
   @State private var viewModel : StockMovementViewModel
   
   init(dependencyContainer : AppDependencyContainer) {
      _viewModel = State(wrappedValue: dependencyContainer.makeStockMovementViewModel())
   }
    var body: some View {
       NavigationStack {
          
          Group {
             switch viewModel.state {
             case .loading:
                ProgressView()
             case .loaded(let movements):
                List {
                   ForEach(movements) { movement in
                      
                      StockMovementRowView(stockMovement: movement)
                   }
                }
                .listStyle(.plain)
    
             case .error(let error):
                ContentUnavailableView(error, systemImage: "arrow.up.arrow.down")
             }
          }
          .navigationTitle("Mouvements")
          
       }
       .task {
          await viewModel.loadMovements()
       }
    }
}

#Preview {
    StockMovementView(dependencyContainer: .preview)
}
