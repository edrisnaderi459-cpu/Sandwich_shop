import 'package:flutter/material.dart';
import 'package:flutter_app/models/sandwich.dart';
import 'package:flutter_app/repositories/sandwich_repository.dart';
import 'package:flutter_app/widgets/sandwich_card.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/widgets/basket_button.dart';
import 'package:flutter_app/widgets/settings_button.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<Sandwich> _sandwiches = [];
  bool _loading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadSandwiches();
  }

  Future<void> _loadSandwiches() async {
    try {
      final SandwichRepository repository = SandwichRepository();
      final List<Sandwich> sandwiches = await repository
          .loadSandwichesFromAsset();
      if (!mounted) {
        return;
      }
      setState(() {
        _sandwiches = sandwiches;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _errorMessage = 'Could not load the menu: $error';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget body;

    if (_loading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (_errorMessage.isNotEmpty) {
      body = Center(child: Text(_errorMessage));
    } else {
      body = ListView.builder(
        itemCount: _sandwiches.length,
        itemBuilder: (BuildContext context, int index) {
          return SandwichCard(sandwich: _sandwiches[index]);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: shopHeaderStyle),
        actions: const [SettingsButton(), BasketButton()],
      ),
      body: body,
    );
  }
}
