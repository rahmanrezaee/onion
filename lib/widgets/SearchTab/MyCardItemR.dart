import 'dart:math';

import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/const/color.dart';

import '../FiveRating.dart';

class MyCardItemR extends StatelessWidget {
  const MyCardItemR({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 5,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 15,
          bottom: 10,
          left: 7,
          right: 7,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: deviceSize(context).width * 0.25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: deviceSize(context).width * 0.2,
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "James H. Matt",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: deviceSize(context).height * 0.01),
                    Text(
                      "PR/Marketing",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: deviceSize(context).height * 0.01),
                    Text(
                      "Joined: 2019",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: deviceSize(context).height * 0.01),
                    Text(
                      "NY Central",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: deviceSize(context).height * 0.02),
                    MyFiveRating(rateVal: 4.5),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: deviceSize(context).width * 0.01,
            ),
            SizedBox(
              width: deviceSize(context).width * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: min(deviceSize(context).height * 0.018, 12),
                      ),
                      decoration: BoxDecoration(
                        color: middlePurple,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          "View Profile",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: Text("Open Chat"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Colors.black),
                    ),
                    color: Colors.transparent,
                    textColor: Colors.black,
                    elevation: 0,
                    onPressed: () {},
                  ),
                  RaisedButton(
                    color: Colors.transparent,
                    elevation: 0,
                    textColor: firstPurple,
                    child: Text("View Rating"),
                    onPressed: () {},
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
