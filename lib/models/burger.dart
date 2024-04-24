
import 'dart:math';

import 'package:coffee/models/item.dart';
import 'package:flutter/material.dart';

class Burger extends Item {
  Burger({
    required String name,
    required Color color,
    required double price,
    required String imagePath,
  }) : super(
          name: name,
          color: color,
          price: price,
          imagePath: imagePath,
          subTitle: "Burger",
        );

// Function to create 12 instances of the Coffee class with random prices

}


List<Burger> createBurgerInstances() {
  // List of coffee names
  List<String> burgerNames = [
     'Classic',
      'Cheese',
      'Bacon',
      'Veggie',
      'Chicken',
      'Mushroom Swiss',
      'BBQ',
      'Teriyaki',
      'Western',
      'Black Bean',
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
  List<Burger> burgerList = [];

  // Create instances of Coffee class with random prices
  for (int i = 0; i < burgerNames.length; i++) {
    // Generate a random price between $4.00 and $6.00
    double randomPrice = 4.00 + random.nextDouble() * 2.00;

    // Create a new Coffee instance with the random price
    burgerList.add(
      Burger(
        name: burgerNames[i],
        color:randomColors[i],
        price: randomPrices[i],
        imagePath:
            'assets/images/b${i}.png', // Same image path for all instances
      ),
    );
  }

  // Return the list of coffee instances
  return burgerList;
}
  // Generate a list of 10 random burger names
   List<String> generateRandomNames() {
    List<String> burgerNames = [
      'Classic',
      'Cheese',
      'Bacon',
      'Veggie',
      'Chicken',
      'Mushroom Swiss',
      'BBQ',
      'Teriyaki',
      'Western',
      'Black Bean',
    ];
    List<String> randomBurgerNames = [];

    // Shuffle the burger names list
    burgerNames.shuffle();

    // Select the first 10 names from the shuffled list
    randomBurgerNames = burgerNames.sublist(0, 10);

    return randomBurgerNames;
  }