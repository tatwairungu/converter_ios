# 🏗️ Kenya Converter App - Technical Architecture

## 📋 Overview
This document outlines the technical architecture, file structure, data models, and implementation patterns for the Kenya Converter app.

---

## 📁 Project File Structure

```
cursor_test/
├── cursor_test/
│   ├── App/
│   │   ├── cursor_testApp.swift                 # App entry point
│   │   └── Info.plist                          # App configuration
│   │
│   ├── Core/
│   │   ├── Models/
│   │   │   ├── ConverterType.swift              # Enum for converter types
│   │   │   ├── ConversionUnit.swift             # Unit data model
│   │   │   ├── Converter.swift                  # Main converter model
│   │   │   └── ConversionHistory.swift          # History data model
│   │   │
│   │   ├── Services/
│   │   │   ├── ConversionService.swift          # Business logic for conversions
│   │   │   ├── CurrencyService.swift            # API service for currency rates
│   │   │   ├── HistoryService.swift             # Local storage for history
│   │   │   └── NetworkService.swift             # Generic network layer
│   │   │
│   │   └── Extensions/
│   │       ├── Double+Formatting.swift          # Number formatting extensions
│   │       ├── String+Validation.swift          # Input validation
│   │       └── Color+KenyanTheme.swift          # Color extensions
│   │
│   ├── Features/
│   │   ├── TabBar/
│   │   │   ├── TabBarView.swift                 # Main tab container
│   │   │   └── TabBarViewModel.swift            # Tab state management
│   │   │
│   │   ├── Weight/
│   │   │   ├── WeightConverterView.swift        # Weight converter UI
│   │   │   └── WeightConverterViewModel.swift   # Weight converter logic
│   │   │
│   │   ├── Length/
│   │   │   ├── LengthConverterView.swift        # Length converter UI
│   │   │   └── LengthConverterViewModel.swift   # Length converter logic
│   │   │
│   │   ├── Temperature/
│   │   │   ├── TemperatureConverterView.swift   # Temperature converter UI
│   │   │   └── TemperatureConverterViewModel.swift # Temperature logic
│   │   │
│   │   └── Currency/
│   │       ├── CurrencyConverterView.swift      # Currency converter UI
│   │       ├── CurrencyConverterViewModel.swift # Currency converter logic
│   │       └── CurrencyRateView.swift           # Live rates display
│   │
│   ├── Shared/
│   │   ├── Components/
│   │   │   ├── ConverterView.swift              # Reusable converter template
│   │   │   ├── KenyanFlagHeader.swift           # Flag stripe component
│   │   │   ├── ConversionInput.swift            # Custom input field
│   │   │   ├── ConversionResult.swift           # Result display component
│   │   │   └── LoadingView.swift                # Loading state component
│   │   │
│   │   ├── Theme/
│   │   │   ├── KenyanTheme.swift                # Color scheme & styling
│   │   │   ├── Typography.swift                 # Font definitions
│   │   │   └── Spacing.swift                    # Layout constants
│   │   │
│   │   └── Utilities/
│   │       ├── Constants.swift                  # App-wide constants
│   │       ├── Formatters.swift                 # Number/text formatters
│   │       └── Validators.swift                 # Input validation logic
│   │
│   ├── Resources/
│   │   ├── Assets.xcassets/                     # Images and colors
│   │   ├── Localizable.strings                  # Localization strings
│   │   └── LaunchScreen.storyboard              # Launch screen
│   │
│   └── Tests/
│       ├── UnitTests/
│       │   ├── ConversionServiceTests.swift
│       │   ├── CurrencyServiceTests.swift
│       │   └── ValidationTests.swift
│       │
│       └── UITests/
│           ├── TabNavigationTests.swift
│           └── ConversionFlowTests.swift
│
├── cursor_testTests/                            # Generated test files
├── cursor_testUITests/                          # Generated UI test files
├── cursor_test.xcodeproj/                       # Xcode project files
├── .gitignore                                   # Git ignore rules
├── PLAN.md                                      # Development plan
├── ARCHITECTURE.md                              # This file
└── README.md                                    # Project documentation
```

---

## 🏛️ Architecture Patterns

### **MVVM (Model-View-ViewModel) Pattern**
- **Models**: Data structures and business entities
- **Views**: SwiftUI views for UI presentation
- **ViewModels**: Business logic and state management

### **Service Layer Pattern**
- **Services**: Encapsulate business logic and external dependencies
- **Repository Pattern**: Abstract data access (local storage, API calls)
- **Dependency Injection**: Services injected into ViewModels

### **Component-Based Architecture**
- **Reusable Components**: Shared UI components across converters
- **Composition over Inheritance**: Build complex views from simple components
- **Single Responsibility**: Each component has one clear purpose

---

## 📊 Data Models

### **Core Models**

```swift
// MARK: - ConverterType.swift
enum ConverterType: String, CaseIterable, Identifiable {
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
}
```

```swift
// MARK: - ConversionUnit.swift
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
```

```swift
// MARK: - Converter.swift
struct Converter: Identifiable {
    let id: String
    let type: ConverterType
    let units: [ConversionUnit]
    let defaultFromUnit: ConversionUnit
    let defaultToUnit: ConversionUnit
    
    func convert(value: Double, from: ConversionUnit, to: ConversionUnit) -> Double {
        // Base conversion logic
        let baseValue = value * from.conversionFactor
        return baseValue / to.conversionFactor
    }
}
```

```swift
// MARK: - ConversionHistory.swift
struct ConversionHistory: Identifiable, Codable {
    let id: UUID
    let converterType: ConverterType
    let fromValue: Double
    let fromUnit: ConversionUnit
    let toValue: Double
    let toUnit: ConversionUnit
    let timestamp: Date
    
    init(converterType: ConverterType, fromValue: Double, fromUnit: ConversionUnit, 
         toValue: Double, toUnit: ConversionUnit) {
        self.id = UUID()
        self.converterType = converterType
        self.fromValue = fromValue
        self.fromUnit = fromUnit
        self.toValue = toValue
        self.toUnit = toUnit
        self.timestamp = Date()
    }
}
```

---

## 🔧 Service Layer

### **ConversionService**
```swift
// MARK: - ConversionService.swift
protocol ConversionServiceProtocol {
    func getConverter(for type: ConverterType) -> Converter
    func convert(value: Double, from: ConversionUnit, to: ConversionUnit) -> Double
    func getAllUnits(for type: ConverterType) -> [ConversionUnit]
}

class ConversionService: ConversionServiceProtocol {
    static let shared = ConversionService()
    
    private let converters: [ConverterType: Converter]
    
    private init() {
        // Initialize all converters with their units
        self.converters = ConversionService.setupConverters()
    }
    
    // Implementation methods...
}
```

### **CurrencyService**
```swift
// MARK: - CurrencyService.swift
protocol CurrencyServiceProtocol {
    func fetchExchangeRates() async throws -> [String: Double]
    func getCachedRate(for currency: String) -> Double?
    func getLastUpdateTime() -> Date?
}

class CurrencyService: CurrencyServiceProtocol, ObservableObject {
    @Published var exchangeRates: [String: Double] = [:]
    @Published var lastUpdated: Date?
    @Published var isLoading: Bool = false
    
    private let apiKey = "YOUR_API_KEY"
    private let baseURL = "https://api.exchangerate-api.com/v4/latest"
    
    // Implementation methods...
}
```

---

## 🎨 Theme System

### **KenyanTheme**
```swift
// MARK: - KenyanTheme.swift
struct KenyanTheme {
    // MARK: - Colors
    struct Colors {
        static let kenyanBlack = Color(red: 0.0, green: 0.0, blue: 0.0)
        static let kenyanRed = Color(red: 0.8, green: 0.0, blue: 0.0)
        static let kenyanGreen = Color(red: 0.0, green: 0.4, blue: 0.0)
        static let kenyanWhite = Color.white
        
        // Semantic colors
        static let primary = kenyanGreen
        static let secondary = kenyanRed
        static let text = kenyanBlack
        static let background = kenyanWhite
        static let accent = kenyanRed
    }
    
    // MARK: - Typography
    struct Typography {
        static let largeTitle = Font.largeTitle.weight(.bold)
        static let title = Font.title.weight(.semibold)
        static let headline = Font.headline.weight(.medium)
        static let body = Font.body
        static let caption = Font.caption
    }
    
    // MARK: - Spacing
    struct Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
        static let xxl: CGFloat = 48
    }
    
    // MARK: - Corner Radius
    struct CornerRadius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
    }
}
```

---

## 🧩 Reusable Components

### **ConverterView (Generic Template)**
```swift
// MARK: - ConverterView.swift
struct ConverterView<ViewModel: ConverterViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: KenyanTheme.Spacing.lg) {
            // Kenyan flag header
            KenyanFlagHeader(title: viewModel.title, subtitle: viewModel.subtitle)
            
            // Input section
            ConversionInput(
                value: $viewModel.inputValue,
                unit: viewModel.fromUnit,
                placeholder: "0.0"
            )
            
            // Unit selection
            UnitSelector(
                fromUnit: $viewModel.fromUnit,
                toUnit: $viewModel.toUnit,
                availableUnits: viewModel.availableUnits
            )
            
            // Result display
            if viewModel.showResult {
                ConversionResult(
                    value: viewModel.resultValue,
                    unit: viewModel.toUnit,
                    description: viewModel.conversionDescription
                )
            }
            
            Spacer()
            
            // Info footer
            KenyanFlagFooter(info: viewModel.conversionInfo)
        }
        .background(KenyanTheme.Colors.background)
    }
}
```

### **Component Protocols**
```swift
// MARK: - ConverterViewModelProtocol.swift
protocol ConverterViewModelProtocol: ObservableObject {
    var title: String { get }
    var subtitle: String { get }
    var inputValue: String { get set }
    var resultValue: Double { get }
    var showResult: Bool { get }
    var fromUnit: ConversionUnit { get set }
    var toUnit: ConversionUnit { get set }
    var availableUnits: [ConversionUnit] { get }
    var conversionDescription: String { get }
    var conversionInfo: String { get }
    
    func performConversion()
    func swapUnits()
}
```

---

## 🌐 Networking Layer

### **NetworkService**
```swift
// MARK: - NetworkService.swift
protocol NetworkServiceProtocol {
    func fetch<T: Codable>(url: URL) async throws -> T
    func isConnected() -> Bool
}

class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    
    private let session: URLSession
    
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10.0
        config.timeoutIntervalForResource = 30.0
        self.session = URLSession(configuration: config)
    }
    
    func fetch<T: Codable>(url: URL) async throws -> T {
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            throw NetworkError.invalidResponse
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func isConnected() -> Bool {
        // Network reachability check
        return true // Simplified for now
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case networkUnavailable
}
```

---

## 💾 Data Persistence

### **UserDefaults Extensions**
```swift
// MARK: - UserDefaults+Extensions.swift
extension UserDefaults {
    private enum Keys {
        static let conversionHistory = "conversion_history"
        static let cachedExchangeRates = "cached_exchange_rates"
        static let lastRateUpdate = "last_rate_update"
        static let userPreferences = "user_preferences"
    }
    
    // History management
    func saveConversionHistory(_ history: [ConversionHistory]) {
        if let data = try? JSONEncoder().encode(history) {
            set(data, forKey: Keys.conversionHistory)
        }
    }
    
    func getConversionHistory() -> [ConversionHistory] {
        guard let data = data(forKey: Keys.conversionHistory),
              let history = try? JSONDecoder().decode([ConversionHistory].self, from: data) else {
            return []
        }
        return history
    }
    
    // Exchange rates caching
    func saveCachedRates(_ rates: [String: Double]) {
        if let data = try? JSONEncoder().encode(rates) {
            set(data, forKey: Keys.cachedExchangeRates)
            set(Date(), forKey: Keys.lastRateUpdate)
        }
    }
    
    func getCachedRates() -> [String: Double]? {
        guard let data = data(forKey: Keys.cachedExchangeRates),
              let rates = try? JSONDecoder().decode([String: Double].self, from: data) else {
            return nil
        }
        return rates
    }
}
```

---

## 🧪 Testing Strategy

### **Unit Tests**
- **ConversionService**: Test all conversion calculations
- **CurrencyService**: Test API integration and caching
- **ViewModels**: Test business logic and state management
- **Utilities**: Test validation and formatting functions

### **UI Tests**
- **Navigation**: Test tab switching and navigation flows
- **Conversion Flow**: Test end-to-end conversion scenarios
- **Input Validation**: Test error handling and edge cases
- **Accessibility**: Test VoiceOver and accessibility features

### **Integration Tests**
- **API Integration**: Test currency service with real API
- **Data Persistence**: Test history and caching functionality
- **Cross-converter**: Test switching between converter types

---

## 🚀 Performance Considerations

### **Memory Management**
- Use `@StateObject` for ViewModels
- Implement proper cleanup in services
- Cache frequently used data
- Lazy loading for heavy resources

### **Network Optimization**
- Cache currency exchange rates locally
- Implement retry logic with exponential backoff
- Use background refresh for currency updates
- Graceful offline handling

### **UI Performance**
- Debounce input changes for real-time conversion
- Use efficient SwiftUI patterns
- Minimize view redraws
- Optimize image assets

---

## 🔐 Security & Privacy

### **API Key Management**
- Store API keys in separate configuration file
- Use environment-specific configurations
- Never commit API keys to version control

### **Data Privacy**
- No personal data collection
- Local storage only for user preferences
- Clear privacy policy for App Store

### **Input Validation**
- Sanitize all user inputs
- Validate numeric inputs
- Handle edge cases gracefully

---

## 📱 Platform Considerations

### **iOS Version Support**
- **Minimum**: iOS 15.0
- **Target**: iOS 17.0
- **Features**: Use latest SwiftUI features where appropriate

### **Device Support**
- **iPhone**: All sizes (SE to Pro Max)
- **iPad**: Adaptive layout for larger screens
- **Accessibility**: Full VoiceOver and Dynamic Type support

### **Orientation**
- **Primary**: Portrait orientation
- **Adaptive**: Landscape support for iPad

---

**Last Updated**: August 2025  
**Version**: 1.0  
**Status**: Architecture Design Complete ✅
