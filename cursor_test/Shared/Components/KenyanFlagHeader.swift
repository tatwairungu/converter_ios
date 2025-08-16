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
            // Icon
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(KenyanTheme.Colors.primary)
            
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
