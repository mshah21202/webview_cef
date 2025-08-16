import 'package:flutter_test/flutter_test.dart';
import 'package:webview_cef/webview_cef.dart';
import 'package:webview_cef/webview_cef_platform_interface.dart';
import 'package:webview_cef/webview_cef_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWebviewCefPlatform
    with MockPlatformInterfaceMixin
    implements WebviewCefPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final WebviewCefPlatform initialPlatform = WebviewCefPlatform.instance;

  test('$MethodChannelWebviewCef is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWebviewCef>());
  });

  test('WebviewCef is a static class', () {
    expect(WebviewCef.isInitialized, isFalse);
    expect(WebviewCef.isRemoteDebuggingEnabled, isFalse);
    expect(WebviewCef.debuggingOptions, isNull);
    expect(WebviewCef.debuggingUrl, isNull);
    expect(WebviewCef.webSocketDebuggingUrl, isNull);
  });
}
