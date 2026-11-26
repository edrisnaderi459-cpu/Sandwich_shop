import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/screens/menu_screen.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/screens/orders_screens.dart';
import 'package:flutter_app/screens/settings_screen.dart';
import 'package:flutter_app/screens/basket_screen.dart';

bool isSupportedPlatform() {
  if (kIsWeb) {
    return false;
  }
  if (defaultTargetPlatform == TargetPlatform.android) {
    return true;
  }
  return false;
}

void main() {
  if (isSupportedPlatform()) {
    runApp(const MyApp());
  } else {
    runApp(const UnsupportedPlatformApp());
  }
}

class UnsupportedPlatformApp extends StatelessWidget {
  const UnsupportedPlatformApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: shopBrand,
          primary: shopBrand,
        ),
        scaffoldBackgroundColor: shopBackground,
        appBarTheme: const AppBarTheme(
          backgroundColor: shopBrand,
          foregroundColor: shopWhite,
          elevation: 0,
        ),
      ),
      home: const Scaffold(
        body: Center(
          child: Text('This platform is not supported. Please use Android.'),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: shopBrand,
          primary: shopBrand,
        ),
        scaffoldBackgroundColor: shopBackground,
        appBarTheme: const AppBarTheme(
          backgroundColor: shopBrand,
          foregroundColor: shopWhite,
          elevation: 0,
        ),
      ),
            home: const MenuScreen(),
      routes: {
        '/orders': (BuildContext context) {
          return const OrdersScreen();
        },
        '/basket': (BuildContext context) {
          return const BasketScreen();
        },
        '/settings': (BuildContext context) {
          return const SettingsScreen();
        },
      },
    );
  }
}
