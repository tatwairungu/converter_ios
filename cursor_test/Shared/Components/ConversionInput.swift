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
                        onChanged()
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
                    .stroke(KenyanTheme.Colors.primary, lineWidth: 2)
            )
        }
        .padding(.horizontal)
    }
}
