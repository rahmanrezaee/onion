import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onion/const/color.dart';
import 'package:onion/models/users.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/widgets/AuthenticationWidget/OvalBottomBorderClipper.dart';
import 'package:onion/widgets/Checkbox/GlowCheckbox.dart';
import 'package:onion/widgets/DropdownWidget/DropDownFormField.dart';
import 'package:onion/widgets/Snanckbar.dart';
import 'package:onion/widgets/T&C_widget.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class SignUp extends StatefulWidget {
  static String routeName = '/signup';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  User user = new User();

  bool checkboxSelected = false;
  bool switchSelected = false;
  bool radioSelected = false;
  bool iconSelected = false;
  bool _isLoading = false;
  bool _obscureText = true;
  PlatformFile profileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
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
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
                          SizedBox(height: 25),
                          Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () async {
                              FilePickerResult result = await FilePicker
                                  .platform
                                  .pickFiles(type: FileType.image);
                              setState(() {
                                profileImage = result.files.first;
                              });
                            },
                            child: new Container(
                              width: 50,
                              height: 50,
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    new Radius.circular(50.0)),
                                border: new Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 4.0,
                                ),
                              ),
                              child: profileImage != null
                                  ? Image.memory(profileImage.bytes)
                                  : Image.asset("assets/images/user.png"),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Your name is empty";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              user.name = value;
                            },
                            decoration: InputDecoration(
                              hintText: "Name",
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
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              color: Colors.purple,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Your Email is empty";
                              }
                              if (!value.contains("@"))
                                return "Your Email not valided";
                            },
                            onSaved: (value) {
                              user.email = value;
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
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                              color: Colors.purple,
                            ),
                            validator: (String value) {
                              // if (value.isEmpty) return "Your phone is empty";
                              if (isValidPhoneNumber(value)) {
                                return null;
                              } else {
                                return "You phone number is not valid!";
                              }
                            },
                            onSaved: (value) {
                              user.phone = value;
                            },
                            decoration: InputDecoration(
                              hintText: "Phone Number",
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
                            style: TextStyle(color: Colors.purple),
                            validator: (value) {
                              if (value.isEmpty)
                                return "Your password is empty";
                            },
                            onSaved: (value) {
                              user.password = value;
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
                          TextFormField(
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                              color: Colors.purple,
                            ),
                            validator: (value) {
                              if (value.isEmpty)
                                return "Your Occupation is empty";
                            },
                            onSaved: (value) {
                              user.occupation = value;
                            },
                            decoration: InputDecoration(
                              hintText: "Occupation",
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
                          DropDownFormField(
                            onChanged: (value) {
                              setState(() {
                                user.interst = value;
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                              });
                            },
                            value: user.interst != null ? user.interst : "none",
                            onSaved: (value) {
                              setState(() {
                                user.interst = value;
                              });
                            },
                            dataSource: [
                              {
                                "display": 'Category Interested',
                                "value": 'none'
                              },
                              {"display": 'Technalogy', "value": 'tach'},
                              {"display": 'Learing', "value": 'learing'},
                            ],
                            textField: 'display',
                            valueField: 'value',
                          ),

                          SizedBox(height: 10),

                          DropDownFormField(
                            value: user.country != null ? user.country : "none",
                            onChanged: (value) {
                              setState(() {
                                user.country = value;
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                              });
                            },
                            onSaved: (value) {
                              setState(() {
                                user.country = value;
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                              });
                            },
                            dataSource: [
                              {"display": 'Country', "value": 'none'},
                              {"display": 'Afghanistan', "value": 'afg'},
                              {"display": 'USA', "value": 'usa'},
                            ],
                            textField: 'display',
                            valueField: 'value',
                          ),

                          SizedBox(height: 10),
                          DropDownFormField(
                            value: user.state != null ? user.state : "none",
                            onSaved: (value) {
                              setState(() {
                                user.state = value;
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                user.state = value;
                              });
                            },
                            dataSource: [
                              {"display": 'State', "value": 'none'},
                              {"display": 'New York', "value": 'newyouk'},
                            ],
                            textField: 'display',
                            valueField: 'value',
                          ),

                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GlowCheckbox(
                                color: Theme.of(context).primaryColor,
                                value: checkboxSelected,
                                enable: true,
                                onChange: (bool value) {
                                  print(value);
                                  setState(() {
                                    checkboxSelected = !checkboxSelected;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                // child: Text(
                                //   "By Cheacking the box you agree to out terms and services",
                                // ),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Agree to ',
                                    style: TextStyle(color: Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Term and Condition',
                                        style: TextStyle(
                                            color: middlePurple,
                                            decoration:
                                                TextDecoration.underline),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return TandCDialog();
                                              },
                                            );
                                          },
                                      ),
                                      TextSpan(
                                          text:
                                              ' and contract while Requesting this Franchise!'),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: RaisedButton(
                              onPressed:
                                  checkboxSelected == false ? null : signUp,
                              child: submitButton(),
                              // child: Text("Log In", style: TextStyle(color: Colors.white)),
                              // onPressed: () => signUp,
                              color: Colors.purple,
                            ),
                          ),
                          //The OR Divider
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isValidPhoneNumber(String string) {
    // Null or empty string is invalid phone number
    if (string == null || string.isEmpty) {
      return false;
    }

    // You may need to change this pattern to fit your requirement.
    // I just copied the pattern from here: https://regexr.com/3c53v
    const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }

  Widget submitButton() {
    return _isLoading
        ? Container(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(backgroundColor: Colors.white))
        : Text(
            "Sign Up",
            style: TextStyle(color: Colors.white, fontSize: 16),
          );
  }

  Future<void> signUp() async {
    if (!checkboxSelected) {
      _scaffoldKey.currentState.showSnackBar(
          showSnackbar("Accept Our Agreement", Icon(Icons.error), Colors.red));
      return;
    }

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      setState(() {
        _isLoading = true;
      });
      try {
        var re = await Provider.of<Auth>(context, listen: false)
            .registerUser(user: user);

        if (re != null) {
          _scaffoldKey.currentState
              .showSnackBar(showSnackbar(re, Icon(Icons.error), Colors.red));
        } else {
          Navigator.pop(context);
        }

        // Navigator.pop(context);
      } on LoginException catch (e) {
        _scaffoldKey.currentState.showSnackBar(showSnackbar(
            "Have Problem to Connection. Check Your Connection",
            Icon(Icons.error),
            Colors.red));
      }

      setState(() {
        _isLoading = false;
      });
    }
  }
}
