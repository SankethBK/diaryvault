# GitHub Actions Setup for APK Building

This document explains how to set up the GitHub Action for automatically building and attaching APK files to releases.

## Overview

The `build_apk.yml` workflow automatically:
- Triggers when a new release is created or published
- Checks out the code at the release's tag
- Builds signed APKs (if keystore is configured) or debug APKs
- Uploads the APKs to the GitHub release
- Also saves APKs as workflow artifacts as backup

## Required Secrets (Optional - for signed APKs)

To build signed APKs, you need to set up the following secrets in your GitHub repository:

### 1. Keystore Setup

First, encode your keystore file to base64:
```bash
base64 -i your-keystore.jks | tr -d '\n' > keystore.base64
```

Then add these secrets to your GitHub repository (Settings → Secrets and variables → Actions):

- `KEYSTORE_BASE64`: The base64-encoded content of your keystore file
- `STORE_PASSWORD`: Password for the keystore
- `KEY_PASSWORD`: Password for the key
- `KEY_ALIAS`: Alias of the key in the keystore

### 2. Adding Secrets to GitHub

1. Go to your repository on GitHub
2. Navigate to Settings → Secrets and variables → Actions
3. Click "New repository secret"
4. Add each secret with the exact names listed above

## How It Works

### Automatic Trigger
- The workflow automatically runs when you create a new release
- It uses the commit associated with the release tag for building

### Manual Trigger
- You can also trigger the workflow manually from the Actions tab
- Optionally specify a tag name to build from a specific tag

### Fallback Behavior
- If no keystore secrets are configured, it builds debug APKs
- If building fails, APKs are still saved as workflow artifacts
- The workflow works both for signed and unsigned builds

## APK Outputs

The workflow builds APKs for three architectures:
- `arm64-v8a` (64-bit ARM - most modern devices)
- `armeabi-v7a` (32-bit ARM - older devices)
- `x86_64` (Intel/AMD 64-bit - emulators and some tablets)

## File Naming

APKs are uploaded with descriptive names:
- `diaryvault-arm64-v8a-v1.2.3.apk`
- `diaryvault-armeabi-v7a-v1.2.3.apk`
- `diaryvault-x86_64-v1.2.3.apk`

## Troubleshooting

### Common Issues

1. **Workflow fails on keystore**: Check that all keystore secrets are correctly set
2. **APK not found**: The workflow includes debugging steps to list built files
3. **Permission errors**: The workflow includes necessary permissions for writing to releases
4. **"flutter pub get" fails**: This project has local packages that need to be resolved first. The workflow automatically handles this by installing dependencies for local packages before the main project.

### Debug Steps

1. Check the workflow run logs in the Actions tab
2. Look for the "List built APKs" step to see what files were created
3. Check if APKs were uploaded as artifacts even if release upload failed
4. For dependency issues, check the "Verify Flutter installation" and "Install dependencies" steps

### Local Testing

If you want to test dependency installation locally, you can use the provided scripts:

**Linux/macOS:**
```bash
chmod +x scripts/install_deps.sh
./scripts/install_deps.sh
```

**Windows:**
```cmd
scripts\install_deps.bat
```

These scripts will:
- Check if Flutter is installed
- Install dependencies for all local packages first
- Install main project dependencies
- Run Flutter doctor for verification

### Building Without Signing

If you don't want to set up signing:
- The workflow will automatically build debug APKs
- These are still fully functional but not suitable for Play Store distribution
- Debug APKs are perfect for testing and direct distribution

## Testing the Workflow

1. Create a test release (can be a pre-release)
2. The workflow should automatically trigger
3. Check the Actions tab to monitor progress
4. Verify APKs are attached to the release

## Security Notes

- Never commit keystore files to your repository
- Always use base64 encoding for binary keystore files in secrets
- Keep your keystore passwords secure and use strong passwords
- Consider using different keystores for development and production
