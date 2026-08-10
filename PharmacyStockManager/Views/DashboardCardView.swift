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

   let subtitle: String?
   var body: some View {
       
       VStack(spacing: 12){
          HStack(alignment: .center, spacing: 4) {
             Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 10).fill(color.opacity(0.15)))
             
             
             VStack(alignment: .leading) {
                Text(value)
                   .font(.title)
                   .lineLimit(1)
                   .minimumScaleFactor(0.7)
                   .fontWeight(.semibold)
                   .foregroundStyle(.primary)
                
                Text(title)
                   .font(.body)
                   .lineLimit(1)
                   .minimumScaleFactor(0.7)
                   .fontWeight(.medium)
                   .foregroundStyle(.secondary)
             }
             
             
          }
          if let subtitle = subtitle {
             Text(subtitle)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(color)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 6)
                .background(
                  RoundedRectangle(cornerRadius: 12).fill(color.opacity(0.12)))
          }
         
       }
       .frame(maxWidth: .infinity, alignment: .leading)
       .padding()
       .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 16))
     // .shadow(radius: 4)
    }
}

#Preview {
   DashboardCardView(title: "Produits", value: "12", icon: "pills", color: .blue, subtitle: "Total References")
}
