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
   private let columns = [GridItem(.flexible(minimum: 0), spacing: 16), GridItem(.flexible(minimum: 0), spacing: 16)]
   
   // TODO : rotation calcul is wrong
  
  // rotation : nb de vente par mois (nb de ventes sur les 3 mois / 3) : moyenne de vente mensuelle
  // stock movement type exit : on last 3 months
   var body: some View {
      ScrollView {
         LazyVGrid(columns: columns, spacing: 8) {
            
            DashboardCardView(title: "Valeur Achat", value: "\(dashboardData.stockValueAtCost.fcfaToEuro.euroFormattedInt)", icon: "eurosign.circle.fill", color: .blue, subtitle: "Prix d'achat")
            
            DashboardCardView(title: "Valeur Vente", value: "\(dashboardData.stockValueAtRetail.fcfaToEuro.euroFormattedInt)", icon: "eurosign.circle.fill", color: .green, subtitle: "Prix Vente")
            
            
            DashboardCardView(title: "Produits", value: "\(dashboardData.productCount)", icon: "pills.fill", color: .blue, subtitle: "Total référencé")
            
            DashboardCardView(title: "Rotation", value: "\(dashboardData.recentMovements.count)", icon: "chart.line.uptrend.xyaxis", color: .green, subtitle: "Ventes ce mois-ci")
            
            DashboardCardView(title: "Stock faible", value: "\(dashboardData.lowStock.count)", icon: "exclamationmark.triangle.fill", color: .orange, subtitle: "A réapprovisionner")
            
            DashboardCardView(title: "Expiration", value: "\(dashboardData.expiringBatches.count)", icon: "calendar.badge.exclamationmark", color: .red, subtitle: "Expire bientôt")
         }.padding(.horizontal, 8)
         
  
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
          Group {
             switch viewModel.state {
             case .loading:
               ProgressView()
             case .loaded(let dashboardData):
                DashboardContentView(dashboardData: dashboardData)
             case .error(let error):
                ContentUnavailableView(error, systemImage: "exclamationmark.triangle")
             }
          }
          .background(Color(.systemGroupedBackground))
          .navigationTitle("Dashboard")
       }
      
       .task {
          await viewModel.loadData()
       }
    }
}

#Preview {
   DashboardView(dependencyContainer: .preview)
}
