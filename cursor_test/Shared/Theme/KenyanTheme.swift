//
//  KenyanTheme.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import SwiftUI

struct KenyanTheme {
    // MARK: - Colors
    struct Colors {
        static let kenyanBlack = Color(red: 0.0, green: 0.0, blue: 0.0)
        static let kenyanRed = Color(red: 0.8, green: 0.0, blue: 0.0)
        static let kenyanGreen = Color(red: 0.0, green: 0.4, blue: 0.0)
        static let kenyanWhite = Color.white
        
        // Semantic colors
        static let primary = kenyanGreen
        static let secondary = kenyanRed
        static let text = kenyanBlack
        static let background = kenyanWhite
        static let accent = kenyanRed
    }
    
    // MARK: - Typography
    struct Typography {
        static let largeTitle = Font.largeTitle.weight(.bold)
        static let title = Font.title.weight(.semibold)
        static let headline = Font.headline.weight(.medium)
        static let body = Font.body
        static let caption = Font.caption
    }
    
    // MARK: - Spacing
    struct Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
        static let xxl: CGFloat = 48
    }
    
    // MARK: - Corner Radius
    struct CornerRadius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
    }
}
