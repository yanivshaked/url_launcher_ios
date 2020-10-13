import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:url_launcher_ios/url_launcher_ios.dart';

void main() {
  const MethodChannel channel = MethodChannel('url_launcher_ios');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return true;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('launch', () async {
    expect(await UrlLauncherIos.launch("http://www.cnn.com"), true);
  });
}
