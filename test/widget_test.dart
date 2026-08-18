import 'package:fitflowapp/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Splash screen navigates to onboarding after 2 seconds',
      (WidgetTester tester) async {
    await tester.pumpWidget(const FitFlowApp());

    expect(find.text('FitFlow'), findsOneWidget);
    expect(find.text('Elevate Your Movement'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('Onboarding'), findsOneWidget);
  });
}
