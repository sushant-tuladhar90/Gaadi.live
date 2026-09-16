// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gaadi_live/main.dart';
import 'package:gaadi_live/features/routes/presentation/routes_screen.dart';

void main() {
  testWidgets('Gaadi Live app loads with the onboarding content', (WidgetTester tester) async {
    await tester.pumpWidget(const GaadiLiveApp());

    expect(find.text('REAL-TIME GPS & SENSOR TELEMETRY'), findsOneWidget);
    expect(find.textContaining('Track Every Mile'), findsOneWidget);
    expect(find.text('Get Started →'), findsOneWidget);

    final getStartedButton = find.text('Get Started →');
    await tester.scrollUntilVisible(
      getStartedButton,
      300,
      scrollable: find.byType(Scrollable),
    );
    await tester.tap(getStartedButton);
    await tester.pumpAndSettle();

    expect(find.text('Scan Vehicle QR Code'), findsOneWidget);
    expect(find.text('Scan QR Code'), findsOneWidget);
  });

  testWidgets('Routes page renders its route profiles', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: RoutesScreen()));

    expect(find.text('Routes'), findsOneWidget);
    expect(find.text('Route Profiles'), findsOneWidget);
    expect(find.text('Route 4A - Downtown Corridor'), findsOneWidget);
    expect(find.text('Launch Navigation'), findsOneWidget);
  });
}
