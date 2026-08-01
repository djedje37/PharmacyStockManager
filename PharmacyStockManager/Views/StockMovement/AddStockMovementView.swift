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
   }
   
   var body: some View {
      NavigationStack {
         Form {
            Section {
               Picker("Type", selection: $viewModel.movementType) {
                  Text("Réception").tag(MovementType.entry)
                  Text("Vente").tag(MovementType.exit)
               }
               .pickerStyle(.segmented)
            }
            
            Section("Produit") {
               Picker("Produit", selection: $viewModel.selectedProduct) {
                  Text("Sélectionner...").tag(Product?.none)
                  ForEach(products) { product in
                     Text(product.name).tag(Product?.some(product))
                  }
               }
            }
            
            Section("Quantité") {
               TextField("Quantité", value: $viewModel.quantity, format: .number)
                  .keyboardType(.numberPad)
            }
            
            if viewModel.movementType == .entry {
               Section("Détails de réception") {
                  DatePicker("Date de péremption", selection: $viewModel.expirationDate, displayedComponents: .date)
                  TextField("Prix d'achat", value: $viewModel.purchasePrice, format:.number)
                     .keyboardType(.decimalPad)
               }
            }
            
            if let error = viewModel.errorMessage {
               Section {
                  Text(error).foregroundStyle(.red)
               }
            }
         }
         .navigationTitle(viewModel.movementType == .entry ? "Réceptionner un lot" : "Enregistrer une vente")
         .toolbar {
            ToolbarItem(placement: .confirmationAction) {
               Button("Valider") {
                  if viewModel.submit() {
                     dismiss()
                  }
               }
            }
            ToolbarItem(placement: .cancellationAction) {
               Button("Annuler") { dismiss() }
            }
         }
      }
   }
}


