//
//  ProductFormView.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 01/08/2026.
//

import SwiftUI

struct ProductFormView: View {
   @Environment(\.dismiss) private var dismiss
   @State private var viewModel : ProductFormViewModel
   init(dependencyContainer: AppDependencyContainer, product: Product? = nil) {
      _viewModel = State(wrappedValue: dependencyContainer.makeProductFormViewModel(product: product))
   }
    var body: some View {
       NavigationStack {
           Form {
               informationSection
               pricingSection
               stockSection
               errorSection
           }
           .navigationTitle(viewModel.navigationTitle)
           .toolbar {
              ToolbarItem(placement: .confirmationAction) {
                 Button("Enregistrer") {
                    if viewModel.submit() {
                       
                       dismiss()
                    }
                 }
                 .fontWeight(.semibold)
              }
              ToolbarItem(placement: .cancellationAction) {
                 Button("Annuler") { dismiss() }
              }
         }
       }
    }
}
private extension ProductFormView {
   var informationSection: some View {
      Section("Informations") {
         TextField("Nom", text: $viewModel.name)
         
         TextField("CIP", text: $viewModel.cip)
            .disabled(viewModel.isEditing)
         
         Picker("Catégorie", selection: $viewModel.category) {
            
            ForEach(ProductCategory.allCases, id: \.self) {
               
               Text($0.rawValue)
                  .tag($0)
               
            }
            
         }
      }
   }

   var pricingSection: some View {
       Section("Prix") {
          TextField("Prix de vente", value: $viewModel.publicPrice, format: .number)
             .keyboardType(.decimalPad)

          Picker("TVA", selection: $viewModel.vatRate) {
             ForEach(VATRate.allCases, id: \.self) {
                Text($0.displayLabel)
                   .tag($0)
              }
          }
          if viewModel.vatRate != .exempt {
             TextField("Base remboursement", value: $viewModel.reimbursementBase, format: .number)
                .keyboardType(.decimalPad)
          }
       }
   }

   var stockSection: some View {
       Section("Stock") {
          TextField("Emplacement",text: $viewModel.geoCode)
          Stepper("Seuil d'alerte : \(viewModel.alertThreshold)", value: $viewModel.alertThreshold, in: 0...100)
       }
   }
   
   @ViewBuilder
   var errorSection: some View {
      if let error = viewModel.errorMessage {
         Section {
            Text(error)
            .foregroundStyle(.red)
         }
      }
   }
   
}
/*#Preview {
 ProductFormView()
 }
 */
