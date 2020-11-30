import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/const/color.dart';
import 'package:onion/widgets/FiveRating.dart';
import 'package:onion/widgets/MyLittleAppbar.dart';

import '../DashboardPage.dart';

class MyProfile extends StatefulWidget {
  static const routeName = "my_profile";

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final _formKey = GlobalKey<FormState>();
  String _currency;
  FocusNode emailFocus;
  FocusNode occupFocus;
  FocusNode industryFocus;
  bool _autoValidate = false;
  var _currencies = [
    "Food",
    "Transport",
  ];

  _formSubmit() {
    if (!_formKey.currentState.validate()) {
      _autoValidate = true;
      return;
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null)
      return 'Enter a valid email address';
    else
      return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailFocus = FocusNode();
    occupFocus = FocusNode();
    industryFocus = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailFocus.dispose();
    occupFocus.dispose();
    industryFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: MyLittleAppbar(
          hasDrawer: false,
          myTitle: "My Profile",
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Investor",
              textScaleFactor: 1.1,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 7),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    autovalidate: _autoValidate,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: deviceSize(context).width * 0.2,
                              width: deviceSize(context).width * 0.2,
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                  "assets/images/empty_profile.jpg",
                                ),
                                foregroundColor: firstPurple,
                              ),
                            ),
                            Positioned(
                              child: Container(
                                height: deviceSize(context).height * 0.04,
                                width: deviceSize(context).height * 0.04,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: middlePurple,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    deviceSize(context).height * 0.02,
                                  ),
                                ),
                                child: Icon(
                                  Icons.photo_camera_outlined,
                                  size: deviceSize(context).height * 0.025,
                                  color: Colors.grey,
                                ),
                              ),
                              bottom: 1,
                              right: 1,
                            ),
                          ],
                        ),
                        SizedBox(height: deviceSize(context).height * 0.03),
                        SizedBox(
                          width: deviceSize(context).width * 0.7,
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            onFieldSubmitted: (_) {
                              emailFocus.requestFocus();
                            },
                            textInputAction: TextInputAction.next,
                            validator: (_val) {
                              if (_val.isEmpty) {
                                return "Enter valid name";
                              } else if (_val.length < 2) {
                                return "Enter valid name";
                              }
                              return null;
                            },
                            decoration: myInput("Name"),
                          ),
                        ),
                        SizedBox(height: deviceSize(context).height * 0.01),
                        SizedBox(
                          width: deviceSize(context).width * 0.7,
                          child: TextFormField(
                            focusNode: emailFocus,
                            onFieldSubmitted: (_) {
                              occupFocus.requestFocus();
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            validator: validateEmail,
                            decoration: myInput("Email"),
                          ),
                        ),
                        SizedBox(height: deviceSize(context).height * 0.01),
                        SizedBox(
                          width: deviceSize(context).width * 0.7,
                          child: TextFormField(
                            focusNode: occupFocus,
                            onFieldSubmitted: (_) {
                              industryFocus.requestFocus();
                            },
                            textInputAction: TextInputAction.next,
                            validator: (_val) {
                              if (_val.isEmpty) {
                                return "Enter valid Occupation";
                              }
                              return null;
                            },
                            decoration: myInput("Occupation"),
                          ),
                        ),
                        SizedBox(height: deviceSize(context).height * 0.01),
                        SizedBox(
                          width: deviceSize(context).width * 0.7,
                          child: DropdownButtonFormField(
                            focusNode: industryFocus,
                            value: _currency,
                            validator: (value) =>
                                value == null ? 'field required' : null,
                            // validator: (_val) {
                            //   if (_val.isEmpty) {
                            //     return "Pick valid Industry";
                            //   }
                            //   return null;
                            // },
                            items: _currencies.map((String category) {
                              return new DropdownMenuItem(
                                value: category,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      category,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() => _currency = newValue);
                            },
                            decoration: myInput("Industry Interested"),
                          ),
                        ),
                        SizedBox(height: deviceSize(context).height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MySocialIcon(
                              myImg: "assets/images/facebook.png",
                            ),
                            MySocialIcon(
                              myImg: "assets/images/linkedin.png",
                            ),
                            MySocialIcon(
                              myImg: "assets/images/google_plus.png",
                            ),
                          ],
                        ),
                        SizedBox(
                          width: deviceSize(context).width * 1,
                          child: Container(
                            child: Text(
                              "Business Profile",
                              textScaleFactor: 1.2,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyRaisedBtn(txt: "Innovator"),
                            MyRaisedBtn(txt: "Service Provider"),
                            MyRaisedBtn(txt: "Investor"),
                          ],
                        ),
                        Row(
                          children: [
                            MyFiveRating(rateVal: 4),
                            SizedBox(width: deviceSize(context).width * 0.01),
                            Text(
                              "View Rating",
                              style: TextStyle(
                                color: firstPurple,
                                decoration: TextDecoration.underline,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: deviceSize(context).width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: RaisedButton(
                              elevation: 0,
                              color: middlePurple,
                              child: Text("Edit/Save"),
                              textColor: Colors.white,
                              onPressed: _formSubmit,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyRaisedBtn extends StatelessWidget {
  final String txt;

  const MyRaisedBtn({
    Key key,
    this.txt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(txt),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        side: BorderSide(color: firstPurple),
      ),
      color: Colors.transparent,
      textColor: firstPurple,
      elevation: 0,
      onPressed: () {},
    );
  }
}

InputDecoration myInput(String hint) {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 2,
    ),
    border: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        const Radius.circular(5.0),
      ),
      borderSide: BorderSide(
        color: Colors.grey.shade50,
      ),
    ),
    filled: true,
    fillColor: Colors.white,
    hintStyle: new TextStyle(color: Colors.grey),
    hintText: "$hint",
  );
}
