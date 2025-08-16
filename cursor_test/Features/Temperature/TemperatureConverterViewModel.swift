//
//  TemperatureConverterViewModel.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import Foundation
import SwiftUI

class TemperatureConverterViewModel: ObservableObject {
    @Published var inputValue: String = ""
    @Published var resultValue: Double = 0.0
    @Published var showResult: Bool = false
    @Published var fromUnit: ConversionUnit = .celsius
    @Published var toUnit: ConversionUnit = .fahrenheit
    @Published var hasKelvinError: Bool = false
    
    let availableUnits: [ConversionUnit] = [
        .celsius, .fahrenheit, .kelvin
    ]
    
    var title: String {
        return ConverterType.temperature.displayName + " Converter"
    }
    
    var subtitle: String {
        return "Convert \(fromUnit.name) to \(toUnit.name)"
    }
    
    var conversionDescription: String {
        return "\(inputValue) \(fromUnit.symbol) = \(String(format: "%.2f", resultValue)) \(toUnit.symbol)"
    }
    
    var conversionInfo: String {
        // Show common reference points
        switch (fromUnit.id, toUnit.id) {
        case ("c", "f"):
            return "0°C = 32°F | 100°C = 212°F"
        case ("f", "c"):
            return "32°F = 0°C | 212°F = 100°C"
        case ("c", "k"):
            return "0°C = 273.15K | 100°C = 373.15K"
        case ("k", "c"):
            return "273.15K = 0°C | 373.15K = 100°C"
        case ("f", "k"):
            return "32°F = 273.15K | 212°F = 373.15K"
        case ("k", "f"):
            return "273.15K = 32°F | 373.15K = 212°F"
        default:
            return "Temperature conversion"
        }
    }
    
    init() {
        performConversion()
    }
    
    func performConversion() {
        guard let inputDouble = Double(inputValue) else {
            showResult = false
            hasKelvinError = false
            return
        }
        
        // Check for Kelvin validation
        hasKelvinError = (toUnit.id == "k" && resultValue < 0) || 
                        (fromUnit.id == "k" && inputDouble < 0)
        
        // Temperature conversions are not linear, need special handling
        resultValue = convertTemperature(value: inputDouble, from: fromUnit, to: toUnit)
        
        // Recheck Kelvin error after conversion
        if toUnit.id == "k" && resultValue < 0 {
            hasKelvinError = true
        }
        
        showResult = true
    }
    
    private func convertTemperature(value: Double, from: ConversionUnit, to: ConversionUnit) -> Double {
        // Convert from input unit to Celsius first
        let celsius: Double
        switch from.id {
        case "c":
            celsius = value
        case "f":
            celsius = (value - 32) * 5/9
        case "k":
            celsius = value - 273.15
        default:
            celsius = value
        }
        
        // Convert from Celsius to target unit
        switch to.id {
        case "c":
            return celsius
        case "f":
            return celsius * 9/5 + 32
        case "k":
            return celsius + 273.15
        default:
            return celsius
        }
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
    
    // Temperature validation and context
    func getTemperatureContext(celsius: Double) -> String {
        switch celsius {
        case ..<(-40):
            return "❄️ Extremely cold"
        case -40..<0:
            return "🧊 Freezing"
        case 0..<10:
            return "🥶 Cold"
        case 10..<20:
            return "😊 Cool"
        case 20..<30:
            return "🌤️ Comfortable"
        case 30..<40:
            return "🌞 Hot"
        case 40...:
            return "🔥 Extremely hot"
        default:
            return ""
        }
    }
}
