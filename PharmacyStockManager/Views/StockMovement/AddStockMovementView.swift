//
//  AddStockMovementView.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 25/07/2026.
//

import SwiftUI
import SwiftData

struct AddStockMovementView: View {
   @Environment(\.dismiss) private var dismiss
   @State private var viewModel: AddMovementViewModel
   @Query private var products: [Product]
   
   init(dependencyContainer: AppDependencyContainer) {
      _viewModel = State(wrappedValue: dependencyContainer.makeAddMovementViewModel())
      UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.accentColor)
        // text color for selected/unselected states
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor(Color.white)], for: .selected
        )
   }
   
   var body: some View {
      NavigationStack {
         Picker("Type", selection: $viewModel.movementType) {
            Text("Réception").tag(MovementType.entry)
            Text("Vente").tag(MovementType.exit)
         }
         .pickerStyle(.segmented)
         
         Form {
            LabeledContent("Produit") {
               Picker("", selection: $viewModel.selectedProduct) {
                  Text("Sélectionner...").tag(Product?.none)
                  ForEach(products) { product in
                     Text(product.name).tag(Product?.some(product))
                     
                  }
               }
            }
            
            LabeledContent("Quantité") {
               TextField("0", value: $viewModel.quantity, format: .number)
                  .keyboardType(.numberPad)
                  .multilineTextAlignment(.trailing)
            }
            
            if viewModel.movementType == .entry {
               LabeledContent("Date de péremption") {
                  DatePicker("", selection: $viewModel.expirationDate, displayedComponents: .date)
                                       .labelsHidden()
               }
               LabeledContent("Prix d'achat") {
                  TextField("0", value: $viewModel.purchasePrice, format: .currency(code: "EUR"))
                     .keyboardType(.decimalPad)
                     .multilineTextAlignment(.trailing)
                     .lineLimit(1)
               }

            }
            
            if let error = viewModel.errorMessage {
               Text(error).foregroundStyle(.red)
            }
         }
         .background(Color(.systemGroupedBackground))
         .navigationBarTitleDisplayMode(.inline)
         .navigationTitle(viewModel.movementType == .entry ? "Réceptionner un lot" : "Enregistrer une vente")
         .toolbar {
            ToolbarItem(placement: .confirmationAction) {
               Button {
                  if viewModel.submit() {
                     dismiss()
                  }
               } label : {
                  Image(systemName: "checkmark")
                     .foregroundColor(.white)
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
   }
}


