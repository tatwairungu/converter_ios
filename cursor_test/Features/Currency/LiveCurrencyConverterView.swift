//
//  LiveCurrencyConverterView.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import SwiftUI

struct LiveCurrencyConverterView: View {
    @StateObject private var viewModel = LiveCurrencyViewModel()
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: KenyanTheme.Spacing.lg) {
                    // Header with Kenyan Flag Colors
                    KenyanFlagHeader(
                        title: viewModel.title,
                        subtitle: viewModel.subtitle,
                        icon: ConverterType.currency.icon
                    )
                    
                    // Data Status Indicator
                    if viewModel.isDataStale {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.orange)
                            Text("Data may be outdated - tap refresh for latest rates")
                                .font(.caption)
                                .foregroundColor(.orange)
                        }
                        .padding(.horizontal)
                    }
                    
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
                    
                    // Refresh Button
                    Button(action: {
                        Task {
                            await viewModel.refreshExchangeRates()
                        }
                    }) {
                        HStack {
                            if viewModel.isLoading {
                                ProgressView()
                                    .scaleEffect(0.8)
                                    .foregroundColor(KenyanTheme.Colors.background)
                            } else {
                                Image(systemName: "arrow.clockwise")
                            }
                            Text(viewModel.refreshButtonText)
                        }
                        .font(.headline)
                        .foregroundColor(KenyanTheme.Colors.background)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    KenyanTheme.Colors.primary,
                                    viewModel.isDataStale ? .orange : KenyanTheme.Colors.primary
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(KenyanTheme.CornerRadius.medium)
                        .overlay(
                            RoundedRectangle(cornerRadius: KenyanTheme.CornerRadius.medium)
                                .stroke(KenyanTheme.Colors.secondary, lineWidth: 2)
                        )
                    }
                    .disabled(viewModel.isLoading)
                    .padding(.horizontal)
                    
                    // Result Section
                    if viewModel.showResult && !viewModel.inputValue.isEmpty {
                        VStack(spacing: KenyanTheme.Spacing.sm) {
                            ConversionResult(
                                value: viewModel.resultValue,
                                unit: viewModel.toUnit,
                                description: viewModel.conversionDescription
                            )
                            
                            // Exchange Rate Info
                            VStack(spacing: KenyanTheme.Spacing.xs) {
                                Text(viewModel.getConversionRate())
                                    .font(KenyanTheme.Typography.caption)
                                    .foregroundColor(KenyanTheme.Colors.secondary)
                                    .fontWeight(.medium)
                                
                                Text("Data age: \(viewModel.dataAge)")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Loading State
                    if viewModel.isLoading {
                        VStack(spacing: KenyanTheme.Spacing.sm) {
                            ProgressView()
                                .scaleEffect(1.2)
                            Text("Fetching live exchange rates...")
                                .font(KenyanTheme.Typography.body)
                                .foregroundColor(KenyanTheme.Colors.text)
                        }
                        .padding()
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
            .alert("Currency Error", isPresented: $showingError) {
                Button("OK") {
                    showingError = false
                }
            } message: {
                Text(viewModel.errorMessage ?? "Unknown error occurred")
            }
            .onChange(of: viewModel.errorMessage) {
                showingError = viewModel.errorMessage != nil
            }
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    LiveCurrencyConverterView()
}
