//
//  WeightConverterViewModel.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import Foundation
import SwiftUI

@MainActor
class WeightConverterViewModel: ObservableObject {
    @Published var inputValue: String = ""
    @Published var resultValue: Double = 0.0
    @Published var showResult: Bool = false
    @Published var fromUnit: ConversionUnit = .kilogram
    @Published var toUnit: ConversionUnit = .gram
    
    let availableUnits: [ConversionUnit] = [
        .kilogram, .gram, .pound, .ounce, .stone, .ton
    ]
    
    var title: String {
        return ConverterType.weight.displayName + " Converter"
    }
    
    var subtitle: String {
        return "Convert \(fromUnit.name) to \(toUnit.name)"
    }
    
    var conversionDescription: String {
        return "\(inputValue) \(fromUnit.symbol) = \(String(format: "%.2f", resultValue)) \(toUnit.symbol)"
    }
    
    var conversionInfo: String {
        let rate = toUnit.conversionFactor / fromUnit.conversionFactor
        return "1 \(fromUnit.symbol) = \(String(format: "%.4f", rate)) \(toUnit.symbol)"
    }
    
    func performConversion() {
        guard let inputDouble = Double(inputValue), inputDouble >= 0 else {
            showResult = false
            return
        }
        
        // Convert from input unit to kg (base), then to target unit
        let kilograms = inputDouble * fromUnit.conversionFactor
        resultValue = kilograms / toUnit.conversionFactor
        
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
