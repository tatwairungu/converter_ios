//
//  UnitSelector.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import SwiftUI

struct UnitSelector: View {
    @Binding var fromUnit: ConversionUnit
    @Binding var toUnit: ConversionUnit
    let availableUnits: [ConversionUnit]
    let onSwap: () -> Void
    @State private var isSwapping = false
    
    var body: some View {
        VStack(spacing: KenyanTheme.Spacing.md) {
            // Side-by-side unit pickers
            HStack(spacing: KenyanTheme.Spacing.md) {
                // From Unit Picker
                VStack(spacing: KenyanTheme.Spacing.sm) {
                    Text("From")
                        .font(KenyanTheme.Typography.title)
                        .foregroundColor(KenyanTheme.Colors.text)
                    
                    unitPicker(
                        selectedUnit: fromUnit,
                        onSelection: { unit in
                            fromUnit = unit
                        }
                    )
                }
                .frame(maxWidth: .infinity)
                
                // To Unit Picker
                VStack(spacing: KenyanTheme.Spacing.sm) {
                    Text("To")
                        .font(KenyanTheme.Typography.title)
                        .foregroundColor(KenyanTheme.Colors.text)
                    
                    unitPicker(
                        selectedUnit: toUnit,
                        onSelection: { unit in
                            toUnit = unit
                        }
                    )
                }
                .frame(maxWidth: .infinity)
            }
            
            // Swap Button (centered below pickers)
            Button(action: performSwap) {
                Image(systemName: "arrow.left.arrow.right")
                    .font(.title2)
                    .foregroundColor(KenyanTheme.Colors.kenyanWhite)
                    .frame(width: KenyanTheme.Spacing.swapButtonSize, height: KenyanTheme.Spacing.swapButtonSize)
                    .background(KenyanTheme.Colors.primary)
                    .clipShape(Circle())
                    .shadow(
                        color: KenyanTheme.Shadow.card.color,
                        radius: KenyanTheme.Shadow.card.radius,
                        x: KenyanTheme.Shadow.card.x,
                        y: KenyanTheme.Shadow.card.y
                    )
                    .scaleEffect(isSwapping ? 0.95 : 1.0)
                    .rotationEffect(.degrees(isSwapping ? 180 : 0))
            }
            .frame(height: KenyanTheme.TouchTarget.minimum)
            .accessibilityLabel("Swap units")
            .accessibilityHint("Switches the from and to units")
        }
        .padding(.horizontal, KenyanTheme.Spacing.md)
    }
    
    @ViewBuilder
    private func unitPicker(selectedUnit: ConversionUnit, onSelection: @escaping (ConversionUnit) -> Void) -> some View {
        Menu {
            ForEach(availableUnits, id: \.id) { unit in
                Button(action: {
                    onSelection(unit)
                }) {
                    HStack {
                        Text("\(unit.name)")
                        Spacer()
                        Text(unit.symbol)
                            .foregroundColor(KenyanTheme.Colors.mutedText)
                        if unit.id == selectedUnit.id {
                            Image(systemName: "checkmark")
                                .foregroundColor(KenyanTheme.Colors.primary)
                        }
                    }
                }
            }
        } label: {
            HStack(spacing: KenyanTheme.Spacing.sm) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(selectedUnit.name)
                        .font(KenyanTheme.Typography.headline)
                        .foregroundColor(KenyanTheme.Colors.text)
                        .lineLimit(1)
                    Text(selectedUnit.symbol)
                        .font(KenyanTheme.Typography.caption)
                        .foregroundColor(KenyanTheme.Colors.mutedText)
                }
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .font(.caption)
                    .foregroundColor(KenyanTheme.Colors.primary)
            }
            .padding(KenyanTheme.Spacing.sm)
            .frame(height: KenyanTheme.Spacing.inputHeight)
            .background(KenyanTheme.Colors.surface)
            .overlay(
                RoundedRectangle(cornerRadius: KenyanTheme.CornerRadius.medium)
                    .stroke(KenyanTheme.Colors.border, lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel("\(selectedUnit.name), \(selectedUnit.symbol)")
        .accessibilityHint("Choose a different unit")
    }
    
    private func performSwap() {
        withAnimation(.easeInOut(duration: KenyanTheme.Animation.swap)) {
            isSwapping = true
        }
        
        // Haptic feedback
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
        
        onSwap()
        
        // Reset animation state
        DispatchQueue.main.asyncAfter(deadline: .now() + KenyanTheme.Animation.swap) {
            withAnimation(.easeInOut(duration: KenyanTheme.Animation.swap)) {
                isSwapping = false
            }
        }
    }
}
