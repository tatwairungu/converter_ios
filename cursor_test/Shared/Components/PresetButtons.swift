//
//  PresetButtons.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import SwiftUI

struct PresetButtons: View {
    @Binding var value: String
    let presetValues: [Double]
    let onChanged: () -> Void
    
    init(value: Binding<String>, presetValues: [Double] = [1, 10, 100, 1000], onChanged: @escaping () -> Void) {
        self._value = value
        self.presetValues = presetValues
        self.onChanged = onChanged
    }
    
    var body: some View {
        VStack(spacing: KenyanTheme.Spacing.sm) {
            Text("Quick Values")
                .font(KenyanTheme.Typography.caption)
                .foregroundColor(KenyanTheme.Colors.text)
                .fontWeight(.medium)
            
            HStack(spacing: KenyanTheme.Spacing.sm) {
                ForEach(presetValues, id: \.self) { presetValue in
                    Button(action: {
                        value = formatPresetValue(presetValue)
                        onChanged()
                    }) {
                        Text(formatPresetValue(presetValue))
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(KenyanTheme.Colors.background)
                            .padding(.horizontal, KenyanTheme.Spacing.md)
                            .padding(.vertical, KenyanTheme.Spacing.xs)
                            .background(
                                RoundedRectangle(cornerRadius: KenyanTheme.CornerRadius.small)
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                KenyanTheme.Colors.primary,
                                                KenyanTheme.Colors.secondary
                                            ]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: KenyanTheme.CornerRadius.small)
                                    .stroke(KenyanTheme.Colors.kenyanBlack, lineWidth: 1)
                            )
                    }
                    .scaleEffect(value == formatPresetValue(presetValue) ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 0.15), value: value)
                }
            }
        }
        .padding(.horizontal)
    }
    
    private func formatPresetValue(_ value: Double) -> String {
        if value >= 1000 {
            return String(format: "%.0f", value)
        } else if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", value)
        } else {
            return String(format: "%.1f", value)
        }
    }
}
