//
//  DashboardService.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 09/07/2026.
//



struct DashboardData {
   /// the number of different product in pharmacy
   let productCount: Int

   /// the stock value price : purchase price 
   let stockValueAtCost: Double

   let stockValueAtRetail: Double
   
   /// product where stock is low
   let lowStock: [Product]
   
   /// batchs which will be expired soon : in a month
   let expiringBatches: [Batch]
   
   /// batchs which are already expired
   let expiredBatches: [Batch]

   /// The last sales :
   let recentMovements: [StockMovement]

}


class DashboardService {
   
   private let SOON_EXPIRING_DAYS = 30
   private let LAST_STOCK_MOVEMENT_NUMBER = 5
   private let productRepository: ProductRepository
   private let batchRepository: BatchRepository
   private let stockMovementRepository: StockMovementRepository
   

   init(productRepository: ProductRepository, batchRepository: BatchRepository, stockMovementRepository: StockMovementRepository) {
      self.productRepository = productRepository
      self.batchRepository = batchRepository
      self.stockMovementRepository = stockMovementRepository
   }

   
   func getAllProducts() throws -> [Product] {
      let allProducts = try self.productRepository.fetchAll()
      return allProducts
   }
   
   /// Retrieve all needed information for dashboard
   ///  Returns - DashboardData 
   func loadDashboard() throws -> DashboardData {
      // calculate product count
      let allProducts = try self.productRepository.fetchAll()
      
      let productCount = allProducts.count
      
      var stockValueAtCost = 0.0
      var stockValueAtRetail = 0.0
      
      var lowStockProducts : [Product] = []
      for product in allProducts {
         stockValueAtCost += product.stockValueAtCost
         stockValueAtRetail += product.stockValueAtRetail
         
         if(product.isLowStock) {
            lowStockProducts.append(product)
         }
         
      }
      
      // calculate stock value
      // calculate low stock count
      // calculate expiringbatch count
      let expiringBatches = try self.batchRepository.getExpiringBatches(days: SOON_EXPIRING_DAYS)
      
      // calculate expired batch count
      let expiredBatches = try self.batchRepository.getExpiredBatches()
   
      // retrieve recent stock movements
      let recentStockMovements = try self.stockMovementRepository.getLastMovements(number: LAST_STOCK_MOVEMENT_NUMBER)
      
      return DashboardData(productCount: productCount, stockValueAtCost: stockValueAtCost, stockValueAtRetail: stockValueAtRetail, lowStock: lowStockProducts, expiringBatches: expiringBatches, expiredBatches: expiredBatches, recentMovements: recentStockMovements)
 
   }
   
}
