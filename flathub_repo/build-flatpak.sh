#!/bin/bash

# MIT License
# 
# Copyright (c) 2024 Kristen McWilliam
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


# Convert the archive of the Flutter app to a Flatpak.


# Exit if any command fails
set -e

# Echo all commands for debug purposes
set -x


# No spaces in project name.
projectName=OpenClawInstaller
projectId=com.openclaw_installer.OpenClawInstaller
executableName=openclaw_installer


# ------------------------------- Build Flatpak ----------------------------- #

# Extract portable Flutter build.
mkdir -p $projectName
tar --no-same-owner -xf $projectName-Linux-Portable.tar.gz -C $projectName

# Copy the portable app to the Flatpak-based location.
cp -r $projectName /app/
chmod +x /app/$projectName/$executableName
mkdir -p /app/bin
ln -s /app/$projectName/$executableName /app/bin/$executableName

# Install the icon. Desktop file expects Icon=com.openclaw_installer.OpenClawInstaller
# Use pre-generated icons from packaging/linux/icons/ (run scripts/generate-flatpak-icons.sh)
# Icons must match directory size - max 512x512 for hicolor theme
iconName=$projectId.png
for size in 48 128 256; do
  iconDir=/app/share/icons/hicolor/${size}x${size}/apps
  iconSrc=packaging/linux/icons/${size}x${size}/$iconName
  mkdir -p "$iconDir"
  if [ -f "$iconSrc" ]; then
    cp "$iconSrc" "$iconDir/"
  else
    echo "ERROR: Icon not found at $iconSrc (run: ./scripts/generate-flatpak-icons.sh)"
    exit 1
  fi
done

# Install the desktop file.
desktopFileDir=/app/share/applications
mkdir -p $desktopFileDir
cp -r packaging/linux/$projectId.desktop $desktopFileDir/

# Install the AppStream metadata file.
metadataDir=/app/share/metainfo
mkdir -p $metadataDir
cp -r packaging/linux/$projectId.metainfo.xml $metadataDir/
