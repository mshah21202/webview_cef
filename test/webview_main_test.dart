import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webview_cef/webview_cef.dart';

void main() {
  testWidgets('WebviewCef initialization state', (WidgetTester tester) async {
    // Test initial state
    expect(WebviewCef.isInitialized, isFalse);
    expect(WebviewCef.isRemoteDebuggingEnabled, isFalse);
    expect(WebviewCef.debuggingOptions, isNull);
    expect(WebviewCef.debuggingUrl, isNull);
    expect(WebviewCef.webSocketDebuggingUrl, isNull);
    
    // Test that we can't create webviews without initialization
    expect(() => WebviewManager().createWebView(), throwsStateError);
  });
}
