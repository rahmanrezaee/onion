import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';

class MyTxtDateRef extends StatelessWidget {
  final String firstTxt;
  final String secondTxt;

  const MyTxtDateRef({
    Key key,
    this.firstTxt,
    this.secondTxt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          firstTxt,
          style: TextStyle(color: Colors.black),
        ),
        SizedBox(height: deviceSize(context).height * 0.05),
        Text(
          secondTxt,
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}
