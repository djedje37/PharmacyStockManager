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
   var product: Product?
   
   init(type: MovementType, quantity: Int, date: Date = Date(), product: Product? = nil) {
       self.type = type
       self.quantity = quantity
       self.date = date
       self.product = product
   }

}
