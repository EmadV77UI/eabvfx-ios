#!/bin/bash

# Create Xcode project structure
mkdir -p EABVFXBoost/EABVFXBoost
mkdir -p EABVFXBoost/EABVFXBoost/Assets.xcassets

# Copy Swift files
cp ContentView.swift EABVFXBoost/EABVFXBoost/
cp App.swift EABVFXBoost/EABVFXBoost/

# Copy HTML
cp index.html EABVFXBoost/EABVFXBoost/

# Create Info.plist
cat > EABVFXBoost/EABVFXBoost/Info.plist << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleName</key>
    <string>EABVFX Boost</string>
    <key>CFBundleIdentifier</key>
    <string>com.eabvfx.boost</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true/>
    </dict>
    <key>UIFileSharingEnabled</key>
    <true/>
    <key>LSSupportsOpeningDocumentsInPlace</key>
    <true/>
</dict>
</plist>
EOF

# Create Package.swift
cat > EABVFXBoost/Package.swift << 'EOF'
// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "EABVFXBoost",
    platforms: [.iOS(.v16)]
)
EOF

echo "✅ Project structure created!"
ls -la EABVFXBoost/EABVFXBoost/