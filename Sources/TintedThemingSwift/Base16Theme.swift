import Foundation

/// A Base16 color theme containing 16 colors following the Base16 specification
public struct Base16Theme: Codable, Identifiable, Hashable {
    public let id = UUID()
    public let name: String
    public let author: String
    public let variant: String // "light" or "dark"
    
    // Base16 color palette
    public let base00: String // Default Background
    public let base01: String // Lighter Background (Used for status bars, line number and folding marks)
    public let base02: String // Selection Background
    public let base03: String // Comments, Invisibles, Line Highlighting
    public let base04: String // Dark Foreground (Used for status bars)
    public let base05: String // Default Foreground, Caret, Delimiters, Operators
    public let base06: String // Light Foreground (Not often used)
    public let base07: String // Light Background (Not often used)
    public let base08: String // Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
    public let base09: String // Integers, Boolean, Constants, XML Attributes, Markup Link Url
    public let base0A: String // Classes, Markup Bold, Search Text Background
    public let base0B: String // Strings, Inherited Class, Markup Code, Diff Inserted
    public let base0C: String // Support, Regular Expressions, Escape Characters, Markup Quotes
    public let base0D: String // Functions, Methods, Attribute IDs, Headings
    public let base0E: String // Keywords, Storage, Selector, Markup Italic, Diff Changed
    public let base0F: String // Deprecated, Opening/Closing Embedded Language Tags
    
    public init(
        name: String,
        author: String,
        variant: String = "dark",
        base00: String, base01: String, base02: String, base03: String,
        base04: String, base05: String, base06: String, base07: String,
        base08: String, base09: String, base0A: String, base0B: String,
        base0C: String, base0D: String, base0E: String, base0F: String
    ) {
        self.name = name
        self.author = author
        self.variant = variant
        self.base00 = base00
        self.base01 = base01
        self.base02 = base02
        self.base03 = base03
        self.base04 = base04
        self.base05 = base05
        self.base06 = base06
        self.base07 = base07
        self.base08 = base08
        self.base09 = base09
        self.base0A = base0A
        self.base0B = base0B
        self.base0C = base0C
        self.base0D = base0D
        self.base0E = base0E
        self.base0F = base0F
    }
    
    /// Returns all 16 colors as an array in order
    public var allColors: [String] {
        return [
            base00, base01, base02, base03,
            base04, base05, base06, base07,
            base08, base09, base0A, base0B,
            base0C, base0D, base0E, base0F
        ]
    }
    
    /// Returns a color by its base16 index (0-15)
    public func color(at index: Int) -> String? {
        guard index >= 0 && index < 16 else { return nil }
        return allColors[index]
    }
    
    /// Returns the semantic color names mapped to their hex values
    public var semanticColors: [String: String] {
        return [
            "background": base00,
            "backgroundAlt": base01,
            "selection": base02,
            "comment": base03,
            "foregroundAlt": base04,
            "foreground": base05,
            "foregroundLight": base06,
            "backgroundLight": base07,
            "red": base08,
            "orange": base09,
            "yellow": base0A,
            "green": base0B,
            "cyan": base0C,
            "blue": base0D,
            "purple": base0E,
            "brown": base0F
        ]
    }
    
    public static func == (lhs: Base16Theme, rhs: Base16Theme) -> Bool {
        return lhs.name == rhs.name && lhs.author == rhs.author
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(author)
    }
}

// MARK: - Default Themes
public extension Base16Theme {
    /// A default dark theme
    static let defaultDark = Base16Theme(
        name: "Default Dark",
        author: "TintedThemes",
        variant: "dark",
        base00: "181818", base01: "282828", base02: "383838", base03: "585858",
        base04: "b8b8b8", base05: "d8d8d8", base06: "e8e8e8", base07: "f8f8f8",
        base08: "ab4642", base09: "dc9656", base0A: "f7ca88", base0B: "a1b56c",
        base0C: "86c1b9", base0D: "7cafc2", base0E: "ba8baf", base0F: "a16946"
    )
    
    /// A default light theme
    static let defaultLight = Base16Theme(
        name: "Default Light",
        author: "TintedThemes",
        variant: "light",
        base00: "f8f8f8", base01: "e8e8e8", base02: "d8d8d8", base03: "b8b8b8",
        base04: "585858", base05: "383838", base06: "282828", base07: "181818",
        base08: "ab4642", base09: "dc9656", base0A: "f7ca88", base0B: "a1b56c",
        base0C: "86c1b9", base0D: "7cafc2", base0E: "ba8baf", base0F: "a16946"
    )
    
    /// Returns true if this is a light theme
    public var isLight: Bool {
        return variant == "light"
    }
    
    /// Returns true if this is a dark theme
    public var isDark: Bool {
        return variant == "dark"
    }
}