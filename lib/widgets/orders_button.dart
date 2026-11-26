import 'package:flutter/material.dart';

class OrdersButton extends StatelessWidget {
  const OrdersButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.receipt_long),
      onPressed: () {
        final ModalRoute<dynamic>? modalRoute = ModalRoute.of(context);
        String currentRoute = '';

        if (modalRoute != null) {
          final RouteSettings settings = modalRoute.settings;
          final String? routeName = settings.name;

          if (routeName != null) {
            currentRoute = routeName;
          }
        }

        if (currentRoute != '/orders') {
          Navigator.pushNamed(context, '/orders');
        }
      },
    );
  }
}
