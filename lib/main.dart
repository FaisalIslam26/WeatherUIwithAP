import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/screen/details.dart';
import 'package:weatherapp/screen/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Weather App",
      // home: HomeScreen(),
      initialRoute: HomeScreen.path,
      routes: {
        HomeScreen.path: (context) => HomeScreen(),
        DetailsScreen.path: (context) => DetailsScreen(),
      },
    );
  }
}
