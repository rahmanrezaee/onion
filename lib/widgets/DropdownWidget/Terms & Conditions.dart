import 'dart:ui';

import 'package:flutter/material.dart';

import '../../const/values.dart';
import '../../const/color.dart';

showTermAndConditions(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size(double.infinity, kToolbarHeight),
              child: MyDialogAppBar(),
            ),
            bottomNavigationBar: MyBottomBtn(),
            body: SingleChildScrollView(
              
              padding: EdgeInsets.all(10),
              child: Text(
                lormIpsum,
                textScaleFactor: 1.1,
                style: TextStyle(height: 1.3),
              ),
            ),
          ),
        ),
      );
    },
  );
}

class MyBottomBtn extends StatelessWidget {
  const MyBottomBtn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.zero,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: RaisedButton(
          color: thirdPurple,
          textColor: Colors.white,
          child: Text("OK"),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class MyDialogAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Terms & Conditions",
        textScaleFactor: 0.8,
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[firstPurple, thirdPurple],
          ),
        ),
      ),
      leading: SizedBox.shrink(),
      actions: [
        InkWell(
          child: Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.close, color: Colors.white),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
