import Foundation
import Yams

/// Main class for loading Base16 and Base24 themes from the tinted-theming/schemes repository
public class TintedThemesLoader {
    
    public static let shared = TintedThemesLoader()
    
    private let baseURL = "https://raw.githubusercontent.com/tinted-theming/schemes/spec-0.11"
    private let apiURL = "https://api.github.com/repos/tinted-theming/schemes/contents"
    
    // Cache management
    private let cacheDirectory: URL
    private let themeCacheFile: URL
    private let lastUpdateKey = "TintedThemes_LastUpdate"
    private let cacheExpiryHours: TimeInterval = 24 // Cache expires after 24 hours
    
    private init() {
        // Setup cache directory
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        cacheDirectory = documentsPath.appendingPathComponent("TintedThemes")
        themeCacheFile = cacheDirectory.appendingPathComponent("themes_cache.json")
        
        // Create cache directory if it doesn't exist
        try? FileManager.default.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
    }
    
    // MARK: - Public API
    
    /// Loads all available Base16 themes, using cache when available
    public func loadAllBase16Themes() async throws -> [Base16Theme] {
        // First try to load from cache
        if let cachedThemes = loadThemesFromCache(), !shouldRefreshCache() {
            NSLog("✅ Loaded \(cachedThemes.count) themes from cache")
            return cachedThemes
        }
        
        // Cache is expired or doesn't exist, fetch from network
        NSLog("🌐 Cache expired or missing, fetching themes from network...")
        let networkThemes = try await fetchThemesFromNetwork()
        
        // Save to cache
        saveThemesToCache(networkThemes)
        NSLog("💾 Cached \(networkThemes.count) themes for future use")
        
        return networkThemes
    }
    
    /// Forces a refresh of themes from network, ignoring cache
    public func refreshThemes() async throws -> [Base16Theme] {
        NSLog("🔄 Force refreshing themes from network...")
        let networkThemes = try await fetchThemesFromNetwork()
        saveThemesToCache(networkThemes)
        NSLog("✅ Refreshed and cached \(networkThemes.count) themes")
        return networkThemes
    }
    
    /// Gets cached themes immediately without network call
    public func getCachedThemes() -> [Base16Theme] {
        return loadThemesFromCache() ?? []
    }
    
    /// Loads all available Base24 themes from the repository
    public func loadAllBase24Themes() async throws -> [Base24Theme] {
        let themeNames = try await fetchThemeList(for: "base24")
        return await loadBase24Themes(named: themeNames)
    }
    
    /// Loads a specific Base16 theme by name
    public func loadBase16Theme(named name: String) async throws -> Base16Theme? {
        return await loadBase16Theme(name: name)
    }
    
    /// Loads a specific Base24 theme by name
    public func loadBase24Theme(named name: String) async throws -> Base24Theme? {
        return await loadBase24Theme(name: name)
    }
    
    /// Loads multiple Base16 themes by name
    public func loadBase16Themes(named names: [String]) async -> [Base16Theme] {
        NSLog("Loading \(names.count) themes concurrently...")
        
        return await withTaskGroup(of: Base16Theme?.self) { group in
            for name in names {
                group.addTask {
                    let theme = await self.loadBase16Theme(name: name)
                    if theme != nil {
                        NSLog("✓ Loaded theme: \(name)")
                    } else {
                        NSLog("✗ Failed to load theme: \(name)")
                    }
                    return theme
                }
            }
            
            var themes: [Base16Theme] = []
            for await theme in group {
                if let theme = theme {
                    themes.append(theme)
                }
            }
            
            NSLog("Completed loading: \(themes.count) out of \(names.count) themes")
            return themes.sorted { $0.name < $1.name }
        }
    }
    
    /// Loads multiple Base24 themes by name
    public func loadBase24Themes(named names: [String]) async -> [Base24Theme] {
        await withTaskGroup(of: Base24Theme?.self) { group in
            for name in names {
                group.addTask {
                    await self.loadBase24Theme(name: name)
                }
            }
            
            var themes: [Base24Theme] = []
            for await theme in group {
                if let theme = theme {
                    themes.append(theme)
                }
            }
            return themes.sorted { $0.name < $1.name }
        }
    }
    
    // MARK: - Cache Management
    
    private func shouldRefreshCache() -> Bool {
        let defaults = UserDefaults.standard
        guard let lastUpdate = defaults.object(forKey: lastUpdateKey) as? Date else {
            return true // No last update time, should refresh
        }
        
        let hoursSinceLastUpdate = Date().timeIntervalSince(lastUpdate) / 3600
        return hoursSinceLastUpdate > cacheExpiryHours
    }
    
    private func loadThemesFromCache() -> [Base16Theme]? {
        do {
            guard FileManager.default.fileExists(atPath: themeCacheFile.path) else {
                NSLog("⚠️ No theme cache file found")
                return nil
            }
            
            let data = try Data(contentsOf: themeCacheFile)
            let decoder = JSONDecoder()
            let themes = try decoder.decode([Base16Theme].self, from: data)
            NSLog("📂 Loaded \(themes.count) themes from cache file")
            return themes
        } catch {
            NSLog("❌ Failed to load themes from cache: \(error)")
            return nil
        }
    }
    
    private func saveThemesToCache(_ themes: [Base16Theme]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(themes)
            try data.write(to: themeCacheFile)
            
            // Update last refresh time
            UserDefaults.standard.set(Date(), forKey: lastUpdateKey)
            NSLog("💾 Saved \(themes.count) themes to cache")
        } catch {
            NSLog("❌ Failed to save themes to cache: \(error)")
        }
    }
    
    private func fetchThemesFromNetwork() async throws -> [Base16Theme] {
        NSLog("🌐 Fetching theme list from GitHub API...")
        let themeNames = try await fetchThemeList(for: "base16")
        NSLog("📋 Fetched \(themeNames.count) theme names from GitHub API")
        
        let themes = await loadBase16Themes(named: themeNames)
        NSLog("✅ Successfully loaded \(themes.count) themes from network")
        return themes
    }
    
    // MARK: - Private Methods
    
    private func fetchThemeList(for type: String) async throws -> [String] {
        let url = URL(string: "\(apiURL)/\(type)")!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Check for HTTP errors
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            // Try to decode error response
            if let errorData = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let message = errorData["message"] as? String {
                throw NSError(domain: "GitHubAPI", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: message])
            }
            throw NSError(domain: "GitHubAPI", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP \(httpResponse.statusCode)"])
        }
        
        struct GitHubFile: Codable {
            let name: String
            let type: String
        }
        
        // Try to decode as array first, if it fails, check if it's an error response
        do {
            let files = try JSONDecoder().decode([GitHubFile].self, from: data)
            return files
                .filter { $0.type == "file" && $0.name.hasSuffix(".yaml") }
                .map { String($0.name.dropLast(5)) } // Remove .yaml extension
        } catch {
            // If decoding as array fails, try to decode as error response
            if let errorData = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let message = errorData["message"] as? String {
                throw NSError(domain: "GitHubAPI", code: -1, userInfo: [NSLocalizedDescriptionKey: "GitHub API Error: \(message)"])
            }
            // Re-throw original decoding error
            throw error
        }
    }
    
    private func loadBase16Theme(name: String) async -> Base16Theme? {
        do {
            let url = URL(string: "\(baseURL)/base16/\(name).yaml")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let yamlString = String(data: data, encoding: .utf8) ?? ""
            
            guard let yamlData = try Yams.load(yaml: yamlString) as? [String: Any] else {
                NSLog("Failed to parse YAML for theme: \(name)")
                return nil
            }
            
            return parseBase16Theme(from: yamlData, name: name)
        } catch {
            NSLog("Failed to load Base16 theme '\(name)': \(error)")
            return nil
        }
    }
    
    private func loadBase24Theme(name: String) async -> Base24Theme? {
        do {
            let url = URL(string: "\(baseURL)/base24/\(name).yaml")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let yamlString = String(data: data, encoding: .utf8) ?? ""
            
            guard let yamlData = try Yams.load(yaml: yamlString) as? [String: Any] else {
                print("Failed to parse YAML for theme: \(name)")
                return nil
            }
            
            return parseBase24Theme(from: yamlData, name: name)
        } catch {
            print("Failed to load Base24 theme '\(name)': \(error)")
            return nil
        }
    }
    
    private func parseBase16Theme(from yamlData: [String: Any], name: String) -> Base16Theme? {
        guard let themeName = yamlData["name"] as? String,
              let author = yamlData["author"] as? String else {
            NSLog("Missing name or author in theme \(name)")
            return nil
        }
        
        // Parse variant (light/dark) - default to "dark" if not specified
        let variant = yamlData["variant"] as? String ?? "dark"
        
        // Check if colors are in a palette structure (new format) or at root level (old format)
        let colorSource: [String: Any]
        if let palette = yamlData["palette"] as? [String: Any] {
            colorSource = palette
        } else {
            colorSource = yamlData
        }
        
        let colors = [
            "base00", "base01", "base02", "base03",
            "base04", "base05", "base06", "base07",
            "base08", "base09", "base0A", "base0B",
            "base0C", "base0D", "base0E", "base0F"
        ]
        
        var colorValues: [String] = []
        for colorKey in colors {
            guard let colorValue = colorSource[colorKey] as? String else {
                NSLog("Missing color \(colorKey) in theme \(name)")
                return nil
            }
            // Remove # prefix if present
            let cleanColor = colorValue.hasPrefix("#") ? String(colorValue.dropFirst()) : colorValue
            colorValues.append(cleanColor)
        }
        
        return Base16Theme(
            name: themeName,
            author: author,
            variant: variant,
            base00: colorValues[0], base01: colorValues[1], base02: colorValues[2], base03: colorValues[3],
            base04: colorValues[4], base05: colorValues[5], base06: colorValues[6], base07: colorValues[7],
            base08: colorValues[8], base09: colorValues[9], base0A: colorValues[10], base0B: colorValues[11],
            base0C: colorValues[12], base0D: colorValues[13], base0E: colorValues[14], base0F: colorValues[15]
        )
    }
    
    private func parseBase24Theme(from yamlData: [String: Any], name: String) -> Base24Theme? {
        guard let scheme = yamlData["scheme"] as? String,
              let author = yamlData["author"] as? String else {
            return nil
        }
        
        let colors = [
            "base00", "base01", "base02", "base03",
            "base04", "base05", "base06", "base07",
            "base08", "base09", "base0A", "base0B",
            "base0C", "base0D", "base0E", "base0F",
            "base10", "base11", "base12", "base13",
            "base14", "base15", "base16", "base17"
        ]
        
        var colorValues: [String] = []
        for colorKey in colors {
            guard let colorValue = yamlData[colorKey] as? String else {
                print("Missing color \(colorKey) in theme \(name)")
                return nil
            }
            colorValues.append(colorValue)
        }
        
        return Base24Theme(
            name: scheme,
            author: author,
            base00: colorValues[0], base01: colorValues[1], base02: colorValues[2], base03: colorValues[3],
            base04: colorValues[4], base05: colorValues[5], base06: colorValues[6], base07: colorValues[7],
            base08: colorValues[8], base09: colorValues[9], base0A: colorValues[10], base0B: colorValues[11],
            base0C: colorValues[12], base0D: colorValues[13], base0E: colorValues[14], base0F: colorValues[15],
            base10: colorValues[16], base11: colorValues[17], base12: colorValues[18], base13: colorValues[19],
            base14: colorValues[20], base15: colorValues[21], base16: colorValues[22], base17: colorValues[23]
        )
    }
    
    /// Loads only light variant themes
    public func loadLightThemes() async throws -> [Base16Theme] {
        let allThemes = try await loadAllBase16Themes()
        return allThemes.filter { $0.isLight }
    }
    
    /// Loads only dark variant themes
    public func loadDarkThemes() async throws -> [Base16Theme] {
        let allThemes = try await loadAllBase16Themes()
        return allThemes.filter { $0.isDark }
    }
}