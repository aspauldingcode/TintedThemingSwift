# TintedThemingSwift

A Swift package for working with Base16 and Base24 color themes, providing easy access to a wide variety of color schemes for your applications.

## Features

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
2. Enter the package URL: `https://github.com/yourusername/TintedThemingSwift`
3. Select the version and add to your target

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/TintedThemingSwift", from: "1.0.0")
]
```

## Usage

### Basic Theme Usage

```swift
import TintedThemingSwift

// Create a Base16 theme
let theme = Base16Theme(
    name: "My Theme",
    author: "Your Name",
    base00: "000000", base01: "111111", base02: "222222", base03: "333333",
    base04: "444444", base05: "555555", base06: "666666", base07: "777777",
    base08: "888888", base09: "999999", base0A: "aaaaaa", base0B: "bbbbbb",
    base0C: "cccccc", base0D: "dddddd", base0E: "eeeeee", base0F: "ffffff"
)

// Access colors
let backgroundColor = theme.base00
let foregroundColor = theme.base05

// Use semantic colors
let semanticColors = theme.semanticColors
let redColor = semanticColors["red"] // base08
let blueColor = semanticColors["blue"] // base0D
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

### Loading Themes

```swift
import TintedThemingSwift

// Load themes from network
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

### Theme Properties

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

## Base24 Extension

Base24 themes extend Base16 with 8 additional colors (base10-17) for enhanced theming capabilities.

## Requirements

- iOS 15.0+ / macOS 12.0+ / watchOS 8.0+ / tvOS 15.0+
- Swift 5.9+
- Xcode 15.0+

## Dependencies

- [Yams](https://github.com/jpsim/Yams) - YAML parsing for theme files

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- [Base16](https://github.com/chriskempson/base16) - The original Base16 color scheme specification
- [Tinted Theming](https://github.com/tinted-theming) - Community-driven theming projects