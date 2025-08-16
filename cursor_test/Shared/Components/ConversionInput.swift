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
    @FocusState private var isFocused: Bool
    @State private var hasError = false
    
    private var isValidInput: Bool {
        guard !value.isEmpty else { return true }
        return Double(value) != nil
    }
    
    private var unitHint: String {
        unit.symbol
    }
    
    var body: some View {
        VStack(spacing: KenyanTheme.Spacing.sm) {
            // Label
            HStack {
                Text("Value")
                    .font(KenyanTheme.Typography.title)
                    .foregroundColor(KenyanTheme.Colors.text)
                Spacer()
            }
            
            // Input field with unit hint
            HStack(spacing: KenyanTheme.Spacing.sm) {
                TextField(placeholder, text: $value)
                    .textFieldStyle(PlainTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .font(KenyanTheme.Typography.body)
                    .multilineTextAlignment(.trailing)
                    .focused($isFocused)
                    .accessibilityLabel("Value input field for \(unit.name)")
                    .accessibilityHint("Enter the number you want to convert")
                    .onChange(of: value) {
                        validateAndUpdate()
                    }
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                isFocused = false
                            }
                            .foregroundColor(KenyanTheme.Colors.primary)
                        }
                    }
                
                // Unit hint chip
                Text(unitHint)
                    .font(KenyanTheme.Typography.headline)
                    .foregroundColor(KenyanTheme.Colors.primary)
                    .padding(.horizontal, KenyanTheme.Spacing.sm)
                    .padding(.vertical, KenyanTheme.Spacing.xs)
                    .background(
                        RoundedRectangle(cornerRadius: KenyanTheme.CornerRadius.small)
                            .fill(KenyanTheme.Colors.surface)
                    )
            }
            .padding()
            .frame(height: KenyanTheme.Spacing.inputHeight)
            .background(KenyanTheme.Colors.surface)
            .overlay(
                RoundedRectangle(cornerRadius: KenyanTheme.CornerRadius.medium)
                    .stroke(
                        hasError ? KenyanTheme.Colors.secondary :
                        isFocused ? KenyanTheme.Colors.primary :
                        KenyanTheme.Colors.border,
                        lineWidth: isFocused || hasError ? 2 : 1
                    )
            )
            .animation(.easeInOut(duration: KenyanTheme.Animation.fast), value: isFocused)
            .animation(.easeInOut(duration: KenyanTheme.Animation.fast), value: hasError)
            
            // Error message or helper text
            HStack {
                if hasError {
                    Text("Enter a valid number (e.g., 36.6)")
                        .font(KenyanTheme.Typography.caption)
                        .foregroundColor(KenyanTheme.Colors.secondary)
                } else if value.isEmpty {
                    Text("Enter a number to convert")
                        .font(KenyanTheme.Typography.caption)
                        .foregroundColor(KenyanTheme.Colors.mutedText)
                }
                Spacer()
            }
        }
        .padding(.horizontal, KenyanTheme.Spacing.md)
    }
    
    private func validateAndUpdate() {
        // Input validation - only allow numbers and one decimal point
        let filtered = value.filter { "0123456789.".contains($0) }
        
        // Ensure only one decimal point
        let decimalCount = filtered.filter { $0 == "." }.count
        if decimalCount <= 1 {
            value = filtered
        } else {
            // Remove extra decimal points
            let components = filtered.components(separatedBy: ".")
            if components.count > 2 {
                value = components[0] + "." + components[1...].joined()
            }
        }
        
        // Update error state
        let newErrorState = !isValidInput
        if newErrorState != hasError {
            withAnimation(.easeInOut(duration: KenyanTheme.Animation.fast)) {
                hasError = newErrorState
            }
            
            // Haptic feedback for errors
            if newErrorState {
                let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                impactFeedback.impactOccurred()
            }
        }
        
        onChanged()
    }
}
