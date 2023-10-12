import 'package:dairy_app/app/view/app.dart';
import 'package:dairy_app/core/pages/home_page.dart';
import 'package:dairy_app/features/auth/presentation/pages/auth_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

Future<void> main() async{
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Guest login test, click on sign up button to move reveal guest login button'
      'click the guest login button to enter HomePage', (WidgetTester tester) async {
    await tester.pumpWidget(App());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sign up'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue as guest'));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(AuthPage), findsNothing);
  });
}