
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/screens/menu_screen.dart';
import 'package:flutter_app/widgets/sandwich_card.dart';
import 'package:flutter_app/screens/settings_screen.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
setUp(() {
  rootBundle.clear();
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();
});

  testWidgets(
    'MenuScreen shows the sandwich list, settings button and a basket button',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: MenuScreen()));
      await tester.pumpAndSettle();

      expect(find.byType(SandwichCard), findsWidgets);
      expect(find.byIcon(Icons.shopping_basket), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
    },
  );

  testWidgets('Tapping the settings button navigates to SettingsScreen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) {
            return const MenuScreen();
          },
          '/settings': (BuildContext context) {
            return const SettingsScreen();
          },
        },
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pumpAndSettle();

    expect(find.byType(SettingsScreen), findsOneWidget);
  });
}
