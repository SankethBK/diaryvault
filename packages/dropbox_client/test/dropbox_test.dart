import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:dropbox_client/dropbox_client.dart';

void main() {
  const MethodChannel channel = MethodChannel('dropbox');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
}
