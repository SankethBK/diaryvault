import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart'
    as di;

import 'test_helpers.dart';

Future<void> main() async {
  setUpAll(() async {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    await di.init();
  });

  testWidgets('Perform a successful guest login', (WidgetTester tester) async {
    await launchGuestSession(tester);
    await Future.delayed(const Duration(seconds: 3));
  });
}
