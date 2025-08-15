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
        return String(format: "%.2f", value)
    }
    
    var copyText: String {
        return "\(formattedValue) \(unit.symbol)"
    }
    
    var body: some View {
        VStack(spacing: KenyanTheme.Spacing.sm) {
            HStack {
                Text("Result")
                    .font(KenyanTheme.Typography.headline)
                    .foregroundColor(KenyanTheme.Colors.secondary)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button(action: copyToClipboard) {
                    HStack(spacing: 4) {
                        Image(systemName: "doc.on.clipboard")
                        Text("Copy")
                    }
                    .font(.caption)
                    .foregroundColor(KenyanTheme.Colors.primary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(KenyanTheme.Colors.primary.opacity(0.1))
                    )
                }
                .scaleEffect(showingCopiedAlert ? 1.1 : 1.0)
                .animation(.easeInOut(duration: 0.1), value: showingCopiedAlert)
            }
            
            Text("\(formattedValue) \(unit.symbol)")
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .foregroundColor(KenyanTheme.Colors.primary)
                .onTapGesture {
                    copyToClipboard()
                }
            
            Text(description)
                .font(.subheadline)
                .foregroundColor(KenyanTheme.Colors.text)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
            
            if showingCopiedAlert {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Text("Copied to clipboard!")
                        .font(.caption)
                        .foregroundColor(.green)
                }
                .transition(.opacity.combined(with: .scale))
            }
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
    
    private func copyToClipboard() {
        UIPasteboard.general.string = copyText
        
        // Haptic feedback
        impactFeedback.impactOccurred()
        
        // Show copied confirmation
        withAnimation(.easeInOut(duration: 0.3)) {
            showingCopiedAlert = true
        }
        
        // Hide confirmation after 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeInOut(duration: 0.3)) {
                showingCopiedAlert = false
            }
        }
    }
}
