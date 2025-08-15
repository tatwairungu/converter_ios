//
//  WeightConverterView.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import SwiftUI

struct WeightConverterView: View {
    @State private var kilograms: String = ""
    @State private var grams: Double = 0.0
    @State private var showingResult: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: KenyanTheme.Spacing.xl) {
                // Header with Kenyan Flag Colors
                KenyanFlagHeader(
                    title: ConverterType.weight.displayName + " Converter",
                    subtitle: ConverterType.weight.subtitle,
                    icon: ConverterType.weight.icon
                )
                
                // Input Section
                VStack(spacing: KenyanTheme.Spacing.md) {
                    Text("Enter weight in Kilograms")
                        .font(KenyanTheme.Typography.headline)
                        .foregroundColor(KenyanTheme.Colors.text)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("0.0", text: $kilograms)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .overlay(
                            RoundedRectangle(cornerRadius: KenyanTheme.CornerRadius.small)
                                .stroke(KenyanTheme.Colors.primary, lineWidth: 2)
                        )
                        .onChange(of: kilograms) { _ in
                            convertWeight()
                        }
                }
                .padding(.horizontal)
                
                // Convert Button with Kenyan Flag Gradient
                Button(action: convertWeight) {
                    Text("Convert to Grams")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(KenyanTheme.Colors.kenyanWhite)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [KenyanTheme.Colors.secondary, KenyanTheme.Colors.kenyanBlack]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(KenyanTheme.CornerRadius.medium)
                        .overlay(
                            RoundedRectangle(cornerRadius: KenyanTheme.CornerRadius.medium)
                                .stroke(KenyanTheme.Colors.primary, lineWidth: 2)
                        )
                }
                .padding(.horizontal)
                .disabled(kilograms.isEmpty)
                
                // Result Section with Kenyan Flag Theming
                if showingResult && !kilograms.isEmpty {
                    VStack(spacing: KenyanTheme.Spacing.sm) {
                        Text("Result")
                            .font(KenyanTheme.Typography.headline)
                            .foregroundColor(KenyanTheme.Colors.secondary)
                            .fontWeight(.semibold)
                        
                        Text("\(grams, specifier: "%.0f") g")
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                            .foregroundColor(KenyanTheme.Colors.primary)
                        
                        Text("\(kilograms) kg = \(grams, specifier: "%.0f") grams")
                            .font(.subheadline)
                            .foregroundColor(KenyanTheme.Colors.text)
                            .fontWeight(.medium)
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
                    
                    Text("1 kg = 1,000 g")
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
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
    
    private func convertWeight() {
        guard let kg = Double(kilograms), kg >= 0 else {
            // Handle invalid input - hide result for invalid/empty input
            showingResult = false
            return
        }
        
        grams = kg * 1000
        showingResult = true
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
