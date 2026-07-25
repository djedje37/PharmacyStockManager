//
//  StockMovementRowView.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 22/07/2026.
//

import SwiftUI

struct StockMovementRowView: View {
   let stockMovement: StockMovement
    var body: some View {
       HStack {
          Image(systemName: stockMovement.icon)
             .font(.title3)
             .foregroundStyle(stockMovement.color)
          
          VStack(alignment: .leading) {
             Text(stockMovement.title)
             Text(stockMovement.product?.name ?? "")
                .font(.headline)
             
             Text(stockMovement.date, style: .date)
                .font(.caption)
                .foregroundStyle(.secondary)
             
             Spacer()
             
             Text(stockMovement.quantityText)
                .foregroundStyle(stockMovement.color)
                .bold()
             
          }

       }
    }
}

#Preview {
   StockMovementRowView(stockMovement: StockMovement(type: MovementType.entry, quantity: 2))
}
