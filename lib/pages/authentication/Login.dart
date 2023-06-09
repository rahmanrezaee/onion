import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onion/models/Image.dart';
import 'package:onion/pages/authentication/ComplateProfile.dart';
import 'package:onion/pages/authentication/ForgetPassword.dart';
import 'package:onion/pages/authentication/sign_with_gmail.dart';
import 'package:onion/pages/authentication/signup.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/widgets/AuthenticationWidget/OvalBottomBorderClipper.dart';
import 'package:onion/widgets/Snanckbar.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onion/models/users.dart' as user;

import 'package:firebase_auth/firebase_auth.dart' as fi;

class Login extends StatefulWidget {
  static String routeName = '/login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  // // google Sign Up

  final GoogleSignIn googleSignIn = GoogleSignIn();

  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isloading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final username = new TextEditingController();
  final passport = new TextEditingController();
  bool _obscureText = true;

  String fcmToken = "";

  StreamSubscription iosSubscription;

  @override
  void dispose() {
    if (iosSubscription != null) iosSubscription.cancel();
    super.dispose();
  }

  @override
  Future<void> initState()  {
    super.initState();
    getFcmToken();
  }

  Future<void> getFcmToken() async {
      if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) async {
        fcmToken = await _fcm.getToken();
        print("firebase token $fcmToken");
      });

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    } else {
      fcmToken = await _fcm.getToken();
      print("firebase token $fcmToken");
    }

    
  }

  @override
  Widget build(context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ConnectivityWidgetWrapper(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              color: Colors.transparent,
            ),
            Positioned(
              top: 0,
              child: ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    gradient: RadialGradient(
                      colors: [
                        Colors.white,
                        Colors.purpleAccent,
                        Colors.purple
                      ],
                      radius: .6,
                      center: Alignment(0, -0.5),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height / 1.7,
                  width: MediaQuery.of(context).size.width,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            Align(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      overflow: Overflow.visible,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                          width: MediaQuery.of(context).size.width / 1.2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(color: Colors.black38, blurRadius: 3)
                            ],
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                SizedBox(height: 70),
                                Text(
                                  "Login Account",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(
                                    color: Colors.purple,
                                  ),
                                  controller: username,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Your Email is empty";
                                    }
                                    if (!value.contains("@"))
                                      return "Your Email not valided";
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0,
                                      horizontal: 10,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black87,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.purple,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 10),
                                TextFormField(
                                  obscureText: _obscureText,
                                  controller: passport,
                                  style: TextStyle(color: Colors.purple),
                                  validator: (value) {
                                    if (value.isEmpty)
                                      return "Your password is empty";
                                  },
                                  decoration: InputDecoration(
                                    suffix: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                      child: _obscureText
                                          ? Icon(Icons.visibility_off)
                                          : Icon(Icons.visibility),
                                    ),
                                    hintText: "Password",
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0,
                                      horizontal: 10,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black87,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.purple,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: FlatButton(
                                    onPressed: () => Navigator.pushNamed(
                                        context, ForgetPassword.routeName),
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(color: Colors.purple),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width: double.infinity,
                                  height: 30,
                                  child: RaisedButton(
                                    color: Theme.of(context).primaryColor,
                                    onPressed: !_isloading ? loginUserDB : null,
                                    child: !_isloading
                                        ? Text(
                                            "Login",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          )
                                        : SizedBox(
                                            height: 15,
                                            width: 15,
                                            child: CircularProgressIndicator(
                                                // strokeWidth: 4,

                                                )),
                                  ),
                                  //  RaisedButton(
                                  //     child: Text("Log In",
                                  //         style: TextStyle(color: Colors.white)),
                                  //     onPressed: () {},
                                  //     color: Colors.purple,
                                  //   ),
                                ),
                                //The OR Divider
                                Row(children: <Widget>[
                                  Expanded(
                                    child: new Container(
                                        child: Divider(
                                      color: Colors.black,
                                      height: 50,
                                    )),
                                  ),
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 3),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.black12,
                                      ),
                                      child: Text("OR")),
                                  Expanded(
                                    child: new Container(
                                        child: Divider(
                                      color: Colors.black,
                                      height: 50,
                                    )),
                                  ),
                                ]),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipOval(
                                      child: Material(
                                        color: Colors.blue, // button color
                                        child: InkWell(
                                          splashColor:
                                              Colors.red, // inkwell color
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            alignment: Alignment.center,
                                            child: _isloadingFacebook
                                                ? SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                            backgroundColor:
                                                                Colors.white))
                                                : FaIcon(
                                                    FontAwesomeIcons.facebookF,
                                                    color: Colors.white,
                                                    size: 18),
                                          ),
                                          onTap: signFacebook,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    ClipOval(
                                      child: Material(
                                        color: Colors.redAccent, // button color
                                        child: InkWell(
                                          splashColor:
                                              Colors.red, // inkwell color
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            alignment: Alignment.center,
                                            child: _isloadingGoogle
                                                ? SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                            backgroundColor:
                                                                Colors.white))
                                                : FaIcon(
                                                    FontAwesomeIcons
                                                        .googlePlusG,
                                                    color: Colors.white,
                                                    size: 18),
                                          ),
                                          onTap: signGoogle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: -60,
                          child: Image.asset(
                            "assets/images/logo.png",
                            width: 130,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 60 - MediaQuery.of(context).viewInsets.bottom,
                child: Column(
                  children: [
                    Text(
                      "Don't have an account?",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () async {
                        if (await ConnectivityWrapper.instance.isConnected) {
                          Navigator.pushNamed(context, SignUp.routeName);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 10),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                              color: Colors.purple),
                        ),
                      ),
                    ),
                  ],
                )),
            Positioned(
              bottom: 0 - MediaQuery.of(context).viewInsets.bottom,
              child: Container(
                height: MediaQuery.of(context).size.height / 15,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.elliptical(300, 100),
                    topRight: Radius.elliptical(300, 100),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isloadingGoogle = false;
  bool _isloadingFacebook = false;

  Future<void> loginUserDB() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    setState(() {
      _isloading = true;
    });
    _formKey.currentState.save();

    try {
      await Provider.of<Auth>(context, listen: false)
          .login(username.text, passport.text, fcmtoken: fcmToken)
          .then(
            (value) => print("I LogIn: $value"),
          );
    } on LoginException catch (e) {
      _scaffoldKey.currentState.showSnackBar(showSnackbar(
          text: e.cause, icon: Icon(Icons.error), color: Colors.red));
      print(e.cause);
    }
    setState(() {
      _isloading = false;
    });
  }

  Future<void> signGoogle() async {
    setState(() {
      _isloadingGoogle = true;
    });
    var auth_provider = Provider.of<Auth>(context, listen: false);
    try {
      String idToken = await signInWithGoogle();
      print("idToken $idToken");
      var response = await auth_provider.loginFirebase(idToken);
      if (response != null && response == "NEW_USER") {
        Navigator.pushNamed(
          context,
          ComplateProfile.routeName,
        );
        // auth_provider.signUpFirebase(idToken);
      }
    } catch (e) {
      print("google Error");
      print(e);
      // _scaffoldKey.currentState
      //     .showSnackBar(showSnackbar(e.cause, Icon(Icons.error), Colors.red));
      // // print(e.cause);
    }
    setState(() {
      _isloadingGoogle = false;
    });
  }

  Future<void> signFacebook() async {
    setState(() {
      _isloadingFacebook = true;
    });
    var auth_provider = Provider.of<Auth>(context, listen: false);

    try {
      Map loginState = await signInWithFacebook();

      print("status $loginState");
      if (loginState['status']) {
        var response = await auth_provider.loginFirebase(loginState['idToken']);
        if (response != null && response == "NEW_USER") {
          Navigator.pushNamed(
            context,
            ComplateProfile.routeName,
          );
          // auth_provider.signUpFirebase(idToken);
        } else {
          // print(e.cause);
        }
      } else {
        _scaffoldKey.currentState.showSnackBar(showSnackbar(
            color: Colors.red,
            icon: Icon(Icons.error),
            text: loginState["message"]));
      }
    } catch (e, s) {
      if (e is FacebookAuthException) {
        print(e.message);
        switch (e.errorCode) {
          case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
            print("You have a previous login operation in progress");
            break;
          case FacebookAuthErrorCode.CANCELLED:
            print("login cancelled");
            break;
          case FacebookAuthErrorCode.FAILED:
            print("login failed");
            break;
        }
      }
    }

    setState(() {
      _isloadingFacebook = false;
    });
  }
}
