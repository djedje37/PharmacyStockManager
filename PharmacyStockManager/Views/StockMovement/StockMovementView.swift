//
//  StockMovementView.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 04/07/2026.
//

import SwiftUI

struct StockMovementView: View {
   
   @State private var viewModel : StockMovementViewModel
   @State private var showingAddMovement = false
   let makeAddMovementView: () -> AddStockMovementView
   
   init(dependencyContainer : AppDependencyContainer) {
      _viewModel = State(wrappedValue: dependencyContainer.makeStockMovementViewModel())
      self.makeAddMovementView = { AddStockMovementView(dependencyContainer: dependencyContainer) }
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
          .toolbar {
              ToolbarItem(placement: .navigationBarTrailing) {
                 Button {
                    // action
                    showingAddMovement = true
                 } label : {
                    Image(systemName: "plus")
                 }
              }

          }
          
       }
      .sheet(isPresented: $showingAddMovement, onDismiss: {
         Task {
            await viewModel.loadMovements()
         }
      }) {
         makeAddMovementView()
      }
       .task {
          await viewModel.loadMovements()
       }
    }
}

/*#Preview {
    StockMovementView(dependencyContainer: .preview)
}*/
