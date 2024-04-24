import 'package:flutter/material.dart';

class Item {
  // Properties
  final String name;
  String subTitle;
  final double price;
  final String imagePath;
  final Color color;

  // Constructor
  Item({
    required this.name,
    required this.color,
    required this.price,
    required this.imagePath,
    this.subTitle = "Frappe",
  });
}