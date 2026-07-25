//
//  StockMovementViewModel.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 21/07/2026.
//


import SwiftData
import Foundation

@Observable
@MainActor
class StockMovementViewModel {
   
   private let stockMovementRepository : StockMovementRepository
   var state : ViewState<[StockMovement]> = .loading
   
   
   init(stockMovementRepository: StockMovementRepository) {
      self.stockMovementRepository = stockMovementRepository
   }
   
   
   func loadMovements() async {
      do {
         let movements = try stockMovementRepository.getLastMovements(number: 20)
         state = .loaded(movements)
         
      } catch {
         state = .error(error.localizedDescription)
      }
   }
}
