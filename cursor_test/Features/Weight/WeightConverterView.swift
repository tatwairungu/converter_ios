//
//  WeightConverterView.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import SwiftUI

struct WeightConverterView: View {
    @StateObject private var viewModel = WeightConverterViewModel()
    @State private var keyboardOffset: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 0) {
            // Above-the-fold layout (no scrolling needed)
            VStack(spacing: KenyanTheme.Spacing.lg) {
                // Header
                KenyanFlagHeader(
                    title: viewModel.title,
                    subtitle: viewModel.subtitle,
                    icon: ConverterType.weight.icon
                )
                
                // Value input
                ConversionInput(
                    value: $viewModel.inputValue,
                    unit: viewModel.fromUnit,
                    placeholder: "0.0",
                    onChanged: viewModel.onInputChanged
                )
                
                // Quick preset values
                PresetChips(
                    inputValue: $viewModel.inputValue,
                    presetValues: [1, 5, 10, 25, 50, 100],
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
                
                // Result card (always visible)
                ConversionResult(
                    value: viewModel.showResult ? viewModel.resultValue : 0,
                    unit: viewModel.toUnit,
                    description: viewModel.conversionDescription
                )
                
                Spacer()
                
                // Tappable reference strip
                Button(action: {
                    UIPasteboard.general.string = "1 kg = 2.20462 lb"
                    let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                    impactFeedback.impactOccurred()
                }) {
                    Text("1 kg = 2.20462 lb")
                        .font(KenyanTheme.Typography.caption)
                        .foregroundColor(KenyanTheme.Colors.mutedText)
                        .underline()
                }
                .buttonStyle(PlainButtonStyle())
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
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


#Preview {
    WeightConverterView()
}
