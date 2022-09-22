import 'package:flutter/material.dart';
import 'package:inven_lab/SplashScreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.deepOrangeAccent),
    // home: SearchTeknisi(),
    home: SplashScreen(),
  ));
}
