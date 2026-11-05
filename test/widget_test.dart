// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/models/sandwich.dart';
import 'package:flutter_app/screens/menu_screen.dart';
import 'package:flutter_app/screens/order_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OrderItemDisplay widget tests', () {
    testWidgets('displays zero sandwiches with no emoji', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: OrderItemDisplay(0, 'Footlong Sub')),
        ),
      );

      expect(find.text('0 Footlong Sub sandwich(es): '), findsOneWidget);
    });

    testWidgets('displays three sandwiches with three emojis', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: OrderItemDisplay(3, 'Footlong Sub')),
        ),
      );

      expect(find.text('3 Footlong Sub sandwich(es): 🥪🥪🥪'), findsOneWidget);
    });

    group('App smoke tests', () {
      testWidgets('App displays MenuScreen as home', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(const App());

        expect(find.byType(MenuScreen), findsOneWidget);
        expect(find.text('Sandwich Menu'), findsOneWidget);
      });

      testWidgets('Displays sandwich cards with names and prices', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(const App());

        expect(find.text('Footlong Sub'), findsOneWidget);
        expect(find.text('£7.50'), findsOneWidget);
        expect(find.text('Six-Inch Sub'), findsOneWidget);
        expect(find.text('£4.50'), findsOneWidget);
        expect(find.text('Order'), findsNWidgets(2));
      });

      testWidgets(
        'Tapping Order navigates to OrderScreen with selected sandwich',
        (WidgetTester tester) async {
          await tester.pumpWidget(const App());

          await tester.tap(find.text('Order').first);
          await tester.pumpAndSettle();

          expect(find.byType(OrderScreen), findsOneWidget);
          expect(find.text('Order Footlong Sub'), findsOneWidget);
          expect(find.text('0 Footlong Sub sandwich(es): '), findsOneWidget);

          await tester.tap(find.text('Add'));
          await tester.pump();

          expect(find.text('1 Footlong Sub sandwich(es): 🥪'), findsOneWidget);

          await tester.tap(find.text('Remove'));
          await tester.pump();

          expect(find.text('0 Footlong Sub sandwich(es): '), findsOneWidget);
        },
      );

      testWidgets('OrderScreen quantity does not drop below zero', (
        WidgetTester tester,
      ) async {
        const sandwich = Sandwich(
          id: 'test',
          name: 'Test Sub',
          description: 'Test description',
          price: 5.0,
          imagePath: 'assets/images/footlong.jpeg',
        );

        await tester.pumpWidget(
          const MaterialApp(home: OrderScreen(sandwich: sandwich)),
        );

        await tester.tap(find.text('Remove'));
        await tester.pump();

        expect(find.text('0 Test Sub sandwich(es): '), findsOneWidget);
      });

      testWidgets('OrderScreen quantity does not exceed maxQuantity', (
        WidgetTester tester,
      ) async {
        const sandwich = Sandwich(
          id: 'test',
          name: 'Test Sub',
          description: 'Test description',
          price: 5.0,
          imagePath: 'assets/images/footlong.jpeg',
        );

        await tester.pumpWidget(
          const MaterialApp(
            home: OrderScreen(sandwich: sandwich, maxQuantity: 3),
          ),
        );

        for (int i = 0; i < 5; i++) {
          await tester.tap(find.text('Add'));
          await tester.pump();
        }

        expect(find.text('3 Test Sub sandwich(es): 🥪🥪🥪'), findsOneWidget);
      });
    });
  });
}
