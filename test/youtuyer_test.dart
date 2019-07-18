import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youtuyer/youtuyer.dart';

void main() {
  const MethodChannel channel = MethodChannel('youtuyer');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Youtuyer.platformVersion, '42');
  });
}
