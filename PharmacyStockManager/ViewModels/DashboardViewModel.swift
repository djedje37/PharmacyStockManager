//
//  DashboardViewModel.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 14/06/2026.
//

import SwiftUI
import Combine

@MainActor
@Observable
class DashboardViewModel : ObservableObject {
   
   private let dashboardService : DashboardService
   
   var state: ViewState<DashboardData>  = .loading
   init(dashboardService: DashboardService) {
      self.dashboardService = dashboardService
   }
   func loadData() async {
      do {
         let dashboardData = try dashboardService.loadDashboard()
         state = .loaded(dashboardData)
         print("dashboardData", dashboardData)
      } catch {
         state = .error(error.localizedDescription)
         print("error", error)
      }
   }

}

extension DashboardData {

    var stockValueAtCostFormatted: String {
        stockValueAtCost.formatted(.currency(code: "EUR"))
    }

}
// MARK : Enum

enum DashboardState {
   case loaded(DashboardData)
   case loading
   case error(String)
}
