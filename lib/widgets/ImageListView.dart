import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';

class ImageListView extends StatelessWidget {
  const ImageListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: deviceSize(context).height * 0.13,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          MyImageList(),
          MyImageList(),
          MyImageList(),
          MyImageList(),
          MyImageList(),
          MyImageList(),
        ],
      ),
    );
  }
}

class MyImageList extends StatelessWidget {
  const MyImageList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceSize(context).height * 0.13,
      width: deviceSize(context).height * 0.13,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          image: AssetImage("assets/images/document.jpg"),
        ),
      ),
      margin: EdgeInsets.only(
        top: deviceSize(context).height * 0.005,
        bottom: deviceSize(context).height * 0.005,
        right: deviceSize(context).width * 0.02,
      ),
    );
  }
}
