import 'dart:math';

import 'package:coffee/models/item.dart';
import 'package:flutter/material.dart';

class Coffee  extends Item{
  // Properties
  final String name;
  String subTitle;
  final double price;
  final String imagePath;
  final Color color;

  // Constructor
  Coffee({
    required this.name,
    required this.color,
    required this.price,
    required this.imagePath,
    this.subTitle = "Frappe",
  }): super(name : name, subTitle:subTitle , price: price, imagePath:imagePath, color: color);
}

// Function to create 12 instances of the Coffee class with random prices
List<Coffee> createCoffeeInstances() {
  // List of coffee names
  List<String> coffeeNames = [
    'Mocha',
    'Caramel',
    'Vanilla',
    'Hazelnut',
    'Matcha',
    'Coconut',
    'Chai',
    'Cookies and Cream',
    'Peanut Butter',
    'Pumpkin Spice',
  ];
  List<Color> randomColors = [
    Color.fromRGBO(255, 0, 0, 1.0), // Red
    Color.fromRGBO(0, 255, 0, 1.0), // Green
    Color.fromRGBO(0, 0, 255, 1.0), // Blue
    Color.fromRGBO(255, 255, 0, 1.0), // Yellow
    Color.fromRGBO(255, 0, 255, 1.0), // Magenta
    Color.fromRGBO(0, 255, 255, 1.0), // Cyan
    Color.fromRGBO(255, 128, 0, 1.0), // Orange
    Color.fromRGBO(128, 0, 255, 1.0), // Purple
    Color.fromRGBO(0, 128, 255, 1.0), // Light Blue
    Color.fromRGBO(128, 128, 128, 1.0), // Gray
  ];
  List<double> randomPrices = [
    120.50,
    150.25,
    180.75,
    99.99,
    199.00,
    105.80,
    130.45,
    175.60,
    145.90,
    160.35,
  ];

  // Random number generator
  Random random = Random();

  // List to store coffee instances
  List<Coffee> coffeeList = [];

  // Create instances of Coffee class with random prices
  for (int i = 0; i < coffeeNames.length; i++) {
    // Generate a random price between $4.00 and $6.00
    double randomPrice = 4.00 + random.nextDouble() * 2.00;

    // Create a new Coffee instance with the random price
    coffeeList.add(
      Coffee(
        name: coffeeNames[i],
        color:randomColors[i],
        price: randomPrices[i],
        imagePath:
            'assets/images/${i}.png', // Same image path for all instances
      ),
    );
  }

  // Return the list of coffee instances
  return coffeeList;
}

// void main() {
//   // Create instances of Coffee class with random prices
//   List<Coffee> coffeeInstances = createCoffeeInstances();

//   // Print details of each coffee instance
//   for (Coffee coffee in coffeeInstances) {
//     print(
//         'Name: ${coffee.name}, Price: \$${coffee.price.toStringAsFixed(2)}, Image: ${coffee.imagePath}');
//   }
// }
