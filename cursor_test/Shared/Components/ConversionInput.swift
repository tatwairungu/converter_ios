//
//  ConversionInput.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import SwiftUI

struct ConversionInput: View {
    @Binding var value: String
    let unit: ConversionUnit
    let placeholder: String
    let onChanged: () -> Void
    
    var body: some View {
        VStack(spacing: KenyanTheme.Spacing.md) {
            Text("Enter value in \(unit.name)")
                .font(KenyanTheme.Typography.headline)
                .foregroundColor(KenyanTheme.Colors.text)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                TextField(placeholder, text: $value)
                    .textFieldStyle(PlainTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .onChange(of: value) {
                        // Basic input validation - only allow numbers and decimal points
                        let filtered = value.filter { "0123456789.".contains($0) }
                        if filtered != value {
                            value = filtered
                        }
                        onChanged()
                    }
                
                // Clear button
                if !value.isEmpty {
                    Button(action: {
                        value = ""
                        onChanged()
                    }) {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(KenyanTheme.Colors.secondary)
                            .font(.title3)
                    }
                    .transition(.opacity)
                }
                
                Text(unit.symbol)
                    .font(.title2)
                    .foregroundColor(KenyanTheme.Colors.primary)
                    .fontWeight(.semibold)
                    .padding(.trailing, KenyanTheme.Spacing.sm)
            }
            .padding()
            .background(KenyanTheme.Colors.background)
            .overlay(
                RoundedRectangle(cornerRadius: KenyanTheme.CornerRadius.small)
                    .stroke(
                        value.isEmpty ? KenyanTheme.Colors.primary : KenyanTheme.Colors.secondary,
                        lineWidth: value.isEmpty ? 2 : 3
                    )
            )
            .animation(.easeInOut(duration: 0.2), value: value.isEmpty)
        }
        .padding(.horizontal)
    }
}
