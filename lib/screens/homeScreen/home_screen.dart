import 'package:coffee/models/burger.dart';
import 'package:coffee/models/category.dart';
import 'package:coffee/models/coffee.dart';
import 'package:coffee/screens/itemsListScreen/list_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  double screenHeight = 0;
  double screenWidth = 0;
  bool startAnimation = false;
  List<Category> categories = generateRandomCategories();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
         surfaceTintColor: Colors.white,
        elevation: 0,
        title: Text(
          'Menu',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                item(index)
              ],
            );
          }
          return item(index);
        },
      ),
    );
  }

  Widget item(int index) {
    return GestureDetector(
      onTap: () {
        if(index == 0){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ItemPageView(itemList: createCoffeeInstances(),);
        }));
        } if(index == 1){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ItemPageView(itemList: createBurgerInstances());
        }));
        }
      
      },
      child: AnimatedContainer(
        width: screenWidth,
        curve: Curves.easeInOut,
         margin: EdgeInsets.all(20),
        duration: Duration(milliseconds: 300 + (index * 200)),
           decoration: BoxDecoration(
             borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Colors.white,
                boxShadow: [ BoxShadow(
          color: Colors.grey.withOpacity(0.15),
          offset: Offset(0, 10),
          blurRadius: 10,

          spreadRadius: 1,
        ),]
              ),
        transform:
            Matrix4.translationValues(startAnimation ? 0 : screenWidth, 0, 0),
       // margin: EdgeInsets.symmetric(vertical: 20),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              margin: EdgeInsets.only(left: 100),
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    categories[index].name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    categories[index].description,
                    style:  TextStyle(
                      fontSize: 12,
                      color: Colors.grey.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              top: -10,
              child: Container(
                width: 100,
                child: Image.asset(
                  height: 100,
                  categories[index].image,
                  fit: BoxFit.fitHeight,
                ),
              ),
            )
          ],
        ),
      ),
    );

    return AnimatedContainer(
      width: screenWidth,
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 300 + (index * 200)),
      transform:
          Matrix4.translationValues(startAnimation ? 0 : screenWidth, 0, 0),
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth / 20,
      ),
      child: Container(
        color: Colors.red,
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 100,
                  height: 200,
                  child: Image.asset(
                    categories[index].image,
                  ),
                )
              ],
            ),
            Text(
              categories[index].name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
