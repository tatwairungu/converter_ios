//
//  ConversionResult.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import SwiftUI

struct ConversionResult: View {
    let value: Double
    let unit: ConversionUnit
    let description: String
    
    var body: some View {
        VStack(spacing: KenyanTheme.Spacing.sm) {
            Text("Result")
                .font(KenyanTheme.Typography.headline)
                .foregroundColor(KenyanTheme.Colors.secondary)
                .fontWeight(.semibold)
            
            Text("\(String(format: "%.2f", value)) \(unit.symbol)")
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .foregroundColor(KenyanTheme.Colors.primary)
            
            Text(description)
                .font(.subheadline)
                .foregroundColor(KenyanTheme.Colors.text)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: KenyanTheme.CornerRadius.medium)
                .fill(KenyanTheme.Colors.background)
                .shadow(color: KenyanTheme.Colors.kenyanBlack.opacity(0.1), radius: 8, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: KenyanTheme.CornerRadius.medium)
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [KenyanTheme.Colors.secondary, KenyanTheme.Colors.primary]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 3
                )
        )
        .padding(.horizontal)
    }
}
