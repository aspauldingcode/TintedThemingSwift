import Foundation

/// A Base24 color theme containing 24 colors, extending Base16 with 8 additional colors
public struct Base24Theme: Codable, Identifiable, Hashable {
    public let id: UUID
    public let name: String
    public let author: String
    
    // Base16 colors (0x00-0x0F)
    public let base00: String
    public let base01: String
    public let base02: String
    public let base03: String
    public let base04: String
    public let base05: String
    public let base06: String
    public let base07: String
    public let base08: String
    public let base09: String
    public let base0A: String
    public let base0B: String
    public let base0C: String
    public let base0D: String
    public let base0E: String
    public let base0F: String
    
    // Extended Base24 colors (0x10-0x17)
    public let base10: String
    public let base11: String
    public let base12: String
    public let base13: String
    public let base14: String
    public let base15: String
    public let base16: String
    public let base17: String
    
    public init(
        name: String,
        author: String,
        base00: String, base01: String, base02: String, base03: String,
        base04: String, base05: String, base06: String, base07: String,
        base08: String, base09: String, base0A: String, base0B: String,
        base0C: String, base0D: String, base0E: String, base0F: String,
        base10: String, base11: String, base12: String, base13: String,
        base14: String, base15: String, base16: String, base17: String
    ) {
        self.id = UUID()
        self.name = name
        self.author = author
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
        self.base10 = base10
        self.base11 = base11
        self.base12 = base12
        self.base13 = base13
        self.base14 = base14
        self.base15 = base15
        self.base16 = base16
        self.base17 = base17
    }
    
    /// Returns all 24 colors as an array in order
    public var allColors: [String] {
        return [
            base00, base01, base02, base03,
            base04, base05, base06, base07,
            base08, base09, base0A, base0B,
            base0C, base0D, base0E, base0F,
            base10, base11, base12, base13,
            base14, base15, base16, base17
        ]
    }
    
    /// Returns a color by its base24 index (0-23)
    public func color(at index: Int) -> String? {
        guard index >= 0 && index < 24 else { return nil }
        return allColors[index]
    }
    
    /// Converts this Base24 theme to a Base16 theme (using only the first 16 colors)
    public var asBase16Theme: Base16Theme {
        return Base16Theme(
            name: name,
            author: author,
            base00: base00, base01: base01, base02: base02, base03: base03,
            base04: base04, base05: base05, base06: base06, base07: base07,
            base08: base08, base09: base09, base0A: base0A, base0B: base0B,
            base0C: base0C, base0D: base0D, base0E: base0E, base0F: base0F
        )
    }
    
    public static func == (lhs: Base24Theme, rhs: Base24Theme) -> Bool {
        return lhs.name == rhs.name && lhs.author == rhs.author
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(author)
    }
}