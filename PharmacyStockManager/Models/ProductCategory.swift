//
//  ProductCategory.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 06/06/2026.
//

// TODO : trads

// MARK: Product Category
/// Represent the pharmaceutical category of a products
/// This is an intentional enums instead of a SwiftData model
/// Category are closed, predefined data from the sorce data (json file) and are not expected to be renamed, created dynamically by user
/// - Note: If in future, category  needs to become dynamic exemple enable user to add categories,
/// this should be migrated to  Model type instead.
enum ProductCategory: String, Codable, CaseIterable  {
   case comprime = "Comprimé"
   case sirop = "Sirop / Solution buvable"
   case gelule = "Gélule"
   case injectable = "Injectable"
   case collyre = "Collyre"
   case sachet = "Sachet"
   case dispositifMedical = "Dispositif médical"
   case cremePommade = "Crème / Pommade"
   case nutritionInfantile = "Nutrition infantile"
   case hygieneParapharmacie = "Hygiène / Parapharmacie"
   case autre = "Autre"
}
