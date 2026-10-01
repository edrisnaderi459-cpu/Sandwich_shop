import 'package:flutter_app/models/sandwich.dart';

class SandwichRepository {
  List<Sandwich> getSandwiches() {
    return const [
      Sandwich(
        id: 'footlong',
        name: 'Footlong sub',
        description: 'A freshly baked 12 inch sandwich filled with savoury indgredients.',
        price: 7.50,
        imagePath: 'assets/images/footlong.png',
      ),
      Sandwich(
        id: 'six-inch',
        name: 'Six inch sub',
        description: 'A freshly baked 6 inch sandwich made with your indgredients.',
        price: 4.50,
        imagePath: 'assets/images/six-inch.png',
      )

    ];
    
  }
}