
import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';

class MyEmptyText extends StatelessWidget {
  final String myTxt;
  final Color mColor;

  const MyEmptyText({Key key, this.myTxt, this.mColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(deviceSize(context).width * 0.02),
      decoration: BoxDecoration(
        
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(5),
      ),
      child: SizedBox(
        width: deviceSize(context).width * 0.2,
        child: Text(
          myTxt,
          textScaleFactor: 0.7,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
