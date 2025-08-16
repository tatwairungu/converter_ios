//
//  PresetChips.swift
//  cursor_test
//
//  Created by Tatwa on 16/08/2025.
//

import SwiftUI

struct PresetChips: View {
    @Binding var inputValue: String
    let presetValues: [Int]
    let onChanged: () -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: KenyanTheme.Spacing.sm) {
                ForEach(presetValues, id: \.self) { value in
                    Button(action: {
                        inputValue = String(value)
                        onChanged()
                        
                        // Haptic feedback
                        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                        impactFeedback.impactOccurred()
                    }) {
                        Text("\(value)")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(KenyanTheme.Colors.primary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(KenyanTheme.Colors.surface)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(KenyanTheme.Colors.primary.opacity(0.3), lineWidth: 1)
                                    )
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal, KenyanTheme.Spacing.md)
        }
    }
}

#Preview {
    VStack {
        PresetChips(
            inputValue: .constant(""),
            presetValues: [1, 10, 100, 1000],
            onChanged: {}
        )
    }
    .padding()
}
