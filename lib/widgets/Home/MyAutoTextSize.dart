import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../const/Size.dart';

class MyAutoTextSize extends StatelessWidget {
  final String myTxt;
  final Color myColor;

  const MyAutoTextSize({
    Key key,
    this.myTxt,
    this.myColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: deviceSize(context).width * 0.1,
          maxWidth: deviceSize(context).width * 0.6,
          minHeight: deviceSize(context).width * 0.01,
          maxHeight: deviceSize(context).width * 0.04,
        ),
        child: AutoSizeText(
          myTxt,
          textScaleFactor: 1.2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: myColor),
        ),
      ),
    );
  }
}