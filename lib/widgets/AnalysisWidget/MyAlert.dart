import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';

class MyAlertIcon extends StatefulWidget {
  final int num;

  const MyAlertIcon({Key key, this.num});

  @override
  _MyAlertIconState createState() => _MyAlertIconState();
}

class _MyAlertIconState extends State<MyAlertIcon> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        ),
        Positioned(
          right: 1,
          top: 1,
          child: Container(
            height: deviceSize(context).height * 0.02,
            width: deviceSize(context).height * 0.02,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(
                deviceSize(context).height * 0.01,
              ),
            ),
            child: Center(
              child: Text(
                "${widget.num}",
                textScaleFactor: 0.7,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
