
import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/const/color.dart';

class ListImage extends StatelessWidget {
  const ListImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: deviceSize(context).width * 0.03,
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/document.jpg",
            height: deviceSize(context).height * 0.1,
            width: deviceSize(context).height * 0.1,
          ),
          SizedBox(width: deviceSize(context).width * 0.02),
          Image.asset(
            "assets/images/document.jpg",
            height: deviceSize(context).height * 0.1,
            width: deviceSize(context).height * 0.1,
          ),
          SizedBox(width: deviceSize(context).width * 0.02),
          InkWell(
            onTap: () {},
            child: Icon(
              Icons.add_circle,
              size: deviceSize(context).height * 0.05,
              color: firstPurple,
            ),
          )
        ],
      ),
    );
  }
}
