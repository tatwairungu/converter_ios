//
//  ConversionUnit.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import Foundation

struct ConversionUnit: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let symbol: String
    let conversionFactor: Double
    let converterType: ConverterType
    
    init(id: String, name: String, symbol: String, conversionFactor: Double, type: ConverterType) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.conversionFactor = conversionFactor
        self.converterType = type
    }
}

// MARK: - Predefined Units
extension ConversionUnit {
    // MARK: - Weight Units (base: grams)
    static let kilograms = ConversionUnit(id: "kg", name: "Kilograms", symbol: "kg", conversionFactor: 1000.0, type: .weight)
    static let grams = ConversionUnit(id: "g", name: "Grams", symbol: "g", conversionFactor: 1.0, type: .weight)
    static let pounds = ConversionUnit(id: "lbs", name: "Pounds", symbol: "lbs", conversionFactor: 453.592, type: .weight)
    static let ounces = ConversionUnit(id: "oz", name: "Ounces", symbol: "oz", conversionFactor: 28.3495, type: .weight)
    
    // MARK: - Length Units (base: meters)
    static let meters = ConversionUnit(id: "m", name: "Meters", symbol: "m", conversionFactor: 1.0, type: .length)
    static let centimeters = ConversionUnit(id: "cm", name: "Centimeters", symbol: "cm", conversionFactor: 0.01, type: .length)
    static let kilometers = ConversionUnit(id: "km", name: "Kilometers", symbol: "km", conversionFactor: 1000.0, type: .length)
    static let feet = ConversionUnit(id: "ft", name: "Feet", symbol: "ft", conversionFactor: 0.3048, type: .length)
    static let inches = ConversionUnit(id: "in", name: "Inches", symbol: "in", conversionFactor: 0.0254, type: .length)
    static let miles = ConversionUnit(id: "mi", name: "Miles", symbol: "mi", conversionFactor: 1609.34, type: .length)
    
    // MARK: - Temperature Units (base: Celsius)
    static let celsius = ConversionUnit(id: "c", name: "Celsius", symbol: "°C", conversionFactor: 1.0, type: .temperature)
    static let fahrenheit = ConversionUnit(id: "f", name: "Fahrenheit", symbol: "°F", conversionFactor: 1.0, type: .temperature)
    static let kelvin = ConversionUnit(id: "k", name: "Kelvin", symbol: "K", conversionFactor: 1.0, type: .temperature)
    
    // MARK: - Currency Units (base: KES)
    static let kes = ConversionUnit(id: "kes", name: "Kenyan Shilling", symbol: "KES", conversionFactor: 1.0, type: .currency)
    static let usd = ConversionUnit(id: "usd", name: "US Dollar", symbol: "USD", conversionFactor: 0.007, type: .currency) // Approximate
    static let eur = ConversionUnit(id: "eur", name: "Euro", symbol: "EUR", conversionFactor: 0.006, type: .currency) // Approximate
    static let gbp = ConversionUnit(id: "gbp", name: "British Pound", symbol: "GBP", conversionFactor: 0.005, type: .currency) // Approximate
    static let jpy = ConversionUnit(id: "jpy", name: "Japanese Yen", symbol: "JPY", conversionFactor: 1.0, type: .currency) // Approximate
    static let cad = ConversionUnit(id: "cad", name: "Canadian Dollar", symbol: "CAD", conversionFactor: 0.009, type: .currency) // Approximate
    static let aud = ConversionUnit(id: "aud", name: "Australian Dollar", symbol: "AUD", conversionFactor: 0.010, type: .currency) // Approximate
}
