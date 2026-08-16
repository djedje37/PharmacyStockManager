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
           .toolbar {
              ToolbarItem(placement: .confirmationAction) {
                 Button {
                    if viewModel.submit() {
                       dismiss()
                    }
                 } label: {
                    Image(systemName: "checkmark")
                       .foregroundStyle(.white)
                 }
                 .buttonStyle(.borderedProminent)
                 .disabled(viewModel.isSubmitDisabled)
              }
              ToolbarItem(placement: .cancellationAction) {
                 Button {
                    dismiss()
                    
                 } label: {
                    Image(systemName: "xmark")
                 }
              }
         }
       }
       .formStyle(.grouped)
       .scrollDismissesKeyboard(.interactively)
       .scrollContentBackground(.hidden)
       .navigationTitle(viewModel.navigationTitle)
       .navigationBarTitleDisplayMode(.inline)
       .background(Color(.systemGroupedBackground))
    }
}
private extension ProductFormView {
   var informationSection: some View {
      Section("Informations") {
         LabeledContent("Nom") {
            TextField("", text: $viewModel.name)
               .multilineTextAlignment(.trailing)
               .lineLimit(1)
               .submitLabel(.next)
         }
         
         LabeledContent("CIP") {
            TextField("", text: $viewModel.cip)
               .multilineTextAlignment(.trailing)
               .lineLimit(1)
               .submitLabel(.next)
               .disabled(viewModel.isEditing)
         }
         
         LabeledContent("Catégorie") {
            Picker("", selection: $viewModel.category) {
               ForEach(ProductCategory.allCases, id: \.self) {
                  Text($0.rawValue)
                     .tag($0)
               }
            }

         }
         
         
         
         
      }
   }

   var pricingSection: some View {
       Section("Prix") {
          LabeledContent("Prix de vente") {
             TextField("0", value: $viewModel.publicPrice, format: .currency(code: "EUR"))
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
                .lineLimit(1)
                .submitLabel(.next)
          }
          

          LabeledContent("TVA") {
             Picker("TVA", selection: $viewModel.vatRate) {
                ForEach(VATRate.allCases, id: \.self) {
                   Text($0.displayLabel)
                      .tag($0)
                 }
             }
             .labelsHidden()
          }
          
          LabeledContent("Base remboursement") {
             TextField("0", value: $viewModel.reimbursementBase, format: .currency(code: "EUR"))
                .multilineTextAlignment(.trailing)
                .lineLimit(1)
                .keyboardType(.decimalPad)
          }
       }
   }

   var stockSection: some View {
      Section("Stock") {
         LabeledContent("Emplacement") {
            TextField("",text: $viewModel.geoCode)
               .textInputAutocapitalization(.characters)
               .multilineTextAlignment(.trailing)
               .lineLimit(1)
         }
         Stepper("Seuil d'alerte : \(viewModel.alertThreshold)", value: $viewModel.alertThreshold, in: 0...100)
      }
         
   }
   
   @ViewBuilder
   var errorSection: some View {
      if let error = viewModel.errorMessage {
         Section {
            Label(error, systemImage: "exclamationmark.triangle.fill")
               .foregroundStyle(.red)
         }
      }
   }
   
}
/*#Preview {
 ProductFormView()
 }
 */
