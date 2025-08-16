//
//  KenyanTheme.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import SwiftUI

struct KenyanTheme {
    // MARK: - Colors (Updated for Design Refactor)
    struct Colors {
        // Kenyan flag colors (refined)
        static let kenyanBlack = Color(hex: "#111827")        // Neutral near-black for text
        static let kenyanRed = Color(hex: "#C1121F")          // Kenyan red for warnings/emphasis
        static let kenyanGreen = Color(hex: "#0B6E4F")        // Kenyan green for primary actions
        static let kenyanWhite = Color(hex: "#FFFFFF")        // Pure white background
        
        // Semantic colors (Design Refactor mapping)
        static let primary = kenyanGreen                      // Focus, selection, active states
        static let secondary = kenyanRed                      // Warnings, errors only
        static let accent = kenyanGreen                       // Changed from red to green
        
        // Adaptive colors for light/dark mode
        static let text = Color.primary                       // Adapts to dark mode
        static let background = Color(UIColor.systemBackground) // Adapts to dark mode
        static let adaptiveSurface = Color(UIColor.secondarySystemBackground) // Card surfaces
        
        // Neutrals (added for modern UI)
        static let surface = Color(hex: "#F7F7F7")           // Card/field surfaces
        static let border = Color(hex: "#E5E7EB")            // Neutral borders
        static let mutedText = Color(hex: "#6B7280")         // Secondary text
        static let placeholder = Color(hex: "#9CA3AF")        // Placeholder text
        
        // Dark mode colors
        static let darkBackground = Color(hex: "#0B0B0B")     // Dark background
        static let darkCard = Color(hex: "#111111")           // Dark card surface
        static let darkBorder = Color(hex: "#2A2A2A")         // Dark border
        static let darkText = Color(hex: "#E5E7EB")           // Dark mode text
        static let darkMuted = Color(hex: "#9CA3AF")          // Dark mode muted text
    }
    
    // MARK: - Typography (Enhanced with semantic naming)
    struct Typography {
        static let largeTitle = Font.largeTitle.weight(.bold)     // Result numbers & screen titles
        static let title = Font.title.weight(.semibold)          // Section titles ("From", "To")
        static let headline = Font.headline.weight(.medium)       // Field labels, capsule chips
        static let body = Font.body                               // Input text, picker rows
        static let caption = Font.caption                         // Helper text, error messages
        static let result = Font.system(size: 36, weight: .bold, design: .rounded)  // Large result display
    }
    
    // MARK: - Spacing (8pt grid system)
    struct Spacing {
        static let xs: CGFloat = 4      // 0.5 × base
        static let sm: CGFloat = 8      // 1 × base
        static let md: CGFloat = 16     // 2 × base (between related items)
        static let lg: CGFloat = 24     // 3 × base (between sections)
        static let xl: CGFloat = 32     // 4 × base
        static let xxl: CGFloat = 48    // 6 × base
        
        // Layout-specific spacing
        static let headerHeight: CGFloat = 64      // Header target height
        static let inputHeight: CGFloat = 56       // Input field height
        static let resultHeight: CGFloat = 112     // Result card height
        static let swapButtonSize: CGFloat = 40    // Swap button dimensions
    }
    
    // MARK: - Corner Radius (Updated values)
    struct CornerRadius {
        static let small: CGFloat = 8               // Small elements
        static let medium: CGFloat = 12             // Cards, fields
        static let large: CGFloat = 16              // Large cards
        static let button: CGFloat = 20             // Circular buttons
        static let swap: CGFloat = 20               // Swap button (circular)
    }
    
    // MARK: - Shadows & Elevation
    struct Shadow {
        static let subtle = (color: Color.black.opacity(0.05), radius: CGFloat(2), x: CGFloat(0), y: CGFloat(1))
        static let card = (color: Color.black.opacity(0.1), radius: CGFloat(8), x: CGFloat(0), y: CGFloat(4))
        static let elevated = (color: Color.black.opacity(0.15), radius: CGFloat(16), x: CGFloat(0), y: CGFloat(8))
    }
    
    // MARK: - Animation Durations
    struct Animation {
        static let fast: Double = 0.15          // Quick feedback (150ms)
        static let standard: Double = 0.2       // Standard transitions (200ms)
        static let swap: Double = 0.18          // Swap button rotation (180ms)
        static let keyboard: Double = 0.25      // Keyboard animations
    }
    
    // MARK: - Touch Targets (Accessibility)
    struct TouchTarget {
        static let minimum: CGFloat = 44        // WCAG AA minimum
        static let comfortable: CGFloat = 48    // More comfortable target
    }
}

// MARK: - Color Extension for Hex Support
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
