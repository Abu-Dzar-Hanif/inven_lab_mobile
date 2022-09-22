import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inven_lab/view/Login.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
          return Login();
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: new FooterView(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 200)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child:
                      Image.asset('assets/mlog.png', height: 300, width: 300),
                ),
              ],
            ),
          ],
          footer: new Footer(
            backgroundColor: Colors.white,
            child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Copyright ©2022, Team KKN Institut Global.',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 12.0,
                        color: Color(0xFF162A49)),
                  ),
                ]),
          )),
    );
  }
}
