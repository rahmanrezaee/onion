
import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/const/color.dart';

class MyBtn extends StatelessWidget {
  final String txt;
  final double btnWidth;

  const MyBtn({
    Key key,
    this.txt,
    this.btnWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: btnWidth,
      child: RaisedButton(
        elevation: 0,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: firstPurple),
        ),
        child: Text(
          "$txt",
          style: TextStyle(color: firstPurple),
        ),
        onPressed: () {},
      ),
    );
  }
}

class MySocialIcon extends StatelessWidget {
  final Widget myImg;
  final double paddingRight;

  const MySocialIcon({
    Key key,
    this.myImg,
    this.paddingRight = 0.04,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: GestureDetector(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: deviceSize(context).height * 0.03,
            right: deviceSize(context).width * 0.04,
          ),
          child: CircleAvatar(
            
            backgroundColor: Colors.transparent,
            child: myImg,
          ),
        ),
      ),
    );
  }
}
