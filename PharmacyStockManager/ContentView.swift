//
//  ContentView.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 06/06/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
   @Environment(\.modelContext) private var modelContext
   let appDependencyContainer: AppDependencyContainer
   @Query private var products: [Product]
   var body: some View {
      TabView {
         DashboardView(dependencyContainer: appDependencyContainer)
            .tabItem {
               Label("Dashboard", systemImage: "chart.pie")
            }
         ProductListView()
            .tabItem {
               Label("Products", systemImage: "pills")
            }
         
         StockMovementView()
            .tabItem {
               Label("Movements", systemImage: "pills")
            }
         
         SettingsView()
            .tabItem {
               Label("Settings", systemImage: "settings")
            }
         
      }
   }
}

#Preview {
   ContentView(appDependencyContainer: .preview)
        .modelContainer(for: Product.self, inMemory: true)
}
