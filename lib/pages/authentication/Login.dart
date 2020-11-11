import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onion/pages/authentication/ForgetPassword.dart';
import 'package:onion/pages/authentication/signup.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/widgets/AuthenticationWidget/OvalBottomBorderClipper.dart';
import 'package:onion/widgets/Snanckbar.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static String routeName = '/login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isloading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final username = new TextEditingController();
  final passport = new TextEditingController();
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
                          child: Column(
                            children: [
                              SizedBox(height: 65),
                              Text(
                                "Login Account",
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

                              SizedBox(height: 15),
                              TextFormField(
                                obscureText: _obscureText,
                                controller: passport,
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
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: FlatButton(
                                  onPressed: ()=> Navigator.pushNamed(context, ForgetPassword.routeName),
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
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
                                          child: FaIcon(
                                              FontAwesomeIcons.facebookF,
                                              color: Colors.white,
                                              size: 18),
                                        ),
                                        onTap: () {},
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
                                          child: FaIcon(
                                              FontAwesomeIcons.googlePlusG,
                                              color: Colors.white,
                                              size: 18),
                                        ),
                                        onTap: () {},
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 25),
                            ],
                          ),
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
              bottom: 60 - MediaQuery.of(context).viewInsets.bottom,
              child: Column(
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  FlatButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, SignUp.routeName),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          color: Colors.purple),
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
    );
  }

  Future<void> loginUserDB() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isloading = true;
    });

    try {
      await Provider.of<Auth>(context, listen: false)
          .login(username.text, passport.text);
    } on LoginException catch (e) {
      _scaffoldKey.currentState
          .showSnackBar(showSnackbar(e.cause, Icon(Icons.error), Colors.red));
      print(e.cause);
    }
    setState(() {
      _isloading = false;
    });
  }
}
