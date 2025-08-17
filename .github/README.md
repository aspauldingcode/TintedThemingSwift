# GitHub Actions Workflows

This repository includes two GitHub Actions workflows for continuous integration and release management:

## CI Workflow (`.github/workflows/ci.yml`)

Runs on every push and pull request to `main` and `develop` branches.

### Features:
- **Multi-Xcode Testing**: Tests against multiple Xcode versions (15.0, 15.1)
- **Platform Compatibility**: Builds and tests on macOS, iOS, watchOS, and tvOS
- **Code Coverage**: Generates and uploads coverage reports to Codecov
- **Package Validation**: Validates Package.swift structure and dependencies
- **Documentation Check**: Verifies documentation exists and can be generated
- **Swift Linting**: Basic syntax validation for all Swift files

### Triggered by:
- Push to `main` or `develop` branches
- Pull requests to `main` or `develop` branches
- Manual workflow dispatch

## Release Workflow (`.github/workflows/release.yml`)

Builds and packages the Swift package for GitHub releases.

### Features:
- **Automated Testing**: Runs full test suite before release
- **Multi-Platform Building**: Tests on macOS, iOS, watchOS, and tvOS
- **Package Creation**: Creates `.tar.gz` and `.zip` archives of the package
- **Documentation Generation**: Generates Swift-DocC documentation (if available)
- **GitHub Release**: Automatically creates GitHub release with artifacts
- **Release Notes**: Auto-generates release notes with installation instructions

### Triggered by:
- Git tags starting with `v` (e.g., `v1.0.0`, `v2.1.3`)
- Pull requests (for testing)
- Manual workflow dispatch

## Creating a Release

To create a new release:

1. **Tag your commit**:
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```

2. **The workflow will automatically**:
   - Run all tests
   - Build the package for all platforms
   - Create package archives
   - Generate documentation
   - Create a GitHub release with artifacts

## Release Artifacts

Each release includes:

- **`TintedThemingSwift-vX.X.X.tar.gz`** - Complete package source (tar.gz format)
- **`TintedThemingSwift-vX.X.X.zip`** - Complete package source (zip format)
- **`TintedThemingSwift-Documentation-vX.X.X.tar.gz`** - Generated Swift-DocC documentation (if available)
- **`PACKAGE_INFO.md`** - Package information and installation instructions

## Package Contents

Each package archive contains:
- `Sources/` - All Swift source files
- `Package.swift` - Swift Package Manager manifest
- `README.md` - Project documentation
- `LICENSE` - License file (if present)
- `PACKAGE_INFO.md` - Version and installation information

## Installation from Release

Users can install the package by adding it to their `Package.swift`:

```swift
.package(url: "https://github.com/aspauldingcode/TintedThemingSwift.git", from: "1.0.0")
```

Or by downloading and extracting the release archives for manual integration.

## Workflow Requirements

- **macOS runner**: Required for Xcode and Swift Package Manager
- **Xcode 15.0+**: For building and testing
- **GitHub token**: Automatically provided by GitHub Actions
- **Codecov token**: Optional, for code coverage reporting

## Customization

To customize the workflows:

1. **Update Xcode versions**: Modify the `matrix.xcode` values in both workflows
2. **Change platforms**: Update the `matrix.destination` values
3. **Modify release content**: Edit the release body template in `release.yml`
4. **Add additional checks**: Extend the validation steps in `ci.yml`

Both workflows are designed to be robust and provide comprehensive testing and packaging for the TintedThemingSwift package.