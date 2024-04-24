import 'package:coffee/screens/introScreen/intro_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//
int initialPage = 0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
    
        useMaterial3: true,
      ),
      home: const IntroScreen(),
    );
  }
}
