//
//  BatchGenerationService.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 14/06/2026.
//

import Foundation


struct BatchPlan {
   let quantity: Int
   let receivedDate: Date
   let expirationDate: Date
   let purchasePrice: Double
}


/// Generate expiration profile when unknown expiration date
enum ExpirationProfile : CaseIterable {
   case expired, soon, normal
   
   static func random() -> ExpirationProfile {
       let randomInt = Int.random(in: 0...10)
       if randomInt < 3 { return .expired }
       if randomInt < 5 { return .soon }
       return .normal
   }
}

struct BatchGenerationService {
   init() {
      
   }
   
   // MARK: Functions
   /// function to generate a random batch count
   ///  - Parameters :
   ///    - stock: the stock number of the product
   func generateRandomBatchCount(stock: Int) -> Int {
      var batchCount : Int
      switch stock {
      case 1...3:
         batchCount = 1
         break
      case 4...15:
         batchCount = Int.random(in: 1...2)
         
      default:
         batchCount = Int.random(in: 3...4)
      }
      
      return batchCount
   }
   /// function to generate for each batch a random quantity of product
   ///  - Parameters :
   ///    - stock: the stock number of the product
   ///    - batchCount: the number of batch for the product
   ///  - Returns:
   ///    - quantities: array of int - corresponding to quantity for each batch
   func generateRandomQuantityforBatch(stock: Int, batchCount: Int) -> [Int] {
      var remainingStock = stock
      
      var quantities : [Int] = []
      
      for i in 0..<batchCount {
         if (i == batchCount - 1) { // last batch
            quantities.append(remainingStock)
         } else {
            let share = max(1, Int.random(in: 1...max(1, remainingStock/2))) // number between 1 and half of remainingStock
            quantities.append(share)
            
            remainingStock = remainingStock - share
         }
      }
      return quantities
   }
   
   /// function to generate a mock credible batchs for each product
   ///  - Parameters :
   ///    - stock: the stock number of the product
   ///    - purchasePrice: the purchase price of the product
   ///    - knowExpirationDate: known expiration date for the first batch
   ///  - Returns:
   ///    - [BatchPlan]: array of BatchPlan - corresponding to generated batch for the product 
   func generatePlans(stock: Int, purchasePrice: Double, knowExpirationDate: Date?) -> [BatchPlan] {
      
      var batchPlanArray: [BatchPlan] = []
      
      // when stock <= 0 => no batch plan
      guard stock > 0 else { return batchPlanArray }
      
      let calendar = Calendar.current
      let today = Date()
      let batchCount = generateRandomBatchCount(stock: stock)
      
      
      let quantities : [Int] = generateRandomQuantityforBatch(stock: stock, batchCount: batchCount)
      
  
      batchPlanArray = quantities.enumerated().map { index, quantity in
         let expirationDate: Date
         let oneDayTimeInterval : TimeInterval = (24 * 60 * 60)
         if let known = knowExpirationDate, index == 0 { // if first batch and expiration date exist take it
            expirationDate = known
         } else { // generate random expiration date
            switch ExpirationProfile.random(){
            case .expired:
               expirationDate = calendar.date(byAdding: .day, value: -Int.random(in: 5...90), to: today) ?? today.addingTimeInterval(-oneDayTimeInterval)
               break
            case .soon:
               expirationDate = calendar.date(byAdding: .day, value: Int.random(in: 1...29), to: today) ?? today.addingTimeInterval(oneDayTimeInterval)
               break
               
            case .normal:
               expirationDate = calendar.date(byAdding: .day, value: Int.random(in: 90...900), to: today) ?? today.addingTimeInterval(30 * oneDayTimeInterval)
               break
               
            }
         }
         
         // try to generate a credible reception date
         // reception max one year ago
         
         let differenceExpirationCurrentDate = calendar.dateComponents([.day], from: today, to: expirationDate)
         // contain max 30 days in the futur
         let maxReceiveDay = min(360, max(30, differenceExpirationCurrentDate.day ?? 30))
         
         // So finally receive date contains a random value 10 to 30 days before the current day
         let receivedDate = calendar.date(byAdding: .day, value: -Int.random(in: 10...maxReceiveDay), to: today) ?? today.addingTimeInterval(-2 * oneDayTimeInterval)

         return BatchPlan(
                         quantity: quantity,
                         receivedDate: receivedDate,
                         expirationDate: expirationDate,
                         purchasePrice: purchasePrice
                     )
         
      }
      
      return batchPlanArray
      
   }
}
