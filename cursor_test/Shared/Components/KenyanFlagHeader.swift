//
//  KenyanFlagHeader.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import SwiftUI

struct KenyanFlagHeader: View {
    let title: String
    let subtitle: String?
    let icon: String
    
    init(title: String, subtitle: String? = nil, icon: String) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
    }
    
    var body: some View {
        HStack(spacing: KenyanTheme.Spacing.md) {
            // Icon with subtle Kenyan flag branding
            ZStack {
                // Centered flag stripe background (behind icon)
                VStack(spacing: 1) {
                    Rectangle()
                        .fill(KenyanTheme.Colors.kenyanBlack)
                        .frame(width: 24, height: 2)
                    Rectangle()
                        .fill(KenyanTheme.Colors.secondary)
                        .frame(width: 24, height: 2)
                    Rectangle()
                        .fill(KenyanTheme.Colors.primary)
                        .frame(width: 24, height: 2)
                }
                .opacity(0.15)
                
                // Icon in front
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(KenyanTheme.Colors.primary)
            }
            
            // Title and subtitle
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(KenyanTheme.Typography.title)
                    .foregroundColor(KenyanTheme.Colors.text)
                    .fontWeight(.semibold)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(KenyanTheme.Typography.caption)
                        .foregroundColor(KenyanTheme.Colors.mutedText)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, KenyanTheme.Spacing.md)
        .frame(height: KenyanTheme.Spacing.headerHeight)
    }
}
