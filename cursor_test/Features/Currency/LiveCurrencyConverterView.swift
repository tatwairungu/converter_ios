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
    
    @State private var keyboardOffset: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 0) {
            // Above-the-fold layout (no scrolling needed)
            VStack(spacing: KenyanTheme.Spacing.lg) {
                // Header
                HStack {
                    KenyanFlagHeader(
                        title: viewModel.title,
                        subtitle: viewModel.subtitle,
                        icon: ConverterType.currency.icon
                    )
                    
                    Spacer()
                    
                    // Manual refresh button (small, circular)
                    Button(action: {
                        Task {
                            await viewModel.refreshExchangeRates()
                        }
                    }) {
                        if viewModel.isLoading {
                            ProgressView()
                                .scaleEffect(0.7)
                        } else {
                            Image(systemName: "arrow.clockwise")
                                .font(.title3)
                        }
                    }
                    .foregroundColor(KenyanTheme.Colors.primary)
                    .frame(width: KenyanTheme.TouchTarget.minimum, height: KenyanTheme.TouchTarget.minimum)
                    .disabled(viewModel.isLoading)
                    .padding(.trailing, KenyanTheme.Spacing.md)
                }
                
                // Value input
                ConversionInput(
                    value: $viewModel.inputValue,
                    unit: viewModel.fromUnit,
                    placeholder: "0.0",
                    onChanged: viewModel.onInputChanged
                )
                
                // Unit selection (side-by-side)
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
                
                // Result card (always visible) with currency states
                VStack(spacing: KenyanTheme.Spacing.sm) {
                    if viewModel.isLoading {
                        // Loading skeleton
                        HStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(KenyanTheme.Colors.border)
                                .frame(width: 120, height: 40)
                                .opacity(0.3)
                                .animation(.easeInOut(duration: 1.2).repeatForever(), value: viewModel.isLoading)
                            
                            Spacer()
                        }
                        .padding(KenyanTheme.Spacing.md)
                        .frame(minHeight: KenyanTheme.Spacing.resultHeight)
                        .background(KenyanTheme.Colors.surface)
                        .overlay(
                            RoundedRectangle(cornerRadius: KenyanTheme.CornerRadius.medium)
                                .stroke(KenyanTheme.Colors.border, lineWidth: 1)
                        )
                        .padding(.horizontal, KenyanTheme.Spacing.md)
                    } else {
                        ConversionResult(
                            value: viewModel.showResult ? viewModel.resultValue : 0,
                            unit: viewModel.toUnit,
                            description: viewModel.conversionDescription
                        )
                    }
                    
                    // Currency status badges
                    HStack {
                        if viewModel.isDataStale {
                            Label("Stale • Tap refresh", systemImage: "exclamationmark.triangle.fill")
                                .font(KenyanTheme.Typography.caption)
                                .foregroundColor(.orange)
                        } else if !viewModel.isOnline {
                            Label("Offline • Showing cached rates", systemImage: "wifi.slash")
                                .font(KenyanTheme.Typography.caption)
                                .foregroundColor(KenyanTheme.Colors.secondary)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, KenyanTheme.Spacing.md)
                }
                
                Spacer()
                
                // Reference strip with last updated time
                Text("Rates cached every 4h • Last updated: \(viewModel.lastUpdateTimeFormatted)")
                    .font(KenyanTheme.Typography.caption)
                    .foregroundColor(KenyanTheme.Colors.mutedText)
                    .padding(.horizontal, KenyanTheme.Spacing.md)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(KenyanTheme.Colors.background)
            .offset(y: keyboardOffset)
            .animation(.easeInOut(duration: KenyanTheme.Animation.keyboard), value: keyboardOffset)
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
                if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
                    keyboardOffset = -keyboardHeight * 0.15  // Subtle shift to keep result visible
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                keyboardOffset = 0
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
        .navigationBarHidden(true)
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
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    LiveCurrencyConverterView()
}
