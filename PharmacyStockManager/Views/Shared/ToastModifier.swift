//
//  ToastModifier.swift
//  PharmacyStockManager
//
//  Created by Djeneba KANE on 23/08/2026.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var toast: ToastMessage?

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                if let toast {
                    ToastView(message: toast)
                        .padding(.top, 8)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                withAnimation { self.toast = nil }
                            }
                        }
                }
            }
            .animation(.spring(duration: 0.3), value: toast)
    }
}

extension View {
    func toast(_ message: Binding<ToastMessage?>) -> some View {
        modifier(ToastModifier(toast: message))
    }
}
