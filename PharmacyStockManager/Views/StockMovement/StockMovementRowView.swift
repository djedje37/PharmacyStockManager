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
      
       HStack{
          Image(systemName: stockMovement.icon)
             .font(.headline.weight(.semibold))
             .foregroundStyle(stockMovement.color)
             .padding(12)
             .background(RoundedRectangle(cornerRadius: 10).fill(stockMovement.color.opacity(0.15)))
 
          VStack(alignment: .leading, spacing: 4) {
             Text(stockMovement.title)
                .font(.subheadline)
                .foregroundStyle(stockMovement.color)
             
             Text(stockMovement.product?.name ?? "")
                .font(.headline)
                .foregroundStyle(.primary)
                .lineLimit(2)
    
          }
          Spacer()
          Text(stockMovement.quantityText)
             .font(.subheadline.weight(.semibold))
             .multilineTextAlignment(.center)
             .padding(6)
             .background(RoundedRectangle(cornerRadius: 10).fill(stockMovement.color.opacity(0.15)))
             .foregroundStyle(stockMovement.color)

       }
    }
}
private func makePreviewMovement() -> StockMovement {
    let product = Product(
        cip: "8431225",
        name: "FEVAROL 500/2MG/5MG PL/4",
        category: .autre,
        reimbursementBase: 20,
        vatRate: .exempt,
        geoCode: "OT1",
        publicPrice: 25000.0,
        alertThreshold: 12
    )
    let movement = StockMovement(type: .entry, quantity: 2)
    movement.product = product
    return movement
}
#Preview{
   StockMovementRowView(stockMovement: makePreviewMovement()).padding()
      .previewLayout(.sizeThatFits)
}
