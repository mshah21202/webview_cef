import 'package:flutter_test/flutter_test.dart';
import 'package:webview_cef/webview_cef.dart';

void main() {
  group('WebviewCef Remote Debugging Tests', () {
    test('should initialize with valid options', () async {
      const options = WebviewCefOptions(
        remoteDebuggingPort: 9222,
        remoteDebuggingAddress: '127.0.0.1',
        remoteAllowOrigins: 'http://127.0.0.1:9222',
      );

      expect(options.validate(), isNull);
      expect(options.remoteDebuggingPort, equals(9222));
      expect(options.remoteDebuggingAddress, equals('127.0.0.1'));
      expect(options.remoteAllowOrigins, equals('http://127.0.0.1:9222'));
    });

    test('should validate port range correctly', () {
      // Test invalid port numbers
      const invalidPortOptions = WebviewCefOptions(remoteDebuggingPort: 1023);
      expect(invalidPortOptions.validate(), isNotNull);
      expect(invalidPortOptions.validate()!.contains('1024 and 65535'), isTrue);

      const invalidPortOptions2 = WebviewCefOptions(remoteDebuggingPort: 65536);
      expect(invalidPortOptions2.validate(), isNotNull);
      expect(invalidPortOptions2.validate()!.contains('1024 and 65535'), isTrue);

      // Test valid port numbers
      const validPortOptions = WebviewCefOptions(remoteDebuggingPort: 1024);
      expect(validPortOptions.validate(), isNull);

      const validPortOptions2 = WebviewCefOptions(remoteDebuggingPort: 65535);
      expect(validPortOptions2.validate(), isNull);

      const validPortOptions3 = WebviewCefOptions(remoteDebuggingPort: 9222);
      expect(validPortOptions3.validate(), isNull);
    });

    test('should validate address correctly', () {
      const emptyAddressOptions = WebviewCefOptions(remoteDebuggingAddress: '');
      expect(emptyAddressOptions.validate(), isNotNull);
      expect(emptyAddressOptions.validate()!.contains('cannot be empty'), isTrue);

      const validAddressOptions = WebviewCefOptions(remoteDebuggingAddress: '127.0.0.1');
      expect(validAddressOptions.validate(), isNull);
    });

    test('should provide correct debugging URLs', () {
      const options = WebviewCefOptions(
        remoteDebuggingPort: 9222,
        remoteDebuggingAddress: '127.0.0.1',
      );

      // Mock the static state for testing
      // In real usage, this would be set by WebviewCef.initialize()
      expect(options.remoteDebuggingPort, equals(9222));
      expect(options.remoteDebuggingAddress, equals('127.0.0.1'));
    });

    test('should copy options correctly', () {
      const original = WebviewCefOptions(
        remoteDebuggingPort: 9222,
        remoteDebuggingAddress: '127.0.0.1',
        remoteAllowOrigins: 'http://127.0.0.1:9222',
      );

      final copy = original.copyWith(remoteDebuggingPort: 9223);
      expect(copy.remoteDebuggingPort, equals(9223));
      expect(copy.remoteDebuggingAddress, equals('127.0.0.1'));
      expect(copy.remoteAllowOrigins, equals('http://127.0.0.1:9222'));

      final copy2 = original.copyWith(remoteDebuggingAddress: '0.0.0.0');
      expect(copy2.remoteDebuggingPort, equals(9222));
      expect(copy2.remoteDebuggingAddress, equals('0.0.0.0'));
      expect(copy2.remoteAllowOrigins, equals('http://127.0.0.1:9222'));
    });

    test('should handle equality correctly', () {
      const options1 = WebviewCefOptions(
        remoteDebuggingPort: 9222,
        remoteDebuggingAddress: '127.0.0.1',
        remoteAllowOrigins: 'http://127.0.0.1:9222',
      );

      const options2 = WebviewCefOptions(
        remoteDebuggingPort: 9222,
        remoteDebuggingAddress: '127.0.0.1',
        remoteAllowOrigins: 'http://127.0.0.1:9222',
      );

      const options3 = WebviewCefOptions(
        remoteDebuggingPort: 9223,
        remoteDebuggingAddress: '127.0.0.1',
        remoteAllowOrigins: 'http://127.0.0.1:9222',
      );

      expect(options1, equals(options2));
      expect(options1, isNot(equals(options3)));
      expect(options1.hashCode, equals(options2.hashCode));
      expect(options1.hashCode, isNot(equals(options3.hashCode)));
    });
  });
}
