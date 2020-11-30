import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:onion/pages/franchises/MyTxtDateRef.dart';
import 'package:onion/widgets/Franchise/MyVideoPlayer.dart';
import 'package:onion/widgets/ImageListView.dart';
import 'package:onion/widgets/SearchTab/IndustryCard.dart';

import '../../const/Size.dart';
import '../../const/color.dart';
import '../../const/values.dart';
import '../../widgets/Franchise/Discription.dart';
import '../../widgets/MRaiseButton.dart';
import '../../widgets/MyLittleAppbar.dart';

class ViewMyRequestFranchise extends StatelessWidget {
  static const routeName = "view_my_request_franchise";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: MyLittleAppbar(myTitle: "Requested Franchises"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: deviceSize(context).height * 0.03,
          horizontal: deviceSize(context).width * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "<Franchise Name>",
                  textScaleFactor: 1.1,
                  style: TextStyle(color: firstPurple),
                ),
                Icon(Icons.info_outline, color: firstPurple)
              ],
            ),
            IndustryCard(),
            SizedBox(height: deviceSize(context).height * 0.03),
            Text(
              "Message",
              textScaleFactor: 1.1,
              style: TextStyle(color: Colors.black),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: deviceSize(context).width * 0.38,
                maxWidth: deviceSize(context).width * 0.9,
                minHeight: deviceSize(context).height * 0.2,
                maxHeight: deviceSize(context).height * 0.5,
              ),
              child: AutoSizeText(
                loremIpsum,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: deviceSize(context).height * 0.03),
            Text(
              "Documents",
              textScaleFactor: 1.1,
              style: TextStyle(color: Colors.black),
            ),
            ImageListView(),
            SizedBox(height: deviceSize(context).height * 0.03),
            Text(
              "Descriptive Video",
              textScaleFactor: 1.1,
              style: TextStyle(color: Colors.black),
            ),
            MyVideoPlayer(),
            SizedBox(height: deviceSize(context).height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyTxtDateRef(
                  firstTxt: "Date",
                  secondTxt: "References",
                ),
                MyTxtDateRef(
                  firstTxt: ":25-10-2020",
                  secondTxt: ":John, Carme, Rouge David",
                ),
              ],
            ),
            SizedBox(height: deviceSize(context).height * 0.07),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: deviceSize(context).width * 0.1,
              ),
              child: MRaiseButton(
                mTxtBtn: "Pending",
                isIcon: false,
                mHeight: deviceSize(context).height * 0.05,
                mWidth: deviceSize(context).width,
                mFunc: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
