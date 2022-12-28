import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_plugin/test_plugin_method_channel.dart';

void main() {
  MethodChannelTestPlugin platform = MethodChannelTestPlugin();
  const MethodChannel channel = MethodChannel('test_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'getPlatformVersion':
          return '42';
        case 'getModelName':
          return 'Iphone 12';
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });

  test('getModelName', () async {
    expect(await platform.getModelName(), 'Iphone 12');
  });
}
