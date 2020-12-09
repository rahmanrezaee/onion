import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:onion/models/FranchiesModel.dart';
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

class ViewMyRequestFranchise extends StatefulWidget {
   FranchiesModel franchiesModel;
  ViewMyRequestFranchise(this.franchiesModel);
  static const routeName = "view_my_request_franchise";

  @override
  _ViewMyRequestFranchiseState createState() => _ViewMyRequestFranchiseState();
}

class _ViewMyRequestFranchiseState extends State<ViewMyRequestFranchise> {
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
