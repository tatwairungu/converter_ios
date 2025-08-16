# 🇰🇪 Kenya Converter

> A beautiful, modern unit converter app celebrating Kenyan heritage with world-class UX

[![iOS](https://img.shields.io/badge/iOS-15.0+-007AFF?style=flat&logo=apple&logoColor=white)](https://developer.apple.com/ios/)
[![Swift](https://img.shields.io/badge/Swift-5.9-FA7343?style=flat&logo=swift&logoColor=white)](https://swift.org/)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-4.0+-0066CC?style=flat&logo=apple&logoColor=white)](https://developer.apple.com/swiftui/)
[![Xcode](https://img.shields.io/badge/Xcode-15.0+-147EFB?style=flat&logo=xcode&logoColor=white)](https://developer.apple.com/xcode/)

## ✨ Features

### 🔄 **4 Essential Converters**
- **⚖️ Weight**: kg, g, lb, oz, stone, ton
- **📏 Length**: m, cm, km, in, ft, mi  
- **🌡️ Temperature**: °C, °F, K (with validation)
- **💰 Currency**: Live KES exchange rates (7 currencies)

### 🎨 **Modern Design**
- **Above-the-fold layout** - no scrolling needed
- **Side-by-side unit pickers** for intuitive swapping
- **Real-time conversion** as you type
- **Subtle Kenyan flag branding** without overwhelming minimalism
- **Full dark mode support** with adaptive colors

### ⚡ **Enhanced UX**
- **Quick preset values** (1, 5, 10, 25, 50, 100) for faster testing
- **Haptic feedback** on all interactions
- **Animated swap button** with 180° rotation
- **Live unit chips** that update with swaps
- **Copy to clipboard** with dual haptic confirmation
- **Tappable reference formulas** for quick copying

### 💱 **Smart Currency Features**
- **Live API integration** with 4-hour caching
- **Offline fallback** with cached rates
- **Loading skeletons** and status indicators
- **Stale data alerts** with pulsing animations
- **Manual refresh** with one-tap update

### ♿ **Accessibility First**
- **WCAG AA compliance** (4.5:1 contrast ratios)
- **VoiceOver support** with semantic labels
- **44pt+ touch targets** for comfortable interaction
- **Dynamic Type ready** for vision accessibility
- **Keyboard management** keeping results visible

## 📱 Screenshots

<p align="center">
  <img src="screenshots/weight-converter.png" width="200" alt="Weight Converter">
  <img src="screenshots/currency-converter.png" width="200" alt="Currency Converter">
  <img src="screenshots/temperature-converter.png" width="200" alt="Temperature Converter">
  <img src="screenshots/dark-mode.png" width="200" alt="Dark Mode">
</p>

## 🏗️ Architecture

### **MVVM + Service Layer**
```
📁 cursor_test/
├── 🎨 Shared/
│   ├── Components/     # Reusable UI components
│   └── Theme/         # Kenyan color system & tokens
├── 🏗️ Core/
│   ├── Models/        # ConversionUnit & ConverterType
│   └── Services/      # NetworkService & ExchangeRateService
└── 🚀 Features/
    ├── Weight/        # Weight converter + ViewModel
    ├── Length/        # Length converter + ViewModel  
    ├── Temperature/   # Temperature converter + ViewModel
    └── Currency/      # Live currency converter + ViewModel
```

### **Key Components**
- **ConversionInput**: Smart input with validation & unit chips
- **UnitSelector**: Side-by-side pickers with animated swap
- **ConversionResult**: Large, copyable results with haptic feedback
- **PresetChips**: Quick value selection for faster testing
- **KenyanFlagHeader**: Subtle flag branding behind icons

### **Services**
- **NetworkService**: HTTP client with connectivity monitoring
- **ExchangeRateService**: Live API + smart caching + offline fallback

## 🎨 Design System

### **🇰🇪 Kenyan Colors**
```swift
🟢 Primary Green: #0B6E4F    // Focus, selection, active states
🔴 Secondary Red: #C1121F     // Warnings, errors only  
⚫ Text Black: #111827       // Primary text (adaptive)
⚪ Background: System        // Adaptive light/dark
```

### **📐 Spacing Grid**
- **8pt base grid** with semantic naming
- **Above-the-fold heights**: Header 64pt, Input 56pt, Result 112pt
- **44pt+ touch targets** for accessibility compliance

### **🎭 Animations**
- **Fast feedback**: 150ms for micro-interactions
- **Standard**: 200ms for transitions  
- **Swap rotation**: 180ms for button feedback
- **Keyboard**: 250ms for content shifting

## 🚀 Getting Started

### **Prerequisites**
- iOS 15.0+ / Xcode 15.0+
- Swift 5.9+
- Active internet for live currency rates

### **Installation**
```bash
git clone https://github.com/tatwairungu/converter-ios.git
cd kenya-converter
open cursor_test.xcodeproj
```

### **API Setup**
The app uses [ExchangeRate-API](https://exchangerate-api.com/) for live currency data:
- **Free tier**: 1500 requests/month
- **Auto-fallback**: Cached rates when offline
- **Smart caching**: 4-hour refresh cycle

## 🏆 Development Highlights

### **Phase 1: Foundation** ✅
- Established MVVM architecture
- Created reusable component system
- Implemented Kenyan flag theming

### **Phase 2: Core Converters** ✅  
- Built 4 essential converters with real-time conversion
- Integrated live currency API with smart caching
- Added comprehensive error handling

### **Phase 3: Design Refactor** ✅
- Redesigned for above-the-fold experience
- Enhanced with micro-interactions & haptic feedback
- Added accessibility compliance & dark mode

### **Phase 4: UI Polish** ✅
- Refined visual hierarchy and branding
- Added preset chips and interactive elements
- Implemented world-class UX patterns

## 🎯 Performance

- **⚡ Launch time**: <2 seconds
- **🔄 Real-time conversion**: <100ms response
- **💱 Currency refresh**: <5 seconds
- **📱 Memory efficient**: Lazy loading & smart caching
- **🌐 Offline capable**: Graceful degradation

## 🧪 Testing

```bash
# Run unit tests
cmd + U

# Test accessibility
Settings > Accessibility > VoiceOver (On)
Settings > Display & Text Size > Larger Text (Max)

# Test dark mode  
Settings > Display & Brightness > Dark
```

## 🤝 Contributing

1. **Fork** the repository
2. **Create** your feature branch (`git checkout -b feature/AmazingFeature`)
3. **Follow** the established patterns (MVVM + Component architecture)
4. **Test** accessibility & dark mode compatibility
5. **Commit** your changes (`git commit -m 'Add AmazingFeature'`)
6. **Push** to the branch (`git push origin feature/AmazingFeature`)
7. **Open** a Pull Request

### **Code Style**
- SwiftUI declarative patterns
- MVVM architecture
- Component-based design
- Kenyan theme system integration

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🇰🇪 About

Built with pride in Kenya, celebrating our heritage through thoughtful design and world-class user experience. The subtle flag branding and green color scheme honor our national identity while maintaining modern, international appeal.

### **Creator**
- **[Tatwa Irungu]** - [@madebytatwa](https://github.com/tatwairungu)

### **Acknowledgments**
- 🎨 Design inspired by Kenya's flag and natural beauty
- 💱 Currency data provided by ExchangeRate-API
- 🏗️ Built with SwiftUI and modern iOS patterns
- ♿ Accessibility guidelines from WCAG AA standards

---

<p align="center">
  <strong>Made with 💚 for Kenya and the world</strong><br>
  <em>Beautiful conversions, Kenyan heritage, world-class UX</em>
</p>

---

## 📊 Project Stats

![GitHub repo size](https://img.shields.io/github/repo-size/yourusername/kenya-converter)
![GitHub code size](https://img.shields.io/github/languages/code-size/yourusername/kenya-converter)
![GitHub top language](https://img.shields.io/github/languages/top/yourusername/kenya-converter)
![GitHub last commit](https://img.shields.io/github/last-commit/yourusername/kenya-converter)

**Ready for App Store! 🚀**
