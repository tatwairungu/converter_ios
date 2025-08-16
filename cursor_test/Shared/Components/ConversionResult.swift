//
//  ConversionResult.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import SwiftUI
import UIKit

struct ConversionResult: View {
    let value: Double
    let unit: ConversionUnit
    let description: String
    
    @State private var showingCopiedAlert = false
    
    private let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
    
    var formattedValue: String {
        // Smart formatting based on value magnitude
        if value == 0 {
            return "0"
        } else if abs(value) >= 1000000 {
            return String(format: "%.2e", value)
        } else if abs(value) >= 1000 {
            return String(format: "%.0f", value)
        } else if abs(value) >= 1 {
            return String(format: "%.2f", value)
        } else {
            return String(format: "%.4f", value)
        }
    }
    
    var copyText: String {
        return "\(formattedValue) \(unit.symbol)"
    }
    
    var isEmpty: Bool {
        value.isZero || value.isNaN || value.isInfinite
    }
    
    var body: some View {
        VStack(spacing: KenyanTheme.Spacing.sm) {
            // Primary result line
            HStack(alignment: .lastTextBaseline, spacing: KenyanTheme.Spacing.sm) {
                if isEmpty {
                    Text("—")
                        .font(.system(size: 44, weight: .bold, design: .rounded))
                        .foregroundColor(KenyanTheme.Colors.mutedText)
                } else {
                    Text(formattedValue)
                        .font(.system(size: 44, weight: .bold, design: .rounded))
                        .foregroundColor(KenyanTheme.Colors.text)
                    
                    Text(unit.symbol)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(KenyanTheme.Colors.mutedText)
                        .opacity(0.8)
                }
                
                Spacer()
                
                if !isEmpty {
                    Button(action: copyToClipboard) {
                        Image(systemName: "doc.on.clipboard")
                            .font(.title3)
                            .foregroundColor(KenyanTheme.Colors.primary)
                            .frame(width: KenyanTheme.TouchTarget.minimum, height: KenyanTheme.TouchTarget.minimum)
                    }
                    .scaleEffect(showingCopiedAlert ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: KenyanTheme.Animation.fast), value: showingCopiedAlert)
                    .accessibilityLabel("Copy result")
                    .accessibilityHint("Copies \(copyText) to clipboard")
                }
            }
            
            // Secondary line (formula or context)
            HStack {
                if isEmpty {
                    Text("Enter a number to convert")
                        .font(KenyanTheme.Typography.caption)
                        .foregroundColor(KenyanTheme.Colors.mutedText)
                } else {
                    Text(description)
                        .font(KenyanTheme.Typography.caption)
                        .foregroundColor(KenyanTheme.Colors.mutedText)
                }
                Spacer()
            }
            
            // Copied confirmation
            if showingCopiedAlert {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(KenyanTheme.Colors.primary)
                    Text("Copied!")
                        .font(KenyanTheme.Typography.caption)
                        .foregroundColor(KenyanTheme.Colors.primary)
                }
                .transition(.opacity.combined(with: .scale))
            }
        }
        .padding(KenyanTheme.Spacing.md)
        .frame(minHeight: KenyanTheme.Spacing.resultHeight)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(KenyanTheme.Colors.adaptiveSurface)
        .overlay(
            RoundedRectangle(cornerRadius: KenyanTheme.CornerRadius.medium)
                .stroke(KenyanTheme.Colors.border, lineWidth: 1)
        )
        .shadow(
            color: KenyanTheme.Shadow.card.color,
            radius: KenyanTheme.Shadow.card.radius,
            x: KenyanTheme.Shadow.card.x,
            y: KenyanTheme.Shadow.card.y
        )
        .padding(.horizontal, KenyanTheme.Spacing.md)
        .onTapGesture {
            if !isEmpty {
                copyToClipboard()
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(isEmpty ? "No result" : "Conversion result: \(copyText)")
        .accessibilityAction(named: "Copy") {
            if !isEmpty {
                copyToClipboard()
            }
        }
    }
    
    private func copyToClipboard() {
        UIPasteboard.general.string = copyText
        
        // Enhanced haptic feedback - more noticeable click
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.prepare()
        impactFeedback.impactOccurred()
        
        // Success haptic
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let successFeedback = UINotificationFeedbackGenerator()
            successFeedback.notificationOccurred(.success)
        }
        
        // Show copied confirmation
        withAnimation(.easeInOut(duration: KenyanTheme.Animation.standard)) {
            showingCopiedAlert = true
        }
        
        // Hide confirmation after 1.5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.easeInOut(duration: KenyanTheme.Animation.standard)) {
                showingCopiedAlert = false
            }
        }
    }
}
