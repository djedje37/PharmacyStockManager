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
         
         VStack(alignment: .leading, spacing: 6) {
            Text(product.name)
               .font(.body)
               .lineLimit(1)
               .truncationMode(.tail)
            
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
         VStack(alignment: .trailing, spacing: 6) {
            Text(product.publicPrice.fcfaToEuro.euroFormatted)
               .font(.subheadline)
               .bold()
            
            Text("\(product.totalStock)")
               .font(.caption.weight(.semibold))
               .foregroundStyle(product.isLowStock ? .white : .secondary)
               .padding(.horizontal, 16)
               .padding(.vertical, 4)
               .background(product.isLowStock ? Color.orange : Color(.systemGray5),
                       in: Capsule()
                   )
            
         }
         
         
      
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(8)
   }
}
#Preview {
   ProductRowView(product: Product(cip: "8431225", name: "FEVAROL 500/2MG/5MG PL/4", category: ProductCategory.autre, reimbursementBase: 20, vatRate: VATRate.exempt, geoCode: "OT1", publicPrice: 25000.0, alertThreshold: 12))
}
