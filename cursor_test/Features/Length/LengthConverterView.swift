//
//  LengthConverterView.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import SwiftUI

struct LengthConverterView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: KenyanTheme.Spacing.xl) {
                // Header with Kenyan Flag Colors
                KenyanFlagHeader(
                    title: ConverterType.length.displayName + " Converter",
                    subtitle: ConverterType.length.subtitle,
                    icon: ConverterType.length.icon
                )
                
                Spacer()
                
                // Placeholder content
                VStack(spacing: KenyanTheme.Spacing.lg) {
                    Text("🚧 Coming Soon 🚧")
                        .font(KenyanTheme.Typography.title)
                        .foregroundColor(KenyanTheme.Colors.secondary)
                    
                    Text("Length converter will be implemented in Phase 2")
                        .font(KenyanTheme.Typography.body)
                        .foregroundColor(KenyanTheme.Colors.text)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                Spacer()
                
                // Info Section with Kenyan Flag Accent
                VStack(spacing: KenyanTheme.Spacing.sm) {
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(KenyanTheme.Colors.kenyanBlack)
                            .frame(width: 30, height: 4)
                        Rectangle()
                            .fill(KenyanTheme.Colors.secondary)
                            .frame(width: 30, height: 4)
                        Rectangle()
                            .fill(KenyanTheme.Colors.primary)
                            .frame(width: 30, height: 4)
                    }
                    .cornerRadius(2)
                    
                    Text("1 m = 3.28 ft")
                        .font(KenyanTheme.Typography.caption)
                        .foregroundColor(KenyanTheme.Colors.text)
                        .fontWeight(.medium)
                }
                .padding(.bottom)
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [KenyanTheme.Colors.background, Color.gray.opacity(0.05)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .navigationBarHidden(true)
        }
    }
}
