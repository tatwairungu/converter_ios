# 🇰🇪 Kenya Converter

> A beautiful, modern unit converter app celebrating Kenyan heritage with world-class UX

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
  ![Image 16-08-2025 at 21 02 (1)](https://github.com/user-attachments/assets/9969eec3-a1e4-4cd9-bda8-479435cae1db)
![Image 16-08-2025 at 20 30](https://github.com/user-attachments/assets/2c664050-94f7-4086-8b8f-dfcc0598e84a)
![Image 16-08-2025 at 20 57](https://github.com/user-attachments/assets/9d17d866-4c0a-4387-ac2b-7ca233e366ca)
![Image 16-08-2025 at 21 01-2](https://github.com/user-attachments/assets/d0592b4f-98c8-4ff6-a8b6-67826cbabdcf)
![Image 16-08-2025 at 21 00](https://github.com/user-attachments/assets/6f356319-4e23-4740-981e-4e56dced967d)
![Image 16-08-2025 at 21 01](https://github.com/user-attachments/assets/3f3cc4ab-0045-42f6-aa54-8d4b8fee0d79)
![Image 16-08-2025 at 21 02](https://github.com/user-attachments/assets/48112f10-e93b-4981-8146-f111abe7634a)
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
