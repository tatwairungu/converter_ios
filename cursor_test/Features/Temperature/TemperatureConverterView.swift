//
//  TemperatureConverterView.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import SwiftUI

struct TemperatureConverterView: View {
    @StateObject private var viewModel = TemperatureConverterViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: KenyanTheme.Spacing.lg) {
                    // Header with Kenyan Flag Colors
                    KenyanFlagHeader(
                        title: viewModel.title,
                        subtitle: viewModel.subtitle,
                        icon: ConverterType.temperature.icon
                    )
                    
                    // Input Section
                    ConversionInput(
                        value: $viewModel.inputValue,
                        unit: viewModel.fromUnit,
                        placeholder: "0.0",
                        onChanged: viewModel.onInputChanged
                    )
                    
                    // Unit Selection
                    UnitSelector(
                        fromUnit: $viewModel.fromUnit,
                        toUnit: $viewModel.toUnit,
                        availableUnits: viewModel.availableUnits,
                        onSwap: viewModel.swapUnits
                    )
                    .onChange(of: viewModel.fromUnit) {
                        viewModel.onFromUnitChanged()
                    }
                    .onChange(of: viewModel.toUnit) {
                        viewModel.onToUnitChanged()
                    }
                    
                    // Result Section with Temperature Context
                    if viewModel.showResult && !viewModel.inputValue.isEmpty {
                        VStack(spacing: KenyanTheme.Spacing.sm) {
                            ConversionResult(
                                value: viewModel.resultValue,
                                unit: viewModel.toUnit,
                                description: viewModel.conversionDescription
                            )
                            
                            // Weather Context
                            if let inputTemp = Double(viewModel.inputValue) {
                                let celsiusTemp = viewModel.fromUnit.id == "c" ? inputTemp :
                                                 viewModel.fromUnit.id == "f" ? (inputTemp - 32) * 5/9 :
                                                 inputTemp - 273.15
                                
                                Text(viewModel.getTemperatureContext(celsius: celsiusTemp))
                                    .font(KenyanTheme.Typography.headline)
                                    .foregroundColor(KenyanTheme.Colors.secondary)
                                    .padding(.horizontal)
                            }
                        }
                    }
                    
                    Spacer(minLength: KenyanTheme.Spacing.xl)
                    
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
                        
                        Text(viewModel.conversionInfo)
                            .font(KenyanTheme.Typography.caption)
                            .foregroundColor(KenyanTheme.Colors.text)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.bottom)
                }
                .padding(.vertical)
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
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
