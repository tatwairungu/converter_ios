//
//  LengthConverterViewModel.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import Foundation
import SwiftUI

class LengthConverterViewModel: ObservableObject {
    @Published var inputValue: String = ""
    @Published var resultValue: Double = 0.0
    @Published var showResult: Bool = false
    @Published var fromUnit: ConversionUnit = .meters
    @Published var toUnit: ConversionUnit = .feet
    
    let availableUnits: [ConversionUnit] = [
        .meters, .centimeters, .kilometers, .feet, .inches, .miles
    ]
    
    var title: String {
        return ConverterType.length.displayName + " Converter"
    }
    
    var subtitle: String {
        return "Convert \(fromUnit.name) to \(toUnit.name)"
    }
    
    var conversionDescription: String {
        return "\(inputValue) \(fromUnit.symbol) = \(String(format: "%.2f", resultValue)) \(toUnit.symbol)"
    }
    
    var conversionInfo: String {
        let conversionFactor = 1 * fromUnit.conversionFactor / toUnit.conversionFactor
        return "1 \(fromUnit.symbol) = \(String(format: "%.4f", conversionFactor)) \(toUnit.symbol)"
    }
    
    init() {
        // Set up observer for input changes
        performConversion()
    }
    
    func performConversion() {
        guard let inputDouble = Double(inputValue), inputDouble >= 0 else {
            showResult = false
            return
        }
        
        // Convert to base unit (meters) then to target unit
        let baseValue = inputDouble * fromUnit.conversionFactor
        resultValue = baseValue / toUnit.conversionFactor
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
}
