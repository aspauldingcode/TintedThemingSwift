# GitHub Actions Workflows

This document describes the GitHub Actions workflows configured for the TintedThemingSwift package.

## Overview

The project includes two main workflows:
- **CI Workflow** (`ci.yml`) - Continuous integration for pull requests and pushes
- **Release Workflow** (`release.yml`) - Automated releases when tags are pushed

## CI Workflow (`.github/workflows/ci.yml`)

The CI workflow runs on:
- Push to `main` and `develop` branches
- Pull requests to `main` and `develop` branches

### Jobs

#### 1. Swift Tests
- **Xcode Versions**: 15.1, 15.0
- **Features**:
  - SPM dependency caching
  - Test execution with code coverage
  - Coverage upload to Codecov

#### 2. Platform Compatibility
- **Platforms**: macOS, iOS Simulator, watchOS Simulator, tvOS Simulator
- **Xcode Version**: 15.1
- **Purpose**: Ensures the package builds across all supported platforms

#### 3. Package Validation
- Validates package structure and dependencies
- Checks Package.swift manifest
- Performs Swift syntax validation

#### 4. Documentation Check
- Verifies README.md and wiki.adoc existence
- Checks for inline documentation in Swift files
- Attempts Swift-DocC documentation generation (if available)

## Release Workflow (`.github/workflows/release.yml`)

The release workflow triggers on:
- Git tags matching pattern `v*` (e.g., `v1.0.0`, `v2.1.3`)

### Features

#### Multi-Platform Testing
- **Xcode Versions**: 15.1, 15.0
- **Platforms**: macOS, iOS, watchOS, tvOS simulators
- Ensures compatibility before release

#### Automated Package Creation
- Creates `.tar.gz` and `.zip` archives of the package source
- Generates documentation (if Swift-DocC is available)
- Packages documentation as separate archive

#### GitHub Release
- Automatically creates GitHub release from tag
- Uploads all generated artifacts
- Uses tag message as release notes

### Release Artifacts

Each release includes:
1. **Source Archive** (`.tar.gz`) - Complete package source
2. **Source Archive** (`.zip`) - Complete package source (Windows-friendly)
3. **Documentation** (`.tar.gz`) - Generated documentation (if available)

## Creating a Release

To create a new release:

1. **Tag the release**:
   ```bash
   git tag -a v1.0.0 -m "Release version 1.0.0"
   git push origin v1.0.0
   ```

2. **Monitor the workflow**:
   - Go to the "Actions" tab in your GitHub repository
   - Watch the "Release" workflow execute
   - Verify all jobs complete successfully

3. **Check the release**:
   - Navigate to the "Releases" section
   - Verify the new release appears with artifacts

## Installation from Release

Users can install the package using Swift Package Manager:

### Xcode
1. File → Add Package Dependencies
2. Enter repository URL
3. Select version or branch

### Package.swift
```swift
dependencies: [
    .package(url "https://github.com/yourusername/TintedThemingSwift.git", from: "1.0.0")
]
```

## Workflow Requirements

### Repository Secrets
- **CODECOV_TOKEN** (optional): For code coverage reporting

### Branch Protection
Recommended branch protection rules for `main`:
- Require pull request reviews
- Require status checks (CI workflow)
- Require up-to-date branches

## Customization

### Modifying Xcode Versions
Update the `xcode-version` matrix in both workflows:
```yaml
strategy:
  matrix:
    xcode-version: ['15.1', '15.0', '14.3']  # Add/remove versions
```

### Adding Platforms
Extend the platform matrix in the release workflow:
```yaml
strategy:
  matrix:
    platform: [macOS, iOS, watchOS, tvOS, visionOS]  # Add new platforms
```

### Custom Build Steps
Add additional steps to the workflows as needed:
```yaml
- name: Custom Step
  run: |
    # Your custom commands here
```

## Troubleshooting

### Common Issues

1. **Build Failures**
   - Check Xcode version compatibility
   - Verify all dependencies are available
   - Review build logs in Actions tab

2. **Test Failures**
   - Ensure all tests pass locally first
   - Check for platform-specific test issues
   - Review test output in workflow logs

3. **Release Creation Failures**
   - Verify tag format matches `v*` pattern
   - Check repository permissions
   - Ensure no duplicate releases exist

### Getting Help

If you encounter issues:
1. Check the Actions tab for detailed logs
2. Review this documentation
3. Check GitHub Actions documentation
4. Open an issue in the repository