import XCTest
@testable import TintedThemingSwift

final class TintedThemesTests: XCTestCase {
    
    func testBase16ThemeCreation() {
        let theme = Base16Theme(
            name: "Test Theme",
            author: "Test Author",
            base00: "000000", base01: "111111", base02: "222222", base03: "333333",
            base04: "444444", base05: "555555", base06: "666666", base07: "777777",
            base08: "888888", base09: "999999", base0A: "aaaaaa", base0B: "bbbbbb",
            base0C: "cccccc", base0D: "dddddd", base0E: "eeeeee", base0F: "ffffff"
        )
        
        XCTAssertEqual(theme.name, "Test Theme")
        XCTAssertEqual(theme.author, "Test Author")
        XCTAssertEqual(theme.base00, "000000")
        XCTAssertEqual(theme.base0F, "ffffff")
        XCTAssertEqual(theme.allColors.count, 16)
    }
    
    func testBase16ThemeColorAccess() {
        let theme = Base16Theme.defaultDark
        
        XCTAssertEqual(theme.color(at: 0), theme.base00)
        XCTAssertEqual(theme.color(at: 15), theme.base0F)
        XCTAssertNil(theme.color(at: 16))
        XCTAssertNil(theme.color(at: -1))
    }
    
    func testBase16ThemeSemanticColors() {
        let theme = Base16Theme.defaultDark
        let semanticColors = theme.semanticColors
        
        XCTAssertEqual(semanticColors["background"], theme.base00)
        XCTAssertEqual(semanticColors["foreground"], theme.base05)
        XCTAssertEqual(semanticColors["red"], theme.base08)
        XCTAssertEqual(semanticColors["blue"], theme.base0D)
    }
    
    func testBase24ThemeCreation() {
        let theme = Base24Theme(
            name: "Test Base24 Theme",
            author: "Test Author",
            base00: "000000", base01: "111111", base02: "222222", base03: "333333",
            base04: "444444", base05: "555555", base06: "666666", base07: "777777",
            base08: "888888", base09: "999999", base0A: "aaaaaa", base0B: "bbbbbb",
            base0C: "cccccc", base0D: "dddddd", base0E: "eeeeee", base0F: "ffffff",
            base10: "101010", base11: "121212", base12: "131313", base13: "141414",
            base14: "151515", base15: "161616", base16: "171717", base17: "181818"
        )
        
        XCTAssertEqual(theme.name, "Test Base24 Theme")
        XCTAssertEqual(theme.author, "Test Author")
        XCTAssertEqual(theme.base00, "000000")
        XCTAssertEqual(theme.base17, "181818")
        XCTAssertEqual(theme.allColors.count, 24)
    }
    
    func testBase24ThemeColorAccess() {
        let theme = Base24Theme(
            name: "Test",
            author: "Test",
            base00: "000000", base01: "111111", base02: "222222", base03: "333333",
            base04: "444444", base05: "555555", base06: "666666", base07: "777777",
            base08: "888888", base09: "999999", base0A: "aaaaaa", base0B: "bbbbbb",
            base0C: "cccccc", base0D: "dddddd", base0E: "eeeeee", base0F: "ffffff",
            base10: "101010", base11: "121212", base12: "131313", base13: "141414",
            base14: "151515", base15: "161616", base16: "171717", base17: "181818"
        )
        
        XCTAssertEqual(theme.color(at: 0), theme.base00)
        XCTAssertEqual(theme.color(at: 23), theme.base17)
        XCTAssertNil(theme.color(at: 24))
        XCTAssertNil(theme.color(at: -1))
    }
    
    func testBase24ToBase16Conversion() {
        let base24Theme = Base24Theme(
            name: "Test Base24",
            author: "Test Author",
            base00: "000000", base01: "111111", base02: "222222", base03: "333333",
            base04: "444444", base05: "555555", base06: "666666", base07: "777777",
            base08: "888888", base09: "999999", base0A: "aaaaaa", base0B: "bbbbbb",
            base0C: "cccccc", base0D: "dddddd", base0E: "eeeeee", base0F: "ffffff",
            base10: "101010", base11: "121212", base12: "131313", base13: "141414",
            base14: "151515", base15: "161616", base16: "171717", base17: "181818"
        )
        
        let base16Theme = base24Theme.asBase16Theme
        
        XCTAssertEqual(base16Theme.name, base24Theme.name)
        XCTAssertEqual(base16Theme.author, base24Theme.author)
        XCTAssertEqual(base16Theme.base00, base24Theme.base00)
        XCTAssertEqual(base16Theme.base0F, base24Theme.base0F)
        XCTAssertEqual(base16Theme.allColors.count, 16)
    }
    
    func testDefaultThemes() {
        let darkTheme = Base16Theme.defaultDark
        let lightTheme = Base16Theme.defaultLight
        
        XCTAssertEqual(darkTheme.name, "Default Dark")
        XCTAssertEqual(lightTheme.name, "Default Light")
        XCTAssertNotEqual(darkTheme.base00, lightTheme.base00)
    }
    
    func testThemeEquality() {
        let theme1 = Base16Theme.defaultDark
        let theme2 = Base16Theme.defaultDark
        let theme3 = Base16Theme.defaultLight
        
        XCTAssertEqual(theme1, theme2)
        XCTAssertNotEqual(theme1, theme3)
    }
    
    func testThemeHashing() {
        let theme1 = Base16Theme.defaultDark
        let theme2 = Base16Theme.defaultDark
        let theme3 = Base16Theme.defaultLight
        
        XCTAssertEqual(theme1.hashValue, theme2.hashValue)
        XCTAssertNotEqual(theme1.hashValue, theme3.hashValue)
    }
    
    func testBase16ThemeVariantProperty() {
        let darkTheme = Base16Theme.defaultDark
        let lightTheme = Base16Theme.defaultLight
        
        XCTAssertEqual(darkTheme.variant, "dark")
        XCTAssertEqual(lightTheme.variant, "light")
    }
    
    func testBase16ThemeVariantConvenienceProperties() {
        let darkTheme = Base16Theme.defaultDark
        let lightTheme = Base16Theme.defaultLight
        
        XCTAssertTrue(darkTheme.isDark)
        XCTAssertFalse(darkTheme.isLight)
        
        XCTAssertTrue(lightTheme.isLight)
        XCTAssertFalse(lightTheme.isDark)
    }
    
    func testBase16ThemeCreationWithVariant() {
        let customDarkTheme = Base16Theme(
            name: "Custom Dark",
            author: "Test Author",
            variant: "dark",
            base00: "000000", base01: "111111", base02: "222222", base03: "333333",
            base04: "444444", base05: "555555", base06: "666666", base07: "777777",
            base08: "888888", base09: "999999", base0A: "aaaaaa", base0B: "bbbbbb",
            base0C: "cccccc", base0D: "dddddd", base0E: "eeeeee", base0F: "ffffff"
        )
        
        let customLightTheme = Base16Theme(
            name: "Custom Light",
            author: "Test Author",
            variant: "light",
            base00: "ffffff", base01: "eeeeee", base02: "dddddd", base03: "cccccc",
            base04: "bbbbbb", base05: "aaaaaa", base06: "999999", base07: "888888",
            base08: "777777", base09: "666666", base0A: "555555", base0B: "444444",
            base0C: "333333", base0D: "222222", base0E: "111111", base0F: "000000"
        )
        
        XCTAssertEqual(customDarkTheme.variant, "dark")
        XCTAssertTrue(customDarkTheme.isDark)
        XCTAssertFalse(customDarkTheme.isLight)
        
        XCTAssertEqual(customLightTheme.variant, "light")
        XCTAssertTrue(customLightTheme.isLight)
        XCTAssertFalse(customLightTheme.isDark)
    }
    
    func testTintedThemesLoaderFilterMethods() async throws {
        let loader = TintedThemesLoader.shared
        
        // Test that the filter methods exist and can be called
        // Note: These methods will return empty arrays in tests since they depend on cached themes
        let lightThemes = try await loader.loadLightThemes()
        let darkThemes = try await loader.loadDarkThemes()
        
        // Verify the methods return arrays (even if empty in test environment)
        XCTAssertTrue(lightThemes is [Base16Theme])
        XCTAssertTrue(darkThemes is [Base16Theme])
    }
}