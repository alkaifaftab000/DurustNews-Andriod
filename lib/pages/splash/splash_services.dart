import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news_app/pages/home_screen.dart';

class SplashService{
  void isUserLoggedIn(BuildContext context){
    Timer(const Duration(seconds: 7), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }
}