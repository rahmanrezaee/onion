import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onion/pages/authentication/ChangePassword.dart';
import 'package:onion/pages/authentication/ForgetPassword.dart';
import 'package:onion/pages/authentication/signup.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/widgets/AuthenticationWidget/OvalBottomBorderClipper.dart';
import 'package:onion/widgets/Snanckbar.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatefulWidget {
  static final routeName = "/forgetPassword";

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isloading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final email = new TextEditingController();

  bool _obscureText = true;

  @override
  Widget build( context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(color: Colors.transparent),
          Positioned(
            top: 0,
            child: ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.purple,
                  gradient: RadialGradient(
                    colors: [Colors.white, Colors.purpleAccent, Colors.purple],
                    radius: .6,
                    center: Alignment(0, -0.5),
                  ),
                ),
                height: MediaQuery.of(context).size.height / 1.7,
                width: MediaQuery.of(context).size.width,
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
                          child: Column(children: [
                            SizedBox(height: 65),
                            Text(
                              "Forget Password",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                color: Colors.purple,
                              ),
                              controller: email,
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

                            SizedBox(height: 15),
                            SizedBox(
                              width: double.infinity,
                              height: 30,
                              child: RaisedButton(
                                color: Theme.of(context).primaryColor,
                                onPressed: !_isloading ? sendEmailVerification : null,
                                // onPressed: loginUserDB ,
                                child: !_isloading
                                    ? Text(
                                        "Send Email Varification",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      )
                                    : SizedBox(
                                        height: 15,
                                        width: 15,
                                        child: CircularProgressIndicator()),
                              ),
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            //The OR Divider
                          ]),
                        ),
                      ),
                      Positioned(
                        top: -110,
                        child: Image.asset(
                          "assets/images/logo.png",
                          width: 170,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
    );
  }

  Future<void> sendEmailVerification() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isloading = true;
    });
    print("hello");
    try {
      var result = await Auth().forgetPassword(email.text);
      Navigator.pushNamed(context, ChangePassword.routeName,
          arguments: {
            "email": email.text,
            "code": result['ForgotKeyit']['keyCode']
          });
    } on LoginException catch (e) {
      _scaffoldKey.currentState
          .showSnackBar(showSnackbar(text:e.cause,icon: Icon(Icons.error),color: Colors.red));
      print(e.cause);
    }
    setState(() {
      _isloading = false;
    });
  }
}
