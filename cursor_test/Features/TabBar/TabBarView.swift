//
//  TabBarView.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            // Weight Converter Tab
            WeightConverterView()
                .tabItem {
                    Image(systemName: ConverterType.weight.icon)
                    Text(ConverterType.weight.displayName)
                }
                .tag(ConverterType.weight)
            
            // Length Converter Tab
            LengthConverterView()
                .tabItem {
                    Image(systemName: ConverterType.length.icon)
                    Text(ConverterType.length.displayName)
                }
                .tag(ConverterType.length)
            
            // Temperature Converter Tab
            TemperatureConverterView()
                .tabItem {
                    Image(systemName: ConverterType.temperature.icon)
                    Text(ConverterType.temperature.displayName)
                }
                .tag(ConverterType.temperature)
            
            // Currency Converter Tab
            CurrencyConverterView()
                .tabItem {
                    Image(systemName: ConverterType.currency.icon)
                    Text(ConverterType.currency.displayName)
                }
                .tag(ConverterType.currency)
        }
        .accentColor(KenyanTheme.Colors.primary)
    }
}
