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
            
            SimpleCurrencyConverterView()
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
