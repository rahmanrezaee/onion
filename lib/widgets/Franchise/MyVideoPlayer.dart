import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';

class MyVideoPlayer extends StatelessWidget {
  const MyVideoPlayer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceSize(context).height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          image: AssetImage("assets/images/document.jpg"),
        ),
      ),
      margin: EdgeInsets.only(
        top: deviceSize(context).height * 0.005,
        bottom: deviceSize(context).height * 0.005,
      ),
    );
  }
}
