import 'dart:developer';

import 'package:coffee/screens/homeScreen/home_screen.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    bool isForward = true;
    controller.addListener(() {
      log("hiii ${controller.status} -- ${controller.isCompleted} -- ${controller.isDismissed}");
      if (controller.isCompleted || controller.isDismissed ) {
        if (isForward) {
          isForward = false;
          controller.reverse();
        } else {
          isForward = true;
          controller.forward();
        }
      }
    });

    _animation = Tween<double>(begin: 0.0, end: 20.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInCubic));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe49e32),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 400,
              child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, _) {
                    return Stack(
                      children: [
                        Positioned(
                          top: _animation.value,
                          left: 0,
                          right: 0,
                          child: Image.asset(
                            'assets/images/donut.png',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            Text(
              'Enjoy your craving',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Savor the essence of culinary delight with our delectable array of dishes!',
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    "Register or Log in",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Home();
                }));
              },
              child: Container(
                decoration: BoxDecoration(
                    // color: Colors.white,

                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Text(
                      "Continue as Guest",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
