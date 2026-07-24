//
//  ProductRowView.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 19/07/2026.
//

import SwiftUI
struct ProductRowView : View {
   
   let product: Product
   
   var body : some View {
      HStack(spacing: 8) {
         
         VStack(alignment: .leading, spacing: 4) {
            Text(product.name)
               .font(.body)
               .lineLimit(1)
            
            HStack(spacing: 4) {
               Text(product.category.rawValue)
                  .font(.caption)
                  .foregroundStyle(.secondary)
               
               if(product.isReimbursed) {
                  Label("Remboursé", systemImage: "checkmark.seal.fill")
                     .font(.caption2)
                     .foregroundStyle(.green)
                     .labelStyle(.iconOnly)
               }
            }
         }
         Spacer()
         VStack(alignment: .trailing, spacing: 4) {
            Text(product.publicPrice.fcfaToEuro.euroFormatted)
               .font(.subheadline)
               .bold()
            
            Text("\(product.totalStock) en stock")
               .font(.caption)
               .foregroundStyle(product.isLowStock ? .orange : .secondary)
            
         }
         
         
      
      }
   }
}
#Preview {
   ProductRowView(product: Product(cip: "8431225", name: "FEVAROL 500/2MG/5MG PL/4", category: ProductCategory.autre, reimbursementBase: 0, vatRate: VATRate.exempt, geoCode: "OT1", publicPrice: 25000.0, alertThreshold: 12))
}
