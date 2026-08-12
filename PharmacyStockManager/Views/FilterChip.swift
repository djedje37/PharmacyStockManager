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
             .font(.subheadline.weight(.medium))
             .padding(.horizontal, 12)
             .padding(.vertical, 6)
             .background(isSelected ? Color.accentColor : Color(.secondarySystemGroupedBackground), in: Capsule())
             .foregroundColor(isSelected ? .white : .primary)
          
       }
       .buttonStyle(.plain)
    }
}

#Preview {
   FilterChip(title: "Remboursé", isSelected: false, action: {})
}
