//
//  AppDependencyContainer.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 05/07/2026.
//

import SwiftData


class AppDependencyContainer {
   
   let modelContext: ModelContext
   
   init(modelContext: ModelContext) {
      self.modelContext = modelContext
   }

   
   // MARK: Repositories
   private lazy var productRepository: ProductRepository = ProductRepository(context: modelContext)

   
   private lazy var batchRepository = BatchRepository(context: modelContext)
   
   
   private lazy var stockMovementRepository =  StockMovementRepository(context: modelContext)
   
   
   // MARK: - Services
   private lazy var dashboardService: DashboardService = DashboardService(
           productRepository: productRepository,
           batchRepository: batchRepository,
           stockMovementRepository: stockMovementRepository
      )
   
   
   private lazy var stockService: StockService = StockService(batchRepository: batchRepository, movementRepository: stockMovementRepository, modelContext: modelContext)
   // MARK: - Factories for ViewModels

   func makeDashboardViewModel() -> DashboardViewModel {
      DashboardViewModel(dashboardService: dashboardService)
   }

   func makeProductListViewModel() -> ProductListViewModel {
      ProductListViewModel(productRepository: productRepository)
   }
   
   func makeStockMovementViewModel() -> StockMovementViewModel {
      StockMovementViewModel(stockMovementRepository: stockMovementRepository)
   }
   
   func makeAddMovementViewModel() -> AddMovementViewModel {
       AddMovementViewModel(stockService: stockService)
   }
   
   func makeProductFormViewModel(product: Product? = nil) -> ProductFormViewModel {
      ProductFormViewModel(
           productRepository: productRepository,
           existingProduct: product
       )
   }
   
}

extension AppDependencyContainer {
    /// Container backed by an in-memory SwiftData store, for use in SwiftUI previews only.
    static var preview: AppDependencyContainer {
        let container = try! ModelContainer(
            for: Product.self, Batch.self, StockMovement.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        return AppDependencyContainer(modelContext: container.mainContext)
    }
}
