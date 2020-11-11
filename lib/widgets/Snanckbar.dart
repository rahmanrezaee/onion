import 'package:flutter/material.dart';

Widget showSnackbar(String text,Icon icon,Color color){
 return new SnackBar(
          backgroundColor: color,
          content: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                text,
                style: TextStyle(fontFamily: "Vazir"),
              ),
              icon
            ],
          ),
          duration: Duration(seconds: 2),
        );
}