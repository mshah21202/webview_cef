## 0.3.0

- **NEW**: Added first-class support for Chromium remote debugging port configuration
- **NEW**: Added `WebviewCef.initialize()` API for configuring debugging options before webview creation
- **NEW**: Added `WebviewCefOptions` class with validation for debugging configuration
- **NEW**: Added support for `remoteDebuggingPort`, `remoteDebuggingAddress`, and `remoteAllowOrigins` options
- **NEW**: Added getters for debugging URLs and configuration status
- **BREAKING**: `WebviewCef.initialize()` must now be called before creating any webviews
- **IMPROVEMENT**: Better error handling and validation for debugging configuration
- **IMPROVEMENT**: Added comprehensive tests for the new debugging functionality
- **DOCUMENTATION**: Added comprehensive documentation for remote debugging setup and usage

## 0.2.0
- Linux support!
- Multiple instances support.
- js eval support.

## 0.1.0
- JS bridge support (Thanks to @SinyimZhi)
- Cookie manipulation support (Thanks to @SinyimZhi)
- [Windows] fix compile error after upgrade from a lower version

## 0.0.9

- [Windows] Fixed crash caused by frame buffer lock.
- [Windows] Fixed WebGL support.

## 0.0.8

- Added support to build macOS universal app.
- Refined scrolling for different platform.
- Added search bar features in example project.
- Added title & url change aware in UI.

## 0.0.7

- Basic characters input support.
- Added back, forward, reload APIs.
- Mouse move events support.
- HTML5 drag & drop support.

## 0.0.6

- Fixed macOS compile issue.

## 0.0.5

1. Initial support for macOS.
2. Touchpad support (based on flutter 3.3).
3. Hi-DPI display support.

## 0.0.3

- Fixed compile issue on non-utf8 machines.

## 0.0.1

- Webview CEF plugin for Flutter Desktop.
- Windows support only.
