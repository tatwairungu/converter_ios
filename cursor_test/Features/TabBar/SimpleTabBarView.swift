//
//  SimpleTabBarView.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import SwiftUI

struct SimpleTabBarView: View {
    var body: some View {
        TabView {
            WeightConverterView()
                .tabItem {
                    Label("Weight", systemImage: "scalemass")
                }
            
            LengthConverterView()
                .tabItem {
                    Label("Length", systemImage: "ruler")
                }
            
            TemperatureConverterView()
                .tabItem {
                    Label("Temperature", systemImage: "thermometer")
                }
            
            // Simplified currency tab to avoid async issues
            VStack(spacing: KenyanTheme.Spacing.lg) {
                KenyanFlagHeader(
                    title: "Currency Converter",
                    subtitle: "Live exchange rates",
                    icon: "dollarsign.circle"
                )
                
                Text("💰 Coming Soon 💰")
                    .font(KenyanTheme.Typography.title)
                    .foregroundColor(KenyanTheme.Colors.secondary)
                
                Text("Currency converter with live API rates will be available in the next update!")
                    .font(KenyanTheme.Typography.body)
                    .foregroundColor(KenyanTheme.Colors.text)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
                
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
                    
                    Text("1 USD ≈ 143 KES")
                        .font(KenyanTheme.Typography.caption)
                        .foregroundColor(KenyanTheme.Colors.text)
                        .fontWeight(.medium)
                }
                .padding(.bottom)
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [KenyanTheme.Colors.background, Color.gray.opacity(0.05)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .tabItem {
                Label("Currency", systemImage: "dollarsign.circle")
            }
        }
        .accentColor(KenyanTheme.Colors.primary)
    }
}

#Preview {
    SimpleTabBarView()
}
