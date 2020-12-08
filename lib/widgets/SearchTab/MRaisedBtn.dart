import 'package:flutter/material.dart';
import 'package:onion/const/color.dart';

class STRaisedBtn extends StatelessWidget {
  final String txt;

  const STRaisedBtn({
    Key key,
    this.txt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(txt, textScaleFactor: 0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(color: firstPurple),
      ),
      color: Colors.transparent,
      textColor: firstPurple,
      elevation: 0,
      onPressed: () {},
    );
  }
}
