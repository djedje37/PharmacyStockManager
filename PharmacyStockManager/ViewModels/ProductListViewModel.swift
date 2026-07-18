//
//  ProductListViewModel.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 14/06/2026.
//

import SwiftUI
import SwiftData

class ProductListViewModel: Observable {
   @Query private var products: [Product]
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}


