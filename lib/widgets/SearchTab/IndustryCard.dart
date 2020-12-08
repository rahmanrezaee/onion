import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/const/values.dart';
import 'package:onion/widgets/Franchise/Discription.dart';

import '../MRaiseButton.dart';

class IndustryCard extends StatelessWidget {
  const IndustryCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: deviceSize(context).height * 0.02,
          horizontal: deviceSize(context).width * 0.03,
        ),
        child: Column(
          children: [
            MyTxtRow(
              firstTxt: "Industry",
              secondTxt: "<IndustryName>",
              firstColor: Colors.black,
              isIcon: false,
            ),
            Divider(color: Colors.grey),
            MyTxtRow(
              firstTxt: "Brand",
              secondTxt: "Brand Name",
              firstColor: Colors.black,
              isIcon: false,
            ),
            Divider(color: Colors.grey),
            MyTxtRow(
              firstTxt: "Location",
              secondTxt: "Place/Location",
              firstColor: Colors.black,
              isIcon: false,
            ),
            Divider(color: Colors.grey),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Requirement Details:",
                      textScaleFactor: 1.1,
                      style: TextStyle(color: Colors.black),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: deviceSize(context).width * 0.38,
                        maxWidth: deviceSize(context).width * 0.5,
                        minHeight: deviceSize(context).height * 0.2,
                        maxHeight: deviceSize(context).height * 0.5,
                      ),
                      child: AutoSizeText(
                        loremIpsum,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: deviceSize(context).width * 0.05),
                Column(
                  children: [
                    MRaiseButton(
                      isIcon: false,
                      mTxtBtn: "View Profile",
                      mWidth: deviceSize(context).width * 0.3,
                      mHeight: deviceSize(context).height * 0.055,
                      mFunc: () {
                        print("Mahdi");
                      },
                    ),
                    SizedBox(
                      height: deviceSize(context).height * 0.02,
                    ),
                    SizedBox(
                      width: deviceSize(context).width * 0.3,
                      height: deviceSize(context).height * 0.055,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(color: Colors.grey),
                        ),
                        color: Colors.white,
                        elevation: 0,
                        textColor: Colors.grey,
                        child: Text("Message"),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
