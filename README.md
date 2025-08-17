# TintedThemingSwift

A Swift package for working with Base16 and Base24 color themes, providing easy access to a wide variety of color schemes for your iOS, macOS, watchOS, and tvOS applications.

This package is a Swift API implementation for the [TintedTheming/Schemes](https://github.com/tinted-theming/schemes) project, which provides a comprehensive collection of Base16 and Base24 color schemes.

## ✨ Features

- 🎨 **Base16 Theme Support**: Complete implementation of the Base16 color specification
- 🌈 **Base24 Theme Support**: Extended Base24 themes with additional colors
- 🔄 **Theme Loading**: Load themes from network or local cache
- 🎯 **Semantic Colors**: Easy access to semantic color mappings (background, foreground, etc.)
- 📱 **Multi-Platform**: Supports iOS 15+, macOS 12+, watchOS 8+, and tvOS 15+
- ⚡ **SwiftUI Ready**: Color extensions for seamless SwiftUI integration

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

### Basic Theme Usage

```swift
import TintedThemingSwift

// Use default themes
let darkTheme = Base16Theme.defaultDark
let lightTheme = Base16Theme.defaultLight

// Access colors
let backgroundColor = darkTheme.base00
let foregroundColor = darkTheme.base05

// Use semantic colors
let redColor = darkTheme.semanticColors["red"] // base08
let blueColor = darkTheme.semanticColors["blue"] // base0D
```

### SwiftUI Integration

```swift
import SwiftUI
import TintedThemingSwift

struct ContentView: View {
    let theme = Base16Theme.defaultDark
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .foregroundColor(Color(hex: theme.base05))
            
            Rectangle()
                .fill(Color(hex: theme.base08))
                .frame(width: 100, height: 100)
        }
        .background(Color(hex: theme.base00))
    }
}
```

### Loading Themes from Network

```swift
import TintedThemingSwift

let loader = TintedThemesLoader()

Task {
    do {
        let themes = try await loader.loadThemes()
        print("Loaded \(themes.count) themes")
        
        // Find a specific theme
        if let monokai = themes.first(where: { $0.name == "Monokai" }) {
            // Use the theme
        }
    } catch {
        print("Failed to load themes: \(error)")
    }
}
```

## API Overview

### Base16Theme

The core theme structure with 16 standardized colors:

```swift
let theme = Base16Theme.defaultDark

// Check theme variant
if theme.isDark {
    print("This is a dark theme")
}

// Access all colors as an array
let allColors = theme.allColors // [base00, base01, ..., base0F]

// Get color by index
if let color = theme.color(at: 8) {
    print("Color at index 8: \(color)") // base08
}
```

### Base24Theme

Extended themes with 24 colors (Base16 + 8 additional):

```swift
let base24Theme = Base24Theme(...)
let base16Version = base24Theme.asBase16Theme // Convert to Base16
```

### TintedThemesLoader

Load themes from the official repository:

```swift
let loader = TintedThemesLoader()

// Load all themes
let allThemes = try await loader.loadThemes()

// Load specific themes
let specificThemes = try await loader.loadThemes(named: ["Monokai", "Solarized Dark"])

// Load only dark themes
let darkThemes = try await loader.loadDarkThemes()

// Force refresh from network
try await loader.refreshThemes()
```

## Base16 Color Specification

Base16 themes follow a standardized 16-color palette:

- **base00-03**: Background colors (darkest to lightest)
- **base04-07**: Foreground colors (darkest to lightest)
- **base08**: Red
- **base09**: Orange
- **base0A**: Yellow
- **base0B**: Green
- **base0C**: Cyan
- **base0D**: Blue
- **base0E**: Purple
- **base0F**: Brown

## Requirements

- iOS 15.0+ / macOS 12.0+ / watchOS 8.0+ / tvOS 15.0+
- Swift 5.9+ / Xcode 15.0+

## Dependencies

- [Yams](https://github.com/jpsim/Yams) - YAML parsing for theme files

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License - see [LICENSE](LICENSE) for details.

## Acknowledgments

- [TintedTheming/Schemes](https://github.com/tinted-theming/schemes) - The primary source of all color schemes
- [Base16](https://github.com/chriskempson/base16) - The original Base16 color scheme specification

---

**📚 For additional documentation and examples, visit the [Wiki](../../wiki)**

**🔧 For GitHub Actions workflow documentation, see [WORKFLOWS.md](WORKFLOWS.md)**

**Author:** [Alex Spaulding](https://github.com/aspauldingcode)