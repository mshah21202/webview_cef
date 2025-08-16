/// Configuration options for initializing webview_cef.
class WebviewCefOptions {
  /// Creates a new [WebviewCefOptions] instance.
  const WebviewCefOptions({
    this.remoteDebuggingPort,
    this.remoteDebuggingAddress = '127.0.0.1',
    this.remoteAllowOrigins,
  });

  /// The port number for remote debugging (1024-65535).
  ///
  /// If specified, enables the Chrome DevTools Protocol server.
  /// Must be in the valid port range.
  final int? remoteDebuggingPort;

  /// The address to bind the remote debugging server to.
  ///
  /// Defaults to '127.0.0.1' (localhost only) for security.
  /// Only change this if you need external access and understand the security implications.
  final String remoteDebuggingAddress;

  /// Origins allowed to connect to the remote debugging server.
  ///
  /// Examples:
  /// - 'http://127.0.0.1:9222' for a specific origin
  /// - '*' for any origin (less secure)
  ///
  /// This is required by some Chromium builds for security.
  final String? remoteAllowOrigins;

  /// Validates the options and returns an error message if invalid.
  String? validate() {
    if (remoteDebuggingPort != null) {
      if (remoteDebuggingPort! < 1024 || remoteDebuggingPort! > 65535) {
        return 'remoteDebuggingPort must be between 1024 and 65535';
      }
    }

    if (remoteDebuggingAddress.isEmpty) {
      return 'remoteDebuggingAddress cannot be empty';
    }

    return null;
  }

  /// Creates a copy of this object with the given fields replaced.
  WebviewCefOptions copyWith({
    int? remoteDebuggingPort,
    String? remoteDebuggingAddress,
    String? remoteAllowOrigins,
  }) {
    return WebviewCefOptions(
      remoteDebuggingPort: remoteDebuggingPort ?? this.remoteDebuggingPort,
      remoteDebuggingAddress: remoteDebuggingAddress ?? this.remoteDebuggingAddress,
      remoteAllowOrigins: remoteAllowOrigins ?? this.remoteAllowOrigins,
    );
  }

  @override
  String toString() {
    return 'WebviewCefOptions(remoteDebuggingPort: $remoteDebuggingPort, remoteDebuggingAddress: $remoteDebuggingAddress, remoteAllowOrigins: $remoteAllowOrigins)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WebviewCefOptions &&
        other.remoteDebuggingPort == remoteDebuggingPort &&
        other.remoteDebuggingAddress == remoteDebuggingAddress &&
        other.remoteAllowOrigins == remoteAllowOrigins;
  }

  @override
  int get hashCode {
    return remoteDebuggingPort.hashCode ^ remoteDebuggingAddress.hashCode ^ remoteAllowOrigins.hashCode;
  }
}
