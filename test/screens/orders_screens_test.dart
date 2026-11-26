
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/database/sandwich_db.dart';
import 'package:flutter_app/models/order_record.dart';
import 'package:flutter_app/screens/orders_screens.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUp(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    final Database database = await databaseFactoryFfi.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: SandwichDatabase.instance.createTables,
      ),
    );

    SandwichDatabase.instance.setDatabase(database);
  });

  tearDown(() async {
    await SandwichDatabase.instance.close();
  });

  testWidgets('OrdersScreen lists saved orders newest-first', (
    WidgetTester tester,
  ) async {
    await tester.runAsync(() async {
      await SandwichDatabase.instance.insertOrder(
        const OrderRecord(
          orderNumber: 1001,
          summary: '1 x Six-Inch Sub',
          total: 4.50,
          date: '01/01/2026 10:00',
        ),
      );

      await SandwichDatabase.instance.insertOrder(
        const OrderRecord(
          orderNumber: 1002,
          summary: '2 x Footlong Sub',
          total: 15.00,
          date: '02/01/2026 11:00',
        ),
      );
    });

    await tester.pumpWidget(const MaterialApp(home: OrdersScreen()));
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Order #1002'), findsOneWidget);
    expect(find.text('Order #1001'), findsOneWidget);
    expect(find.text('2 x Footlong Sub'), findsOneWidget);

    final double newestY =
        tester.getTopLeft(find.text('Order #1002')).dy;
    final double oldestY =
        tester.getTopLeft(find.text('Order #1001')).dy;

    expect(newestY, lessThan(oldestY));
  });

  testWidgets('OrdersScreen shows an empty state when there are no orders', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: OrdersScreen()));
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('No orders yet'), findsOneWidget);
  });
}
