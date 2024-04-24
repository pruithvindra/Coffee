import 'dart:math';

class Category {
  String name;
  String image;
  String description;

  Category({
    required this.name,
    required this.image,
    required this.description,
  });
}


List<Category> generateRandomCategories() {
  List<String> categoryNames = [
    'Coffee',
    'Burgers',
    'Pizza',
    'Salads',
    'Sandwiches',
    'Pasta',
    'Sushi',
    'Tacos',
    'Steak',
    'Seafood',
    
  ];

  List<String> categoryImages = [
    'assets/images/c1.png',
    'assets/images/c4.png',
     'assets/images/c3.png',
    'assets/images/c5.png',
    'assets/images/c6.png',
    'assets/images/c10.png',
     'assets/images/c3.png',
    'assets/images/c8.png',
    'assets/images/c7.png',
    'assets/images/c9.png',
  ];

  List<String> categoryDescriptions = [
     'Indulgent desserts to satisfy your sweet tooth.',
    'Delicious burgers made with premium ingredients.',
    'Authentic Italian pizza with a variety of toppings.',
    'Fresh and healthy salads for every taste.',
    'Classic and gourmet sandwiches for any occasion.',
    'Hearty pasta dishes that will satisfy your cravings.',
    'Exquisite sushi rolls and sashimi selections.',
    'Flavorful tacos with a choice of meats and toppings.',
    'Juicy and tender steaks cooked to perfection.',
    'Fresh seafood dishes inspired by coastal cuisines.',
   
  ];

  Random random = Random();
  List<Category> randomCategories = [];
  for (int i = 0; i < categoryNames.length; i++) {
    Category category = Category(
      name: categoryNames[i],
      image: categoryImages[i],
      description: categoryDescriptions[i],
    );

    randomCategories.add(category);
  }
  return randomCategories;
}
