import Foundation

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif

/// Resolves Base16 slots to stock Apple platform colors for Default Light / Default Dark.
enum PlatformChrome {
    /// Pick Default Light or Default Dark to match the current system appearance.
    public static func defaultMatchingSystemAppearance() -> Base16Theme {
        #if canImport(AppKit) && !targetEnvironment(macCatalyst)
        if #available(macOS 10.14, *) {
            let match = NSApp.effectiveAppearance.bestMatch(from: [.darkAqua, .aqua])
            return match == .darkAqua ? .defaultDark : .defaultLight
        }
        return .defaultLight
        #elseif canImport(UIKit)
        switch UITraitCollection.current.userInterfaceStyle {
        case .dark: return .defaultDark
        default: return .defaultLight
        }
        #else
        return .defaultDark
        #endif
    }

    #if canImport(AppKit) && !targetEnvironment(macCatalyst)
    /// Evaluate an NSColor under the appearance that matches the theme variant.
    static func nsColor(for theme: Base16Theme, index: Int) -> NSColor {
        guard theme.usesApplePlatformChrome else {
            return NSColor(hex: theme.color(at: index) ?? "000000")
        }
        let appearance = NSAppearance(named: theme.isLight ? .aqua : .darkAqua)
            ?? NSAppearance(named: .aqua)
        var resolved: NSColor = .labelColor
        appearance?.performAsCurrentDrawingAppearance {
            resolved = nsSystemColor(index: index, light: theme.isLight)
        }
        return resolved
    }

    private static func nsSystemColor(index: Int, light: Bool) -> NSColor {
        switch index {
        case 0: return .windowBackgroundColor
        case 1: return .controlBackgroundColor
        case 2:
            if #available(macOS 10.14, *) {
                return .selectedContentBackgroundColor
            }
            return .selectedTextBackgroundColor
        case 3: return .secondaryLabelColor
        case 4: return .secondaryLabelColor
        case 5: return .labelColor
        case 6: return .labelColor
        case 7: return light ? .black : .white
        case 8: return .systemRed
        case 9: return .systemOrange
        case 10: return .systemYellow
        case 11: return .systemGreen
        case 12:
            if #available(macOS 10.15, *) { return .systemTeal }
            return .systemBlue
        case 13: return .controlAccentColor
        case 14: return .systemPurple
        case 15: return .systemBrown
        default: return .labelColor
        }
    }
    #endif

    #if canImport(UIKit)
    static func uiColor(for theme: Base16Theme, index: Int) -> UIColor {
        guard theme.usesApplePlatformChrome else {
            return UIColor(hex: theme.color(at: index) ?? "000000")
        }
        return uiSystemColor(index: index, light: theme.isLight)
    }

    private static func uiSystemColor(index: Int, light: Bool) -> UIColor {
        switch index {
        case 0: return .systemBackground
        case 1: return .secondarySystemBackground
        case 2: return .tertiarySystemBackground
        case 3: return .secondaryLabel
        case 4: return .secondaryLabel
        case 5: return .label
        case 6: return .label
        case 7: return light ? .black : .white
        case 8: return .systemRed
        case 9: return .systemOrange
        case 10: return .systemYellow
        case 11: return .systemGreen
        case 12: return .systemTeal
        case 13: return .systemBlue // closest to control accent on iOS; apps may still use tint
        case 14: return .systemPurple
        case 15: return .systemBrown
        default: return .label
        }
    }
    #endif
}

public extension Base16Theme {
    /// Default Light / Dark matching the current system appearance.
    static func defaultMatchingSystemAppearance() -> Base16Theme {
        PlatformChrome.defaultMatchingSystemAppearance()
    }
}
