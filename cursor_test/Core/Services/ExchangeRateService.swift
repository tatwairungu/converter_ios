//
//  ExchangeRateService.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import Foundation

// MARK: - Exchange Rate API Models
public struct ExchangeRateResponse: Codable {
    let base: String
    let date: String
    let rates: [String: Double]
}

public struct CachedExchangeRates: Codable {
    let rates: [String: Double]
    let lastUpdated: Date
    let baseCurrency: String
}

// MARK: - Exchange Rate Service Protocol
public protocol ExchangeRateServiceProtocol {
    func fetchExchangeRates() async throws -> [String: Double]
    func getCachedRates() -> [String: Double]?
    func getLastUpdateTime() -> Date?
    func isDataStale() -> Bool
}

// MARK: - Exchange Rate Service Implementation
public class ExchangeRateService: ExchangeRateServiceProtocol, ObservableObject {
    
    public static let shared = ExchangeRateService()
    
    private let networkService: NetworkServiceProtocol
    private let apiURL = "https://api.exchangerate-api.com/v4/latest/KES"
    private let cacheKey = "cached_exchange_rates"
    private let staleThreshold: TimeInterval = 14400 // 4 hours
    
    // Fallback rates in case API fails
    private let fallbackRates: [String: Double] = [
        "KES": 1.0,
        "USD": 0.0069,
        "EUR": 0.0063,
        "GBP": 0.0054,
        "JPY": 1.02,
        "CAD": 0.0094,
        "AUD": 0.0104
    ]
    
    private init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    // MARK: - Public Methods
    
    public func fetchExchangeRates() async throws -> [String: Double] {
        guard let url = URL(string: apiURL) else {
            throw NetworkError.invalidURL
        }
        
        do {
            let response: ExchangeRateResponse = try await networkService.fetch(url: url)
            let rates = response.rates
            
            // Cache the successful response
            await cacheRates(rates)
            
            return rates
            
        } catch {
            print("API fetch failed: \(error.localizedDescription)")
            
            // Try to return cached rates if API fails
            if let cachedRates = getCachedRates() {
                print("Using cached exchange rates")
                return cachedRates
            }
            
            // Ultimate fallback to static rates
            print("Using fallback exchange rates")
            return fallbackRates
        }
    }
    
    public func getCachedRates() -> [String: Double]? {
        guard let data = UserDefaults.standard.data(forKey: cacheKey),
              let cached = try? JSONDecoder().decode(CachedExchangeRates.self, from: data) else {
            return nil
        }
        
        return cached.rates
    }
    
    public func getLastUpdateTime() -> Date? {
        guard let data = UserDefaults.standard.data(forKey: cacheKey),
              let cached = try? JSONDecoder().decode(CachedExchangeRates.self, from: data) else {
            return nil
        }
        
        return cached.lastUpdated
    }
    
    public func isDataStale() -> Bool {
        guard let lastUpdate = getLastUpdateTime() else {
            return true // No cached data, consider it stale
        }
        
        return Date().timeIntervalSince(lastUpdate) > staleThreshold
    }
    
    // MARK: - Private Methods
    
    @MainActor
    private func cacheRates(_ rates: [String: Double]) {
        let cached = CachedExchangeRates(
            rates: rates,
            lastUpdated: Date(),
            baseCurrency: "KES"
        )
        
        if let data = try? JSONEncoder().encode(cached) {
            UserDefaults.standard.set(data, forKey: cacheKey)
            print("Exchange rates cached successfully")
        }
    }
    
    // MARK: - Utility Methods
    
    public func getRatesWithFallback() -> [String: Double] {
        // Try cached rates first
        if let cachedRates = getCachedRates(), !isDataStale() {
            return cachedRates
        }
        
        // Return fallback rates if no valid cache
        return fallbackRates
    }
    
    public func getDataAge() -> String {
        guard let lastUpdate = getLastUpdateTime() else {
            return "No data"
        }
        
        let timeInterval = Date().timeIntervalSince(lastUpdate)
        let hours = Int(timeInterval / 3600)
        let minutes = Int((timeInterval.truncatingRemainder(dividingBy: 3600)) / 60)
        
        if hours > 0 {
            return "\(hours)h \(minutes)m ago"
        } else {
            return "\(minutes)m ago"
        }
    }
}
