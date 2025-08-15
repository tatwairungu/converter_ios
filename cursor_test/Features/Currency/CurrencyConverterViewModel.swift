//
//  CurrencyConverterViewModel.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import Foundation
import SwiftUI

@MainActor
class CurrencyConverterViewModel: ObservableObject {
    @Published var inputValue: String = ""
    @Published var resultValue: Double = 0.0
    @Published var showResult: Bool = false
    @Published var fromUnit: ConversionUnit = .kes
    @Published var toUnit: ConversionUnit = .usd
    @Published var isLoading: Bool = false
    @Published var lastUpdated: Date?
    @Published var errorMessage: String?
    
    private var exchangeRates: [String: Double] = [:]
    
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
        if let lastUpdated = lastUpdated {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.dateStyle = .short
            return "Last updated: \(formatter.string(from: lastUpdated))"
        } else {
            return "Tap refresh to get live rates"
        }
    }
    
    var refreshButtonText: String {
        return isLoading ? "Updating..." : "Refresh Rates"
    }
    
    init() {
        loadCachedRates()
        performConversion()
    }
    
    func performConversion() {
        guard let inputDouble = Double(inputValue), inputDouble >= 0 else {
            showResult = false
            return
        }
        
        // Convert using exchange rates
        if fromUnit.id == "kes" {
            // Converting from KES to other currency
            if let rate = exchangeRates[toUnit.id.uppercased()] {
                resultValue = inputDouble * rate
            } else {
                resultValue = inputDouble * toUnit.conversionFactor
            }
        } else if toUnit.id == "kes" {
            // Converting to KES from other currency
            if let rate = exchangeRates[fromUnit.id.uppercased()] {
                resultValue = inputDouble / rate
            } else {
                resultValue = inputDouble / fromUnit.conversionFactor
            }
        } else {
            // Converting between two non-KES currencies
            // Convert to KES first, then to target currency
            let kesValue: Double
            if let fromRate = exchangeRates[fromUnit.id.uppercased()] {
                kesValue = inputDouble / fromRate
            } else {
                kesValue = inputDouble / fromUnit.conversionFactor
            }
            
            if let toRate = exchangeRates[toUnit.id.uppercased()] {
                resultValue = kesValue * toRate
            } else {
                resultValue = kesValue * toUnit.conversionFactor
            }
        }
        
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
    
    // MARK: - API Integration
    func refreshExchangeRates() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let url = URL(string: "https://api.exchangerate-api.com/v4/latest/KES")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(ExchangeRateResponse.self, from: data)
            
            // Update exchange rates
            exchangeRates = response.rates
            lastUpdated = Date()
            
            // Cache the rates
            saveRatesToCache()
            
            // Recalculate conversion with new rates
            performConversion()
            
        } catch {
            errorMessage = "Failed to fetch exchange rates: \(error.localizedDescription)"
            print("Currency API Error: \(error)")
        }
        
        isLoading = false
    }
    
    // MARK: - Caching
    private func saveRatesToCache() {
        UserDefaults.standard.set(exchangeRates, forKey: "cached_exchange_rates")
        UserDefaults.standard.set(lastUpdated, forKey: "last_rate_update")
    }
    
    private func loadCachedRates() {
        if let cachedRates = UserDefaults.standard.object(forKey: "cached_exchange_rates") as? [String: Double] {
            exchangeRates = cachedRates
        }
        
        if let cachedDate = UserDefaults.standard.object(forKey: "last_rate_update") as? Date {
            lastUpdated = cachedDate
        }
        
        // Set some default rates if no cache exists
        if exchangeRates.isEmpty {
            exchangeRates = [
                "USD": 0.007,
                "EUR": 0.006,
                "GBP": 0.005,
                "JPY": 1.0,
                "CAD": 0.009,
                "AUD": 0.010
            ]
        }
    }
}
