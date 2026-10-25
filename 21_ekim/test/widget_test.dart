import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ders_programi_duzenleyici/main.dart';
import 'package:ders_programi_duzenleyici/core/constants/app_strings.dart';

void main() {
  testWidgets('App renders login view with Ataturk quote and credentials',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify app title and Ataturk quote banner with signature image
    expect(find.text(AppStrings.appTitle), findsOneWidget);
    expect(find.text('“${AppStrings.ataturkQuote}”'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    // Verify login inputs and role selector exist
    expect(find.text(AppStrings.loginTitle), findsAtLeastNWidgets(1));
    expect(find.byType(TextField), findsNWidgets(2));
  });
}
