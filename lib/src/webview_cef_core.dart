import 'dart:async';
import 'package:flutter/services.dart';
import 'webview_cef_options.dart';

/// Core class for initializing webview_cef with configuration options.
///
/// This class provides a one-time initialization entry point for configuring
/// webview_cef before any CEF views are created.
class WebviewCef {
  WebviewCef._();

  static bool _isInitialized = false;
  static WebviewCefOptions? _options;
  static const MethodChannel _channel = MethodChannel('webview_cef');

  /// Initializes webview_cef with the given options.
  ///
  /// This method must be called before any CEF views are created.
  /// It can only be called once per application lifecycle.
  ///
  /// [options] - Configuration options including remote debugging settings.
  ///
  /// Throws [StateError] if called after initialization or if options are invalid.
  /// Throws [PlatformException] if the platform fails to initialize.
  static Future<void> initialize([WebviewCefOptions? options]) async {
    if (_isInitialized) {
      throw StateError('WebviewCef.initialize() can only be called once');
    }

    // Validate options if provided
    if (options != null) {
      final validationError = options.validate();
      if (validationError != null) {
        throw ArgumentError(validationError);
      }
    }

    try {
      // Store options for later access
      _options = options;

      // Call platform-specific initialization
      await _channel.invokeMethod('initialize', {
        'remoteDebuggingPort': options?.remoteDebuggingPort,
        'remoteDebuggingAddress': options?.remoteDebuggingAddress ?? '127.0.0.1',
        'remoteAllowOrigins': options?.remoteAllowOrigins,
      });

      _isInitialized = true;
    } on PlatformException catch (e) {
      throw PlatformException(
        code: e.code,
        message: e.message,
        details: e.details,
      );
    }
  }

  /// Returns whether webview_cef has been initialized.
  static bool get isInitialized => _isInitialized;

  /// Returns the effective debugging configuration after initialization.
  ///
  /// Returns null if remote debugging is not enabled.
  static WebviewCefOptions? get debuggingOptions => _options;

  /// Returns the effective debugging URL for connecting DevTools.
  ///
  /// Returns null if remote debugging is not enabled.
  static String? get debuggingUrl {
    if (_options?.remoteDebuggingPort == null) return null;
    return 'http://${_options!.remoteDebuggingAddress}:${_options!.remoteDebuggingPort}';
  }

  /// Returns the WebSocket debugging URL for connecting DevTools.
  ///
  /// This URL can be obtained by calling the /json/version endpoint
  /// on the debugging server and extracting the webSocketDebuggerUrl field.
  ///
  /// Returns null if remote debugging is not enabled.
  static String? get webSocketDebuggingUrl {
    if (_options?.remoteDebuggingPort == null) return null;
    // The actual WebSocket URL is provided by the /json/version endpoint
    // This is just a placeholder - the real URL comes from CEF
    return 'ws://${_options!.remoteDebuggingAddress}:${_options!.remoteDebuggingPort}';
  }

  /// Checks if remote debugging is enabled.
  static bool get isRemoteDebuggingEnabled => _options?.remoteDebuggingPort != null;
}
