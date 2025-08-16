//
//  LiveCurrencyViewModel.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import Foundation
import SwiftUI

@MainActor
class LiveCurrencyViewModel: ObservableObject {
    @Published var inputValue: String = ""
    @Published var resultValue: Double = 0.0
    @Published var showResult: Bool = false
    @Published var fromUnit: ConversionUnit = .kes
    @Published var toUnit: ConversionUnit = .usd
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var lastUpdated: Date?
    @Published var dataAge: String = "No data"
    
    private let exchangeRateService: ExchangeRateServiceProtocol
    private var currentRates: [String: Double] = [:]
    
    let availableUnits: [ConversionUnit] = [
        .kes, .usd, .eur, .gbp, .jpy, .cad, .aud
    ]
    
    init(exchangeRateService: ExchangeRateServiceProtocol = ExchangeRateService.shared) {
        self.exchangeRateService = exchangeRateService
        loadInitialData()
    }
    
    // MARK: - Computed Properties
    
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
    
    var isDataStale: Bool {
        return exchangeRateService.isDataStale()
    }
    
    var isOnline: Bool {
        return exchangeRateService.checkConnection()
    }
    
    var lastUpdateTimeFormatted: String {
        if let lastUpdated = lastUpdated {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter.string(from: lastUpdated)
        } else {
            return "Never"
        }
    }
    
    // MARK: - Public Methods
    
    func performConversion() {
        guard let inputDouble = Double(inputValue), inputDouble >= 0 else {
            showResult = false
            return
        }
        
        // Get exchange rates for both currencies
        let fromRate = currentRates[fromUnit.symbol] ?? 1.0
        let toRate = currentRates[toUnit.symbol] ?? 1.0
        
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
    
    func refreshExchangeRates() async {
        // Skip API calls in preview mode to prevent crashes
        #if DEBUG
        guard !ProcessInfo.processInfo.environment.keys.contains("XCODE_RUNNING_FOR_PREVIEWS") else {
            simulateRefresh()
            return
        }
        #endif
        
        isLoading = true
        errorMessage = nil
        
        do {
            let rates = try await exchangeRateService.fetchExchangeRates()
            currentRates = rates
            lastUpdated = Date()
            updateDataAge()
            performConversion()
            
        } catch {
            errorMessage = "Failed to update rates: \(error.localizedDescription)"
            print("Currency refresh error: \(error)")
            
            // Use cached or fallback rates
            loadFallbackData()
        }
        
        isLoading = false
    }
    
    func getConversionRate() -> String {
        let fromRate = currentRates[fromUnit.symbol] ?? 1.0
        let toRate = currentRates[toUnit.symbol] ?? 1.0
        let rate = toRate / fromRate
        
        return "1 \(fromUnit.symbol) = \(String(format: "%.4f", rate)) \(toUnit.symbol)"
    }
    
    // MARK: - Private Methods
    
    private func loadInitialData() {
        // Load cached rates first for immediate functionality
        if let cachedRates = exchangeRateService.getCachedRates() {
            currentRates = cachedRates
            lastUpdated = exchangeRateService.getLastUpdateTime()
        } else {
            loadFallbackData()
        }
        
        updateDataAge()
        performConversion()
        
        // Auto-refresh if data is stale
        if exchangeRateService.isDataStale() {
            Task {
                await refreshExchangeRates()
            }
        }
    }
    
    private func loadFallbackData() {
        // Use the service's fallback rates
        if let service = exchangeRateService as? ExchangeRateService {
            currentRates = service.getRatesWithFallback()
        } else {
            // Ultimate fallback
            currentRates = [
                "KES": 1.0, "USD": 0.0069, "EUR": 0.0063,
                "GBP": 0.0054, "JPY": 1.02, "CAD": 0.0094, "AUD": 0.0104
            ]
        }
        performConversion()
    }
    
    private func simulateRefresh() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.lastUpdated = Date()
            self.updateDataAge()
            self.isLoading = false
            self.performConversion()
        }
    }
    
    private func updateDataAge() {
        if let service = exchangeRateService as? ExchangeRateService {
            dataAge = service.getDataAge()
        } else if let lastUpdated = lastUpdated {
            let timeInterval = Date().timeIntervalSince(lastUpdated)
            let minutes = Int(timeInterval / 60)
            dataAge = "\(minutes)m ago"
        } else {
            dataAge = "No data"
        }
    }
}
