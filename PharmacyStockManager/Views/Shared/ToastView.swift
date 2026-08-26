//
//  ToastView.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 23/08/2026.
//

import SwiftUI

struct ToastMessage : Identifiable, Equatable {
   let id = UUID()
   let text: String
   let icon: String
   let color: Color
   
   static func success(_ text: String) -> ToastMessage {
      ToastMessage(text: text, icon: "checkmark.circle.fill", color: .green)
   }
   
   static func error(_ text: String) -> ToastMessage {
      ToastMessage(text: text, icon: "xmark.circle.fill", color: .red)
   }
   
}
struct ToastView : View {
   
   let message: ToastMessage
   var body: some View {
       HStack(spacing: 10) {
           Image(systemName: message.icon)
               .foregroundStyle(message.color)
           Text(message.text)
               .font(.subheadline.weight(.medium))
               .foregroundStyle(.primary)
       }
       .padding(.horizontal, 16)
       .padding(.vertical, 12)
       .background(.regularMaterial, in: Capsule())
       .shadow(color: .black.opacity(0.1), radius: 8, y: 2)
   }
   
}
