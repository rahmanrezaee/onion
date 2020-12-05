import 'package:flutter/material.dart';
import 'package:onion/pages/authentication/Login.dart';
import 'package:onion/pages/authentication/signup.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/widgets/AuthenticationWidget/OvalBottomBorderClipper.dart';
import 'package:onion/widgets/Snanckbar.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  static final routeName = "/ChangePassword";

  Map data;
  ChangePassword(this.data);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isloading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final verifyCode = new TextEditingController();
  final newPassword = new TextEditingController();
  final confirmPassword = new TextEditingController();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
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
                              "Verify Code",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: verifyCode,
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.purple),
                              validator: (value) {
                                if (value.isEmpty)
                                  return "Your Verify Code is empty";
                              },
                              decoration: InputDecoration(
                                hintText: "Verify Code",
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
                            SizedBox(height: 15),
                            TextFormField(
                              obscureText: _obscureText,
                              controller: newPassword,
                              style: TextStyle(color: Colors.purple),
                              validator: (value) {
                                if (value.isEmpty)
                                  return "Your password is empty";
                              },
                              decoration: InputDecoration(
                                suffix: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  icon: _obscureText
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                ),
                                hintText: "New Password",
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
                            SizedBox(height: 15),
                            TextFormField(
                              obscureText: _obscureText,
                              controller: confirmPassword,
                              style: TextStyle(color: Colors.purple),
                              validator: (value) {
                                if (value.isEmpty)
                                  return "Your Confirm is empty";
                                if (value != newPassword.text)
                                  return "Your Password not same";
                              },
                              decoration: InputDecoration(
                                suffix: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  icon: _obscureText
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                ),
                                hintText: "Confirm Password",
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

                            SizedBox(height: 15),
                            SizedBox(
                              width: double.infinity,
                              height: 30,
                              child: RaisedButton(
                                color: Theme.of(context).primaryColor,
                                onPressed: !_isloading ? changePassword : null,
                                child: !_isloading
                                    ? Text(
                                        "Change Password",
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

  Future<void> changePassword() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isloading = true;
    });

    try {
      if (widget.data['code'] == verifyCode.text) {
        await Auth().changePassword(
            email: widget.data["email"],
            password: newPassword.text,
            code: verifyCode.text);
        Navigator.pushReplacementNamed(context, Login.routeName);
      
      }
    } on LoginException catch (e) {
      _scaffoldKey.currentState
          .showSnackBar(showSnackbar(text:e.cause, icon:Icon(Icons.error),color: Colors.red));
      print(e.cause);
    }
    setState(() {
      _isloading = false;
    });
  }
}
