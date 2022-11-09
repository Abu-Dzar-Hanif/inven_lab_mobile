import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inven_lab/view/Login.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';

class SplashS2 extends StatefulWidget {
  @override
  State<SplashS2> createState() => _SplashS2State();
}

class _SplashS2State extends State<SplashS2> {
  @override
  void initState() {
    super.initState();
    StartScreen();
  }

  StartScreen() {
    var duration = const Duration(seconds: 1);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return Login();
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
                    child: Image.asset('assets/glogo.png',
                        height: 150, fit: BoxFit.contain),
                  ),
                  Text(
                    "INSTITUT GLOBAL",
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
