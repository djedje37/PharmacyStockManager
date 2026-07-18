//
//  DashboardCardView.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 05/07/2026.
//

import SwiftUI

struct DashboardCardView: View {
   
   let title : String
   let value: String
   let icon: String
   let color: Color

    var body: some View {
       VStack(alignment: .leading, spacing: 8) {
          Image(systemName: icon)
             .font(.title2)
             .foregroundStyle(color)
          
          Text(value)
             .font(.title)
             .bold()
          
          Text(title)
             .foregroundStyle(.secondary)
          
       }
       .frame(maxWidth: .infinity, alignment: .leading)
       .padding()
       .background(.thinMaterial)
       .clipShape(RoundedRectangle(cornerRadius: 16))
      // .shadow(radius: 4)
    }
}

#Preview {
    DashboardCardView(title: "Produits", value: "12", icon: "pills", color: .blue)
}
