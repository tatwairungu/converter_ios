//
//  KenyanFlagHeader.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import SwiftUI

struct KenyanFlagHeader: View {
    let title: String
    let subtitle: String
    let icon: String
    
    var body: some View {
        VStack(spacing: KenyanTheme.Spacing.md) {
            // Flag-inspired header bar
            HStack(spacing: 0) {
                Rectangle()
                    .fill(KenyanTheme.Colors.kenyanBlack)
                    .frame(height: 8)
                Rectangle()
                    .fill(KenyanTheme.Colors.kenyanRed)
                    .frame(height: 8)
                Rectangle()
                    .fill(KenyanTheme.Colors.kenyanGreen)
                    .frame(height: 8)
            }
            .cornerRadius(4)
            .padding(.horizontal)
            
            // Icon and titles
            VStack(spacing: KenyanTheme.Spacing.sm) {
                Image(systemName: icon)
                    .font(.system(size: 60))
                    .foregroundColor(KenyanTheme.Colors.primary)
                
                Text(title)
                    .font(KenyanTheme.Typography.largeTitle)
                    .foregroundColor(KenyanTheme.Colors.text)
                
                Text(subtitle)
                    .font(KenyanTheme.Typography.headline)
                    .foregroundColor(KenyanTheme.Colors.secondary)
                    .fontWeight(.medium)
            }
        }
        .padding(.top, KenyanTheme.Spacing.lg)
    }
}
