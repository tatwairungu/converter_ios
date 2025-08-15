//
//  SimpleCurrencyViewModel.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import Foundation
import SwiftUI

class SimpleCurrencyViewModel: ObservableObject {
    @Published var inputValue: String = ""
    @Published var resultValue: Double = 0.0
    @Published var showResult: Bool = false
    @Published var fromUnit: ConversionUnit = .kes
    @Published var toUnit: ConversionUnit = .usd
    @Published var isLoading: Bool = false
    @Published var lastUpdated: Date = Date()
    
    // Static exchange rates (updated periodically)
    private let exchangeRates: [String: Double] = [
        "KES": 1.0,       // Base currency
        "USD": 0.0069,    // 1 KES = 0.0069 USD
        "EUR": 0.0063,    // 1 KES = 0.0063 EUR
        "GBP": 0.0054,    // 1 KES = 0.0054 GBP
        "JPY": 1.02,      // 1 KES = 1.02 JPY
        "CAD": 0.0094,    // 1 KES = 0.0094 CAD
        "AUD": 0.0104     // 1 KES = 0.0104 AUD
    ]
    
    let availableUnits: [ConversionUnit] = [
        .kes, .usd, .eur, .gbp, .jpy, .cad, .aud
    ]
    
    var title: String {
        return ConverterType.currency.displayName + " Converter"
    }
    
    var subtitle: String {
        return "Convert \(fromUnit.name) to \(toUnit.name)"
    }
    
    var conversionDescription: String {
        return "\(inputValue) \(fromUnit.symbol) = \(String(format: "%.2f", resultValue)) \(toUnit.symbol)"
    }
    
    var conversionInfo: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        return "Rates updated: \(formatter.string(from: lastUpdated))"
    }
    
    var refreshButtonText: String {
        return isLoading ? "Updating..." : "Refresh Rates"
    }
    
    init() {
        performConversion()
    }
    
    func performConversion() {
        guard let inputDouble = Double(inputValue), inputDouble >= 0 else {
            showResult = false
            return
        }
        
        // Get exchange rates for both currencies
        let fromRate = exchangeRates[fromUnit.symbol] ?? 1.0
        let toRate = exchangeRates[toUnit.symbol] ?? 1.0
        
        // Convert: input -> KES -> target currency
        let kesValue = inputDouble / fromRate
        resultValue = kesValue * toRate
        
        showResult = true
    }
    
    func swapUnits() {
        let temp = fromUnit
        fromUnit = toUnit
        toUnit = temp
        performConversion()
    }
    
    func onInputChanged() {
        performConversion()
    }
    
    func onFromUnitChanged() {
        performConversion()
    }
    
    func onToUnitChanged() {
        performConversion()
    }
    
    // Simulate refresh for now (can be enhanced with real API later)
    func refreshExchangeRates() {
        isLoading = true
        
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.lastUpdated = Date()
            self.isLoading = false
            self.performConversion()
        }
    }
    
    // Get conversion rate info for display
    func getConversionRate() -> String {
        let fromRate = exchangeRates[fromUnit.symbol] ?? 1.0
        let toRate = exchangeRates[toUnit.symbol] ?? 1.0
        let rate = toRate / fromRate
        
        return "1 \(fromUnit.symbol) = \(String(format: "%.4f", rate)) \(toUnit.symbol)"
    }
}
