import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UnderDevelopment extends StatelessWidget {


  final List<String> anim = [
    "assets/anim/app-developer.json",
  ];
  @override
  Widget build(BuildContext context) {
    int index = new Random().nextInt(3 - 0);
    return Scaffold(
      appBar: AppBar(
        title: Text("Under Development"),
        centerTitle: true,
<<<<<<< HEAD
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
=======
        
>>>>>>> f86cda950c9eb7ac998d6c6369b10b12348921ec
      ),
      body: Container(
        child: Lottie.asset(anim[0], fit: BoxFit.cover),
      ),
    );
  }
}
