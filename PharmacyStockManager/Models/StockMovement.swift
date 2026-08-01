//
//  StockMovement.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 07/06/2026.
//

import Foundation

import SwiftData

enum MovementType: String, Codable {
    case entry
    case exit
}

@Model
class StockMovement {
   var type: MovementType
   var quantity: Int
   var date: Date
   var product: Product? // link to product instead of batch because batch => stockmovement rely to only one batch wheareas in real pharmaceutical like a movement can be rely to many batches
   
   init(type: MovementType, quantity: Int, date: Date = Date(), product: Product? = nil) {
       self.type = type
       self.quantity = quantity
       self.date = date
       self.product = product
   }

}
