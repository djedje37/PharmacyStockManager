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
   
   private func sectionTitle(for date: Date) -> String {
       let calendar = Calendar.current
       if calendar.isDateInToday(date) {
           return "Aujourd'hui"
       } else if calendar.isDateInYesterday(date) {
           return "Hier"
       } else {
           return date.formatted(.dateTime.day().month(.wide).year())
       }
   }
   
    var body: some View {
       NavigationStack {
          
          Group {
             switch viewModel.state {
             case .loading:
                ProgressView()
             case .loaded(let movements):
                List {
                   ForEach(movements.groupedByDay(), id: \.date) { group in
                      Section {
                         ForEach(group.movements) { movement in
                            StockMovementRowView(stockMovement: movement)
                               .listRowBackground(
                                 RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(.secondarySystemGroupedBackground))
                                    .padding(.vertical, 8)
                               )
                               .listRowSeparator(.hidden)
                         }
                      } header: {
                         Text(sectionTitle(for: group.date))
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.secondary)
                            .textCase(nil)  
                         }
                     }
                 }
                 .listStyle(.plain)
    
             case .error(let error):
                ContentUnavailableView(error, systemImage: "arrow.up.arrow.down")
             }
          }
          .navigationTitle("Mouvements")
          .background(Color(.systemGroupedBackground))
          .navigationBarTitleDisplayMode(.inline)
          
          .toolbar {
              ToolbarItem(placement: .navigationBarLeading) {
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
