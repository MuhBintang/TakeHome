import 'dart:async';
import 'package:flutter/material.dart';
import 'package:takehome/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => BottomNavBar(selectedIndex: 0),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints:
              BoxConstraints.expand(),
            decoration: BoxDecoration(
            color: Color(0xff2596be)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: 
                Image.asset("images/logo.png", height: 350, width: 350,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}