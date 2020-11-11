import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onion/models/users.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/widgets/AuthenticationWidget/OvalBottomBorderClipper.dart';
import 'package:onion/widgets/Checkbox/GlowCheckbox.dart';
import 'package:onion/widgets/DropdownWidget/DropDownFormField.dart';
import 'package:onion/widgets/Snanckbar.dart';
import 'package:provider/provider.dart';

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
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
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
                          new Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(50.0)),
                              border: new Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 4.0,
                              ),
                            ),
                            child: Image.asset("assets/images/user.png"),
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
                            validator: (value) {
                              if (value.isEmpty) return "Your phone is empty";
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
                            onSaved: (value) {
                              setState(() {
                                user.country = value;
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
                                  setState(() {
                                    checkboxSelected = !checkboxSelected;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  "By Cheacking the box you agree to out terms and services",
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: RaisedButton(
                              onPressed: signUp,
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
          ),
        ],
      ),
    );
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
              .showSnackBar(showSnackbar(re, Icon(Icons.alarm), Colors.red));
        } else {
          Navigator.pop(context);
        }

        // Navigator.pop(context);
      } on LoginException catch (e) {
        _scaffoldKey.currentState.showSnackBar(showSnackbar(
            "Have Problem to Connection. Check Your Connection",
            Icon(Icons.alarm),
            Colors.red));
      }

      setState(() {
        _isLoading = false;
      });
    }
  }
}
