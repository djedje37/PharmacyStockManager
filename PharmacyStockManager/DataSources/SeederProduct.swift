//
//  SeederProduct.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 21/06/2026.
//
/// Raw representation of a single product entry as found in 'seed_products.json'
struct SeederProduct : Codable {
   let cip: String
   let name: String
   let category: String
   let publicPrice: Double
   let currentStock: Int
   let alertThreshold: Int
   let lastSaleDate: String?
   let knownExpirationDate: String?
   let reimbursementBase: Double
   let vatRate: Int              // 1 = no TVA, 2 = TVA 18%
   let purchasePrice: Double
   let geoCode: String?
}
