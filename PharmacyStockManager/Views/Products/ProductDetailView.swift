//
//  ProductDetailView.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 19/07/2026.
//

import SwiftUI
struct ProductDetailView : View {
   let product: Product
   var body : some View {
      List {
         /// Information section
         Section {
            LabeledContent("Nom", value: product.name)
            LabeledContent("CIP", value: product.cip)
            LabeledContent("Catégorie", value: product.category.rawValue)
            if let geoCode = product.geoCode {
                LabeledContent("Emplacement", value: geoCode)
            }
         } header: {
            Label("Informations", systemImage: "info.circle")
         }
         /// Price section
         Section {
            LabeledContent("Prix de vente", value: product.publicPrice.fcfaToEuro.euroFormatted)
            LabeledContent("Prix d'achat moyen", value: (product.averagePurchasePrice).fcfaToEuro.euroFormatted)
            
         
            LabeledContent("TVA", value: product.vatRate == .exempt ? "Exonéré" : "18%")
            
            if(product.isReimbursed) {
               LabeledContent("Base de remboursement", value: product.reimbursementBase.fcfaToEuro.euroFormatted)
            }
         } header: {
            Label("Prix",systemImage: "eurosign.circle")
         }
         
         /// Rotation
         Section {
            LabeledContent("Vendu (90 derniers jours)", value: "\(product.unitsSold(overLastDays: 90))" )
            LabeledContent("Rythme moyen", value: "\(product.rotationRate(overLastDays: 90))" )
         } header: {
            Label("Rotation", systemImage: "arrow.trianglehead.clockwise.rotate.90")
         }
         /// Stock Section
         Section {
            LabeledContent("Quantité totale", value: "\(product.totalStock)")
               .foregroundStyle((product.isLowStock) ? .red : .primary)
            LabeledContent("Seuil d'alerte", value: "\(product.alertThreshold)")
            LabeledContent("Valeur (coût)", value: product.stockValueAtCost.fcfaToEuro.euroFormatted)
            LabeledContent("Valeur (vente)", value: product.stockValueAtRetail.fcfaToEuro.euroFormatted)
                    
         } header: {
            Label("Stock", systemImage: "shippingbox.circle")
         }
         
         /// Expiration
         if let nearestExpiration = product.nearestExpiration {
            Section {
               LabeledContent("Lot le plus proche") {
                  Text(nearestExpiration, style: .date)
                     .foregroundStyle( (nearestExpiration > .now) ? .primary : Color.red)
               }
            } header: {
               Label("Péremption", systemImage: "calendar.badge.exclamationmark")
            }
            
         }
         /// Batches
         Section {
            ForEach(product.batches.filter {$0.quantity > 0} ) { batch in
               VStack(alignment: .leading) {
                  HStack {
                     Text("Lot du:  \(Text(batch.receivedDate, style: .date))")
                     Spacer()
                     Text("\(batch.quantity)" + " unité(s)")
                  }
                  let isExpired = batch.expirationDate < .now
                  let expiredText = isExpired ? "Expiré depuis" : "Expire dans"
                  Text("\(expiredText) \(Text(batch.expirationDate, style: .relative))")
                  
                     .foregroundStyle(isExpired ? .red : .secondary)
               }
               
            }
         } header: {
            Label("Lots", systemImage: "archivebox.circle")
         }
         
      }
      .navigationTitle(product.name)
      .navigationBarTitleDisplayMode(.inline)
   }
}

#Preview {
   ProductDetailView(product: Product(cip: "8431225", name: "FEVAROL 500/2MG/5MG PL/4", category: ProductCategory.autre, reimbursementBase: 0, vatRate: VATRate.exempt, geoCode: "OT1", publicPrice: 25000.0, alertThreshold: 12))
}
