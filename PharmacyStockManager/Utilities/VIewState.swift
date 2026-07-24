//
//  VIewState.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 19/07/2026.
//

/// Generic representation of a view's loading state, shared across ViewModels
enum ViewState<T> {
    case loading
    case loaded(T)
    case error(String)
}
