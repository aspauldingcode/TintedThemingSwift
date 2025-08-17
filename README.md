# TintedThemingSwift

A Swift package for working with Base16 and Base24 color themes, providing easy access to a wide variety of color schemes for your iOS, macOS, watchOS, and tvOS applications.

This package is a Swift API implementation for the [TintedTheming/Schemes](https://github.com/tinted-theming/schemes) project, which provides a comprehensive collection of Base16 and Base24 color schemes.

## 📖 Documentation

For complete documentation, API reference, usage examples, and guides, please visit the **[Wiki](../../wiki)**.

## ✨ Features

- 🎨 Base16 & Base24 theme support
- 🔄 Network & local cache theme loading  
- 🎯 Semantic color mappings
- 📱 Multi-platform (iOS 15+, macOS 12+, watchOS 8+, tvOS 15+)
- ⚡ SwiftUI, UIKit, and AppKit integration

## Installation

### Swift Package Manager

Add TintedThemingSwift to your project using Xcode:

1. In Xcode, go to **File → Add Package Dependencies**
2. Enter the package URL: `https://github.com/aspauldingcode/TintedThemingSwift`
3. Select the version and add to your target

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/aspauldingcode/TintedThemingSwift", from: "1.0.0")
]
```

## 🚀 Quick Start

```swift
import TintedThemingSwift

// Use a default theme
let theme = Base16Theme.defaultDark

// Load themes from network
let loader = TintedThemesLoader()
let themes = try await loader.loadThemes()

// SwiftUI integration
Text("Hello, World!")
    .foregroundColor(Color(hex: theme.base05))
    .background(Color(hex: theme.base00))
```

For detailed usage examples, API documentation, and integration guides, see the **[Wiki](../../wiki)**.

## Requirements

- iOS 15.0+ / macOS 12.0+ / watchOS 8.0+ / tvOS 15.0+
- Swift 5.9+ / Xcode 15.0+

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License - see [LICENSE](LICENSE) for details.

---

**📚 For complete documentation, visit the [Wiki](../../wiki)**

**Author:** [Alex Spaulding](https://github.com/aspauldingcode) | **Schemes:** [TintedTheming/Schemes](https://github.com/tinted-theming/schemes)