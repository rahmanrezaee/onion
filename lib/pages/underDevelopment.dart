import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UnderDevelopment extends StatelessWidget {
  final List<String> anim = [
    "assets/anim/app-developer.json",
    // "assets/anim/coding-in-office.json",
    // "assets/anim/programming.json",
    // "assets/anim/working-together.json",
  ];
  @override
  Widget build(BuildContext context) {
    int index = new Random().nextInt(3 - 0);
    return Scaffold(
      appBar: AppBar(
        title: Text("Under Development"),
        centerTitle: true,
      ),
      body: Container(
        child: Lottie.asset(anim[index], fit: BoxFit.cover),
      ),
    );
  }
}
