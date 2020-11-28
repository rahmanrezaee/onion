import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/const/color.dart';
import 'package:onion/widgets/FiveRating.dart';
import 'package:onion/widgets/MyAppBar.dart';
import 'package:onion/widgets/MyLittleAppbar.dart';

import '../DashboardPage.dart';

class SearchTab extends StatelessWidget {
  Function openDrawer;

  SearchTab({openDrawer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Find Connections", openDrawer: openDrawer),
      body: Column(
        children: [
          Container(
            height: deviceSize(context).height * 0.16,
            padding: EdgeInsets.only(
              left: deviceSize(context).width * 0.04,
              right: deviceSize(context).width * 0.04,
              top: deviceSize(context).width * 0.06,
            ),
            decoration: BoxDecoration(
              color: middlePurple,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(
                  deviceSize(context).height * 0.04,
                ),
                bottomLeft: Radius.circular(
                  deviceSize(context).height * 0.04,
                ),
              ),
            ),
            child: TextField(
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(20.0),
                  ),
                ),
                contentPadding: EdgeInsets.all(2),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey),
                hintText: "Searched Keyword",
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 15),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    STRaisedBtn(txt: "Innovators"),
                    STRaisedBtn(txt: "Service Provider"),
                    STRaisedBtn(txt: "Investors"),
                  ],
                ),
                SizedBox(height: deviceSize(context).height * 0.01),
                Text(
                  "Recommendation for search",
                  textScaleFactor: 1.1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 7,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          height: deviceSize(context).height * 0.18,
                          width: deviceSize(context).width * 0.25,
                          child: Column(
                            children: [
                              Container(
                                height: deviceSize(context).height * 0.09,
                                width: deviceSize(context).width * 0.2,
                                child: SizedBox(
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                      "assets/images/empty_profile.jpg",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: deviceSize(context).height * 0.02,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: GestureDetector(
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        child: Image.asset(
                                          "assets/images/google_plus.png",
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: GestureDetector(
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        child: Image.asset(
                                          "assets/images/facebook.png",
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: deviceSize(context).width * 0.01,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: deviceSize(context).height * 0.18,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "James H. Matt",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  "PR/Marketing",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "Joined: 2019",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "NY Central",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                MyFiveRating(rateVal: 4),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: deviceSize(context).width * 0.01,
                        ),
                        Column(
                          children: [
                            RaisedButton(
                              color: middlePurple,
                              textColor: Colors.white,
                              child: Text("View Profile"),
                              elevation: 0,
                              onPressed: () {},
                            ),
                            RaisedButton(
                              child: Text("Open Chat", textScaleFactor: 0.9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Colors.black),
                              ),
                              color: Colors.transparent,
                              textColor: Colors.black,
                              elevation: 0,
                              onPressed: () {},
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

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
