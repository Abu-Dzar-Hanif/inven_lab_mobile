import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'dart:async';
import 'package:inven_lab/SplashS2.dart';

class Splash1 extends StatefulWidget {
  const Splash1({Key? key}) : super(key: key);

  @override
  State<Splash1> createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> {
  @override
  void initState() {
    super.initState();
    StartScreen();
  }

  StartScreen() {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return SplashS2();
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FooterView(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 200),
              child: Column(
                children: [
                  Center(
                    child: Image.asset('assets/logo.png',
                        height: 150, fit: BoxFit.contain),
                  ),
                  Text(
                    "SMK PANCA KARYA TANGERANG",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          )
        ],
        footer: Footer(
          padding: EdgeInsets.only(bottom: 50),
          backgroundColor: Colors.white,
          child: Text(
            'Copyright ©2022, Team KKN Institut Global.',
            style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12.0,
                color: Color(0xFF162A49)),
          ),
        ),
      ),
    );
  }
}
