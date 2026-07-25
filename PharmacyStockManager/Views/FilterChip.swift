//
//  FilterChip.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 25/07/2026.
//

import SwiftUI

struct FilterChip: View {
   
   let title: String
   let isSelected : Bool
   let action : () -> Void
   
    var body: some View {
       
       Button(action: action) {
          Text(title)
             .font(.caption.weight(.medium))
             .padding(.horizontal, 12)
             .padding(.vertical, 6)
             .background(isSelected ? Color.primary : Color(.systemBackground))
             .foregroundColor(isSelected ? Color(.systemBackground) : .primary)
             .clipShape(Capsule())
          
       }
       .buttonStyle(.plain)
    }
}

#Preview {
   FilterChip(title: "Remboursé", isSelected: false, action: {})
}
