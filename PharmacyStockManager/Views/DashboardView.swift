//
//  DashboardView.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 04/07/2026.
//

import SwiftUI
import SwiftData


struct DashboardContentView: View {
   let dashboardData: DashboardData
   private let columns = [GridItem(.flexible()), GridItem(.flexible())]
   
   
   var body: some View {
      ScrollView {
         LazyVGrid(columns: columns, spacing: 16) {
            
            DashboardCardView(title: "Produits", value: "\(dashboardData.productCount)", icon: "pills.fill", color: .blue)
            
            DashboardCardView(title: "Valeur Achat", value: "\(dashboardData.stockValueAtCostFormatted)", icon: "eurosign.circle.fill", color: .green)
            
            DashboardCardView(title: "Valeur Vente", value: "\(dashboardData.stockValueAtRetail)", icon: "eurosign.circle.fill", color: .green)
            

            
            DashboardCardView(title: "Stock faible", value: "\(dashboardData.lowStock.count)", icon: "exclamationmark.triangle.fill", color: .orange)
            
            
            DashboardCardView(title: "Expiration", value: "\(dashboardData.expiringBatches.count)", icon: "calendar.badge.exclamationmark", color: .red)
            
            DashboardCardView(title: "Rotation", value: "\(dashboardData.recentMovements.count)", icon: "eurosign.circle.fill", color: .green)
            
         }
      }
   }
}
struct DashboardView: View {
   @State private var viewModel: DashboardViewModel
 
   init(dependencyContainer: AppDependencyContainer) {
      _viewModel = State(wrappedValue: dependencyContainer.makeDashboardViewModel())
   }
    var body: some View {
       NavigationStack {
          switch viewModel.state {
          case .loading:
            ProgressView()
          case .loaded(let dashboardData):
             DashboardContentView(dashboardData: dashboardData)
          case .error(let error):
             ContentUnavailableView(error, systemImage: "exclamationmark.triangle")
          }
          
       }
       .navigationTitle("Dashboard")
       .task {
          await viewModel.loadData()
       }
    }
}

#Preview {
   DashboardView(dependencyContainer: .preview)
}
