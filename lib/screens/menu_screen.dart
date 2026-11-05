import 'package:flutter/material.dart';
import 'package:flutter_app/models/sandwich.dart';
import 'package:flutter_app/repositories/sandwich_repository.dart';
import 'package:flutter_app/widgets/sandwich_card.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/widgets/basket_button.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SandwichRepository repository = SandwichRepository();
    final List<Sandwich> sandwiches = repository.getSandwiches();

    return Scaffold(
      appBar: AppBar(
        title: const Text( appTitle, style: shopHeaderStyle),
        actions: const [BasketButton()],
      ),
      body: ListView.builder(
        itemCount: sandwiches.length,
        itemBuilder: (BuildContext context, int index) {
          return SandwichCard(sandwich: sandwiches[index]);
        },
      ),
    );
  }
}
