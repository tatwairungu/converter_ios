//
//  ConverterType.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import Foundation

enum ConverterType: String, CaseIterable, Identifiable, Codable {
    case weight = "weight"
    case length = "length"
    case temperature = "temperature"
    case currency = "currency"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .weight: return "Weight"
        case .length: return "Length"
        case .temperature: return "Temperature"
        case .currency: return "Currency"
        }
    }
    
    var icon: String {
        switch self {
        case .weight: return "scalemass"
        case .length: return "ruler"
        case .temperature: return "thermometer"
        case .currency: return "dollarsign.circle"
        }
    }
    
    var subtitle: String {
        switch self {
        case .weight: return "Convert Kilograms to Grams"
        case .length: return "Convert Meters to Feet"
        case .temperature: return "Convert Celsius to Fahrenheit"
        case .currency: return "Convert KES to Other Currencies"
        }
    }
}
