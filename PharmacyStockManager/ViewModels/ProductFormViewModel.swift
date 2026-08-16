//
//  ProductFormViewModel.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 01/08/2026.
//

import Foundation
import Combine
import SwiftData


enum ProductError: Error, LocalizedError {
    case invalidName
    case invalidPrice
    case duplicateCip

    var errorDescription: String? {
        switch self {
        case .invalidName:
            return "Le nom du produit ne peut pas être vide."
        case .invalidPrice:
            return "Le prix doit être supérieur ou égal à zéro."
        case .duplicateCip:
            return "Un produit avec ce CIP existe déjà."
        }
    }
}

@MainActor
@Observable
class ProductFormViewModel : ObservableObject {
   private let productRepository: ProductRepository
   let existingProduct: Product?
   var cip = ""
   var name = ""
   var category: ProductCategory = .autre
   var publicPrice: Double = 0
   var reimbursementBase: Double = 0
   var vatRate: VATRate = .exempt
   var geoCode = ""
   var alertThreshold = 10
   
   var errorMessage: String?

   var isEditing: Bool { existingProduct != nil }
   var navigationTitle: String { isEditing ? "Modifier le produit" : "Nouveau produit" }

   var isSubmitDisabled : Bool { cip.isEmpty || name.isEmpty }
   init(productRepository: ProductRepository, existingProduct: Product? = nil) {
      self.productRepository = productRepository
      self.existingProduct = existingProduct
      
      guard let existingProduct else { return }
      
      load(existingProduct)
   }

   
   
   private func load(_ product: Product) {
      name = product.name
      cip = product.cip
      category = product.category
      publicPrice = product.publicPrice.fcfaToEuro
      reimbursementBase = product.reimbursementBase.fcfaToEuro
      vatRate = product.vatRate
      geoCode = product.geoCode ?? ""
      alertThreshold = product.alertThreshold
   }
   
   private func validate() throws {
      guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
         throw ProductError.invalidName
      }
      guard (publicPrice) >= 0 else {
          throw ProductError.invalidPrice
      }
   }
   
   
   func submit() -> Bool {
      errorMessage = nil
      
      do {
         try validate()
         if let existingProduct {
            try update(product: existingProduct)
         } else {
            
            try create()
            
         }
         return true
      } catch {
         errorMessage = error.localizedDescription
         return false
      }
   }
   
   private func create() throws {
      
      guard try !productRepository.exists(cip: cip) else {
         throw ProductError.duplicateCip
      }
      
      let product = Product(cip: cip, name: name, category: category, reimbursementBase: reimbursementBase.euroToFcfa, vatRate: vatRate, geoCode: geoCode.isEmpty ? nil : geoCode, publicPrice: publicPrice.euroToFcfa, alertThreshold: alertThreshold)
      
      try productRepository.add(product)
   }
   
   
   private func update(product: Product) throws {
      product.name = name
      product.category = category
      product.publicPrice = publicPrice.euroToFcfa
      product.vatRate = vatRate
      product.geoCode = geoCode.isEmpty ? nil : geoCode
      product.alertThreshold = alertThreshold
      product.reimbursementBase = reimbursementBase.euroToFcfa

      try productRepository.save()
   }
   
}
