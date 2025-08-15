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
    
    var body: some View {
        VStack(spacing: KenyanTheme.Spacing.md) {
            // From Unit Selector
            VStack(spacing: KenyanTheme.Spacing.sm) {
                Text("From")
                    .font(KenyanTheme.Typography.headline)
                    .foregroundColor(KenyanTheme.Colors.text)
                
                Menu {
                    ForEach(availableUnits, id: \.id) { unit in
                        Button(action: {
                            fromUnit = unit
                        }) {
                            HStack {
                                Text("\(unit.name) (\(unit.symbol))")
                                if unit.id == fromUnit.id {
                                    Spacer()
                                    Image(systemName: "checkmark")
                                        .foregroundColor(KenyanTheme.Colors.primary)
                                }
                            }
                        }
                    }
                } label: {
                    HStack {
                        Text("\(fromUnit.name) (\(fromUnit.symbol))")
                            .foregroundColor(KenyanTheme.Colors.text)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(KenyanTheme.Colors.primary)
                    }
                    .padding()
                    .background(KenyanTheme.Colors.background)
                    .overlay(
                        RoundedRectangle(cornerRadius: KenyanTheme.CornerRadius.small)
                            .stroke(KenyanTheme.Colors.primary, lineWidth: 2)
                    )
                }
            }
            
            // Swap Button
            Button(action: onSwap) {
                Image(systemName: "arrow.up.arrow.down")
                    .font(.title2)
                    .foregroundColor(KenyanTheme.Colors.background)
                    .frame(width: 44, height: 44)
                    .background(KenyanTheme.Colors.primary)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(KenyanTheme.Colors.secondary, lineWidth: 2)
                    )
            }
            
            // To Unit Selector
            VStack(spacing: KenyanTheme.Spacing.sm) {
                Text("To")
                    .font(KenyanTheme.Typography.headline)
                    .foregroundColor(KenyanTheme.Colors.text)
                
                Menu {
                    ForEach(availableUnits, id: \.id) { unit in
                        Button(action: {
                            toUnit = unit
                        }) {
                            HStack {
                                Text("\(unit.name) (\(unit.symbol))")
                                if unit.id == toUnit.id {
                                    Spacer()
                                    Image(systemName: "checkmark")
                                        .foregroundColor(KenyanTheme.Colors.primary)
                                }
                            }
                        }
                    }
                } label: {
                    HStack {
                        Text("\(toUnit.name) (\(toUnit.symbol))")
                            .foregroundColor(KenyanTheme.Colors.text)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(KenyanTheme.Colors.primary)
                    }
                    .padding()
                    .background(KenyanTheme.Colors.background)
                    .overlay(
                        RoundedRectangle(cornerRadius: KenyanTheme.CornerRadius.small)
                            .stroke(KenyanTheme.Colors.primary, lineWidth: 2)
                    )
                }
            }
        }
        .padding(.horizontal)
    }
}
