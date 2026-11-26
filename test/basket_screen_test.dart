import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/models/cart_item.dart';
import 'package:flutter_app/models/sandwich.dart';
import 'package:flutter_app/repositories/cart_repository.dart';
import 'package:flutter_app/screens/basket_screen.dart';

const Sandwich testSandwich = Sandwich(
  id: 'footlong',
  name: 'Footlong Sub',
  description: 'Classic freshly baked sub.',
  price: 10.0,
  imagePath: 'assets/images/footlong.jpeg',
);

void main() {
  setUp(() {
    CartRepository.instance.clear();

    testWidgets(
      'BasketScreen displays empty message when basket has no items',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: BasketScreen()));

        expect(find.text('Your basket is empty'), findsOneWidget);
        expect(find.text('Checkout'), findsNothing);
      },
    );

    testWidgets(
    'BasketScreen renders items and removes item when delete pressed',
    (WidgetTester tester) async {
      const CartItem item = CartItem(
        sandwich: testSandwich,
        quantity: 2,
      );
      CartRepository.instance.addItem(item);

      await tester.pumpWidget(const MaterialApp(home: BasketScreen()));

      expect(find.text('Your basket'), findsOneWidget);
      expect(find.text('2 x Footlong Sub'), findsOneWidget);
      expect(find.text('£20.00'), findsWidgets);
      expect(find.text('Checkout'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pump();

      expect(find.text('Your basket is empty'), findsOneWidget);
    },
  );

  });
}
