import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/const/color.dart';
import 'package:onion/widgets/MRaiseButton.dart';
import 'package:onion/widgets/MyLittleAppbar.dart';

class DashboardPage extends StatefulWidget {
  Function openDrawer;

  DashboardPage({Key key, this.openDrawer});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final myController = TextEditingController();
  GlobalKey<FormState> _formKey;

  _formSub(BuildContext context) async {
    print("Mahdi: ${myController.text}");
    if (!_formKey.currentState.validate()) {
      return;
    }

    print("Mahdi:After ${myController.text}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _formKey = null;
    myController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: MyLittleAppbar(
          myTitle: "Dashboard",
          openDrawer: widget.openDrawer,
          hasDrawer: true,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: deviceSize(context).width * 0.02,
          vertical: deviceSize(context).height * 0.06,
        ),
        child: Column(
          children: [
            Divider(color: Colors.grey),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Saved Analysis",
                    textScaleFactor: 1.1,
                    style: TextStyle(color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.add_circle,
                      color: firstPurple,
                      size: deviceSize(context).height * 0.055,
                    ),
                  ),
                ],
              ),
            ),
            MyCardItem(),
            MyCardItem(),
            MyCardItem(),
            Divider(color: Colors.grey),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Search Users by Social",
                    textScaleFactor: 1.1,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Card(
                margin: EdgeInsets.symmetric(
                  vertical: deviceSize(context).height * 0.005,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: deviceSize(context).height * 0.03,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MySocialIcon(myImg: "assets/images/facebook.png"),
                          MySocialIcon(myImg: "assets/images/linkedin.png"),
                          MySocialIcon(myImg: "assets/images/google_plus.png"),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: deviceSize(context).width * 0.05,
                        ),
                        child: TextFormField(
                          controller: myController,
                          textInputAction: TextInputAction.search,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val.isEmpty) {
                              return "خالی است";
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) {
                            return _formSub(context);
                          },
                          decoration: InputDecoration(
                            hintText: "Search Name",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 8.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: deviceSize(context).height * 0.01),
                      MyBtn(
                        txt: "Search Connections",
                        btnWidth: deviceSize(context).width * 0.6,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            MyBtn(
              txt: "Add a Franchise",
              btnWidth: deviceSize(context).width,
            ),
            MyBtn(
              txt: "Post and Idea",
              btnWidth: deviceSize(context).width,
            ),
            InkWell(
              child: Container(
                width: deviceSize(context).width,
                height: deviceSize(context).height * 0.05,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [firstPurple, thirdPurple],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Find User",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyBtn extends StatelessWidget {
  final String txt;
  final double btnWidth;

  const MyBtn({
    Key key,
    this.txt,
    this.btnWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: btnWidth,
      child: RaisedButton(
        elevation: 0,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: firstPurple),
        ),
        child: Text(
          "$txt",
          style: TextStyle(color: firstPurple),
        ),
        onPressed: () {},
      ),
    );
  }
}

class MySocialIcon extends StatelessWidget {
  final String myImg;

  const MySocialIcon({
    Key key,
    this.myImg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: deviceSize(context).height * 0.03,
          right: deviceSize(context).width * 0.04,
        ),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image.asset(myImg, fit: BoxFit.contain),
        ),
      ),
    );
  }
}

class MyCardItem extends StatelessWidget {
  const MyCardItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: deviceSize(context).height * 0.005,
      ),
      child: Stack(
        children: [
          Positioned(
            right: 1,
            top: 1,
            child: Icon(Icons.delete, color: Colors.redAccent),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: deviceSize(context).height * 0.025,
              horizontal: deviceSize(context).width * 0.01,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MyColRow(title: "Category", myTxt: "Lorem ipsum"),
                MyColRow(title: "Region", myTxt: "Lorem"),
                MyColRow(title: "Industry", myTxt: "Dummy"),
                MyColRow(title: "Analysis", myTxt: "Covid-19"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyColRow extends StatelessWidget {
  final String title;
  final String myTxt;

  const MyColRow({
    Key key,
    this.title,
    this.myTxt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: deviceSize(context).width * 0.2,
            maxWidth: deviceSize(context).width * 0.3,
          ),
          child: Text(
            "$title",
            textScaleFactor: 0.9,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: deviceSize(context).height * 0.01),
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: deviceSize(context).width * 0.2,
            maxWidth: deviceSize(context).width * 0.3,
          ),
          child: Text(
            "$myTxt",
            textScaleFactor: 0.9,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
