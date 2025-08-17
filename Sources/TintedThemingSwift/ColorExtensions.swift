import Foundation

#if canImport(SwiftUI)
import SwiftUI

@available(iOS 14.0, macOS 11.0, watchOS 7.0, tvOS 14.0, *)
public extension Color {
    /// Creates a Color from a hex string (with or without # prefix)
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

@available(iOS 14.0, macOS 11.0, watchOS 7.0, tvOS 14.0, *)
public extension Base16Theme {
    /// SwiftUI Color for base00 (Default Background)
    var swiftUIBase00Color: Color { Color(hex: base00) }
    /// SwiftUI Color for base01 (Lighter Background)
    var swiftUIBase01Color: Color { Color(hex: base01) }
    /// SwiftUI Color for base02 (Selection Background)
    var swiftUIBase02Color: Color { Color(hex: base02) }
    /// SwiftUI Color for base03 (Comments, Invisibles)
    var swiftUIBase03Color: Color { Color(hex: base03) }
    /// SwiftUI Color for base04 (Dark Foreground)
    var swiftUIBase04Color: Color { Color(hex: base04) }
    /// SwiftUI Color for base05 (Default Foreground)
    var swiftUIBase05Color: Color { Color(hex: base05) }
    /// SwiftUI Color for base06 (Light Foreground)
    var swiftUIBase06Color: Color { Color(hex: base06) }
    /// SwiftUI Color for base07 (Light Background)
    var swiftUIBase07Color: Color { Color(hex: base07) }
    /// SwiftUI Color for base08 (Variables, Red)
    var swiftUIBase08Color: Color { Color(hex: base08) }
    /// SwiftUI Color for base09 (Integers, Orange)
    var swiftUIBase09Color: Color { Color(hex: base09) }
    /// SwiftUI Color for base0A (Classes, Yellow)
    var swiftUIBase0AColor: Color { Color(hex: base0A) }
    /// SwiftUI Color for base0B (Strings, Green)
    var swiftUIBase0BColor: Color { Color(hex: base0B) }
    /// SwiftUI Color for base0C (Support, Cyan)
    var swiftUIBase0CColor: Color { Color(hex: base0C) }
    /// SwiftUI Color for base0D (Functions, Blue)
    var swiftUIBase0DColor: Color { Color(hex: base0D) }
    /// SwiftUI Color for base0E (Keywords, Purple)
    var swiftUIBase0EColor: Color { Color(hex: base0E) }
    /// SwiftUI Color for base0F (Deprecated, Brown)
    var swiftUIBase0FColor: Color { Color(hex: base0F) }
    
    // Semantic color aliases
    var swiftUIBackgroundColor: Color { swiftUIBase00Color }
    var swiftUIForegroundColor: Color { swiftUIBase05Color }
    var swiftUISelectionColor: Color { swiftUIBase02Color }
    var swiftUICommentColor: Color { swiftUIBase03Color }
    var swiftUIErrorColor: Color { swiftUIBase08Color }
    var swiftUIWarningColor: Color { swiftUIBase09Color }
    var swiftUISuccessColor: Color { swiftUIBase0BColor }
    var swiftUILinkColor: Color { swiftUIBase0DColor }
}

@available(iOS 14.0, macOS 11.0, watchOS 7.0, tvOS 14.0, *)
public extension Base24Theme {
    /// SwiftUI Color for base00 (Default Background)
    var swiftUIBase00Color: Color { Color(hex: base00) }
    /// SwiftUI Color for base01 (Lighter Background)
    var swiftUIBase01Color: Color { Color(hex: base01) }
    /// SwiftUI Color for base02 (Selection Background)
    var swiftUIBase02Color: Color { Color(hex: base02) }
    /// SwiftUI Color for base03 (Comments, Invisibles)
    var swiftUIBase03Color: Color { Color(hex: base03) }
    /// SwiftUI Color for base04 (Dark Foreground)
    var swiftUIBase04Color: Color { Color(hex: base04) }
    /// SwiftUI Color for base05 (Default Foreground)
    var swiftUIBase05Color: Color { Color(hex: base05) }
    /// SwiftUI Color for base06 (Light Foreground)
    var swiftUIBase06Color: Color { Color(hex: base06) }
    /// SwiftUI Color for base07 (Light Background)
    var swiftUIBase07Color: Color { Color(hex: base07) }
    /// SwiftUI Color for base08 (Variables, Red)
    var swiftUIBase08Color: Color { Color(hex: base08) }
    /// SwiftUI Color for base09 (Integers, Orange)
    var swiftUIBase09Color: Color { Color(hex: base09) }
    /// SwiftUI Color for base0A (Classes, Yellow)
    var swiftUIBase0AColor: Color { Color(hex: base0A) }
    /// SwiftUI Color for base0B (Strings, Green)
    var swiftUIBase0BColor: Color { Color(hex: base0B) }
    /// SwiftUI Color for base0C (Support, Cyan)
    var swiftUIBase0CColor: Color { Color(hex: base0C) }
    /// SwiftUI Color for base0D (Functions, Blue)
    var swiftUIBase0DColor: Color { Color(hex: base0D) }
    /// SwiftUI Color for base0E (Keywords, Purple)
    var swiftUIBase0EColor: Color { Color(hex: base0E) }
    /// SwiftUI Color for base0F (Deprecated, Brown)
    var swiftUIBase0FColor: Color { Color(hex: base0F) }
    /// SwiftUI Color for base10
    var swiftUIBase10Color: Color { Color(hex: base10) }
    /// SwiftUI Color for base11
    var swiftUIBase11Color: Color { Color(hex: base11) }
    /// SwiftUI Color for base12
    var swiftUIBase12Color: Color { Color(hex: base12) }
    /// SwiftUI Color for base13
    var swiftUIBase13Color: Color { Color(hex: base13) }
    /// SwiftUI Color for base14
    var swiftUIBase14Color: Color { Color(hex: base14) }
    /// SwiftUI Color for base15
    var swiftUIBase15Color: Color { Color(hex: base15) }
    /// SwiftUI Color for base16
    var swiftUIBase16Color: Color { Color(hex: base16) }
    /// SwiftUI Color for base17
    var swiftUIBase17Color: Color { Color(hex: base17) }
    
    // Semantic color aliases
    var swiftUIBackgroundColor: Color { swiftUIBase00Color }
    var swiftUIForegroundColor: Color { swiftUIBase05Color }
    var swiftUISelectionColor: Color { swiftUIBase02Color }
    var swiftUICommentColor: Color { swiftUIBase03Color }
    var swiftUIErrorColor: Color { swiftUIBase08Color }
    var swiftUIWarningColor: Color { swiftUIBase09Color }
    var swiftUISuccessColor: Color { swiftUIBase0BColor }
    var swiftUILinkColor: Color { swiftUIBase0DColor }
}
#endif

#if canImport(UIKit)
import UIKit

@available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension UIColor {
    /// Creates a UIColor from a hex string (with or without # prefix)
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255,
            alpha: CGFloat(a) / 255
        )
    }
}

@available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension Base16Theme {
    /// UIColor for base00 (Default Background)
    var uiBase00Color: UIColor { UIColor(hex: base00) }
    /// UIColor for base01 (Lighter Background)
    var uiBase01Color: UIColor { UIColor(hex: base01) }
    /// UIColor for base02 (Selection Background)
    var uiBase02Color: UIColor { UIColor(hex: base02) }
    /// UIColor for base03 (Comments, Invisibles)
    var uiBase03Color: UIColor { UIColor(hex: base03) }
    /// UIColor for base04 (Dark Foreground)
    var uiBase04Color: UIColor { UIColor(hex: base04) }
    /// UIColor for base05 (Default Foreground)
    var uiBase05Color: UIColor { UIColor(hex: base05) }
    /// UIColor for base06 (Light Foreground)
    var uiBase06Color: UIColor { UIColor(hex: base06) }
    /// UIColor for base07 (Light Background)
    var uiBase07Color: UIColor { UIColor(hex: base07) }
    /// UIColor for base08 (Variables, Red)
    var uiBase08Color: UIColor { UIColor(hex: base08) }
    /// UIColor for base09 (Integers, Orange)
    var uiBase09Color: UIColor { UIColor(hex: base09) }
    /// UIColor for base0A (Classes, Yellow)
    var uiBase0AColor: UIColor { UIColor(hex: base0A) }
    /// UIColor for base0B (Strings, Green)
    var uiBase0BColor: UIColor { UIColor(hex: base0B) }
    /// UIColor for base0C (Support, Cyan)
    var uiBase0CColor: UIColor { UIColor(hex: base0C) }
    /// UIColor for base0D (Functions, Blue)
    var uiBase0DColor: UIColor { UIColor(hex: base0D) }
    /// UIColor for base0E (Keywords, Purple)
    var uiBase0EColor: UIColor { UIColor(hex: base0E) }
    /// UIColor for base0F (Deprecated, Brown)
    var uiBase0FColor: UIColor { UIColor(hex: base0F) }
    
    // Semantic color aliases
    var uiBackgroundColor: UIColor { uiBase00Color }
    var uiForegroundColor: UIColor { uiBase05Color }
    var uiSelectionColor: UIColor { uiBase02Color }
    var uiCommentColor: UIColor { uiBase03Color }
    var uiErrorColor: UIColor { uiBase08Color }
    var uiWarningColor: UIColor { uiBase09Color }
    var uiSuccessColor: UIColor { uiBase0BColor }
    var uiLinkColor: UIColor { uiBase0DColor }
}
#endif

#if canImport(AppKit)
import AppKit

@available(macOS 10.15, *)
public extension NSColor {
    /// Creates an NSColor from a hex string (with or without # prefix)
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255,
            alpha: CGFloat(a) / 255
        )
    }
}

@available(macOS 10.15, *)
public extension Base16Theme {
    /// NSColor for base00 (Default Background)
    var nsBase00Color: NSColor { NSColor(hex: base00) }
    /// NSColor for base01 (Lighter Background)
    var nsBase01Color: NSColor { NSColor(hex: base01) }
    /// NSColor for base02 (Selection Background)
    var nsBase02Color: NSColor { NSColor(hex: base02) }
    /// NSColor for base03 (Comments, Invisibles)
    var nsBase03Color: NSColor { NSColor(hex: base03) }
    /// NSColor for base04 (Dark Foreground)
    var nsBase04Color: NSColor { NSColor(hex: base04) }
    /// NSColor for base05 (Default Foreground)
    var nsBase05Color: NSColor { NSColor(hex: base05) }
    /// NSColor for base06 (Light Foreground)
    var nsBase06Color: NSColor { NSColor(hex: base06) }
    /// NSColor for base07 (Light Background)
    var nsBase07Color: NSColor { NSColor(hex: base07) }
    /// NSColor for base08 (Variables, Red)
    var nsBase08Color: NSColor { NSColor(hex: base08) }
    /// NSColor for base09 (Integers, Orange)
    var nsBase09Color: NSColor { NSColor(hex: base09) }
    /// NSColor for base0A (Classes, Yellow)
    var nsBase0AColor: NSColor { NSColor(hex: base0A) }
    /// NSColor for base0B (Strings, Green)
    var nsBase0BColor: NSColor { NSColor(hex: base0B) }
    /// NSColor for base0C (Support, Cyan)
    var nsBase0CColor: NSColor { NSColor(hex: base0C) }
    /// NSColor for base0D (Functions, Blue)
    var nsBase0DColor: NSColor { NSColor(hex: base0D) }
    /// NSColor for base0E (Keywords, Purple)
    var nsBase0EColor: NSColor { NSColor(hex: base0E) }
    /// NSColor for base0F (Deprecated, Brown)
    var nsBase0FColor: NSColor { NSColor(hex: base0F) }
    
    // Semantic color aliases
    var nsBackgroundColor: NSColor { nsBase00Color }
    var nsForegroundColor: NSColor { nsBase05Color }
    var nsSelectionColor: NSColor { nsBase02Color }
    var nsCommentColor: NSColor { nsBase03Color }
    var nsErrorColor: NSColor { nsBase08Color }
    var nsWarningColor: NSColor { nsBase09Color }
    var nsSuccessColor: NSColor { nsBase0BColor }
    var nsLinkColor: NSColor { nsBase0DColor }
}
#endif