//
//  PharmacyStockManagerApp.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 06/06/2026.
//

import SwiftUI
import SwiftData

@main
struct PharmacyStockManagerApp: App {
   
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
         Product.self,Batch.self, StockMovement.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
   init() {
       let context = ModelContext(sharedModelContainer)
       let seeder = ProductSeeder(context: context)
       try? seeder.seedIfNeeded()
   }
    var body: some Scene {
        WindowGroup {
           ContentView(appDependencyContainer: AppDependencyContainer(modelContext: sharedModelContainer.mainContext))
            
        }
        .modelContainer(sharedModelContainer)
       
    }
}
