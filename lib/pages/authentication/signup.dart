import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onion/const/color.dart';
import 'package:onion/const/values.dart';
import 'package:onion/models/users.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/validation/signup_validation.dart';
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
  Future fetchDataForSignup;

  File _imageFile;
  bool _isUploadingImage = false;
  List interstedList;
  List locationList;
  List state;

  void getInitData() {
    fetchDataForSignup = Auth().getDataSignup();
  }

  void getStateData(parent) async {
    setState(() {
      state.clear();
      state.add({"name": "waiting..."});
    });

    List stateTemp = await Auth().getDataState(parent);
    setState(() {
      state.clear();
      state.addAll(stateTemp);
    });
    print("state is");
    print(state);
  }

  @override
  void initState() {
    getInitData();
    super.initState();
  }

  bool _autovalidate = false;

  @override
  Widget build(BuildContext context) {
    final validationService = Provider.of<SignupValidation>(context);

    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: FutureBuilder(
          future: fetchDataForSignup,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.data == null) {
                  return Center(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.replay),
                        onPressed: getInitData,
                      ),
                      Text("Problem in connection plase try again"),
                    ],
                  ));
                }

                interstedList = snapshot.data[0];
                locationList = snapshot.data[1];
                state = snapshot.data[2];

                return Stack(
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 0),
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
                              autovalidate: _autovalidate,
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
                                  SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () => _openImagePickerModal(context),
                                    child: new Container(
                                        width: 70,
                                        height: 70,
                                        decoration: new BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(70.0)),
                                          border: new Border.all(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 4.0,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(70.0),
                                          child: _isUploadingImage
                                              ? CircularProgressIndicator()
                                              : user.profile != null
                                                  ? Image.network(
                                                      BASE_URL + user.profile)
                                                  : Icon(Icons.add_a_photo),
                                        )),
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                    onChanged: (String value) {
                                      validationService.changeEmail(value);
                                    },
                                    onSaved: (value) {
                                      user.email = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Email",
                                      errorText: validationService.email.error,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(
                                          14), // for mobile
                                    ],
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
                                    onChanged: (String value) {
                                      validationService.changePhone(value);
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Phone Number",
                                      errorText: validationService.phone.error,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                      });
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                    },
                                    value: user.interst != null
                                        ? user.interst
                                        : interstedList[0]["name"],
                                    onSaved: (value) {
                                      setState(() {
                                        user.interst = value;
                                      });
                                    },
                                    dataSource: interstedList.map((data) {
                                      return {
                                        "display": data['name'],
                                        "value": data['name']
                                      };
                                    }).toList(),
                                    // dataSource: [
                                    //   {
                                    //     "display": 'Category Interested',
                                    //     "value": 'none'
                                    //   },
                                    //   {
                                    //     "display": 'Technalogy',
                                    //     "value": 'tach'
                                    //   },
                                    //   {
                                    //     "display": 'Learing',
                                    //     "value": 'learing'
                                    //   },
                                    // ],
                                    textField: 'display',
                                    valueField: 'value',
                                  ),

                                  SizedBox(height: 10),

                                  DropDownFormField(
                                    value: user.country != null
                                        ? user.country
                                        : locationList[0]['name'],
                                    onChanged: (value) async {
                                      user.state = null;
                                      setState(() {
                                        user.country = value;
                                      });
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                      await getStateData(value);
                                    },
                                    onSaved: (value) {
                                      setState(() {
                                        user.country = value;
                                      });
                                    },
                                    dataSource: locationList.map((data) {
                                      return {
                                        "display": data['name'],
                                        "value": data['name']
                                      };
                                    }).toList(),
                                    textField: 'display',
                                    valueField: 'value',
                                  ),

                                  SizedBox(height: 10),
                                  state != null && state.length > 0
                                      ? DropDownFormField(
                                          value: user.state != null
                                              ? user.state
                                              : state[0]['name'],
                                          onSaved: (value) {
                                            setState(() {
                                              user.state = value;
                                            });
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              user.state = value;
                                            });
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                          },
                                          dataSource: state != null
                                              ? state.map((data) {
                                                  return {
                                                    "display": data['name'],
                                                    "value": data['name']
                                                  };
                                                }).toList()
                                              : [
                                                  {
                                                    "display": 'State',
                                                    "value": 'none'
                                                  },
                                                ],
                                          textField: 'display',
                                          valueField: 'value',
                                        )
                                      : SizedBox(),

                                  SizedBox(height: 20),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GlowCheckbox(
                                        color: Theme.of(context).primaryColor,
                                        value: checkboxSelected,
                                        enable: true,
                                        onChange: (bool value) {
                                          setState(() {
                                            checkboxSelected =
                                                !checkboxSelected;
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
                                            style:
                                                TextStyle(color: Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: 'Term and Condition',
                                                style: TextStyle(
                                                    color: middlePurple,
                                                    decoration: TextDecoration
                                                        .underline),
                                                recognizer:
                                                    TapGestureRecognizer()
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
                                      onPressed: checkboxSelected == false
                                          ? null
                                          : signUp,
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
                );
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );

              case ConnectionState.none:
                return Text("Problem occur in fetch data");

              case ConnectionState.active:
                break;
            }
          },
        ),
      ),
    );
  }

  bool isValidPhoneNumber(String string) {
    if (string == null || string.isEmpty) {
      return false;
    }

    const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    if (string.length < 9 || string.length > 13) {
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

  void _getImage(BuildContext context, ImageSource source) async {
    File image = await ImagePicker.pickImage(
      source: source,
      imageQuality: 85,
    );

    setState(() {
      _imageFile = image;
    });

    Navigator.pop(context);

    if (_imageFile != null) {
      await _cropImage();
    }

    setState(() {
      _isUploadingImage = true;
    });

    try {
      String result = await Auth().uploadImage(_imageFile, "profile");
      user.profile = result;
    } on UploadException catch (e) {
      _scaffoldKey.currentState
          .showSnackBar(showSnackbar(e.cause, Icon(Icons.error), Colors.red));
    }

    setState(() {
      _isUploadingImage = false;
    });
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
              ]
            : [
                CropAspectRatioPreset.square,
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Edit Image',
            toolbarColor: Theme.of(context).primaryColor,
            cropFrameColor: Theme.of(context).primaryColor,
            statusBarColor: Theme.of(context).primaryColor,
            activeControlsWidgetColor: Theme.of(context).primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Edit Image',
        ));
    if (croppedFile != null) {
      setState(() {
        _imageFile = croppedFile;
      });
    }
  }

  void _openImagePickerModal(BuildContext context) {
    final flatButtonColor = Theme.of(context).primaryColor;

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            child: Column(
              children: <Widget>[
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                  width: double.infinity,
                  child: Text(
                    'Choice Image',
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FlatButton(
                      textColor: flatButtonColor,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          FaIcon(FontAwesomeIcons.camera),
                          Text('Comara'),
                        ],
                      ),
                      onPressed: () {
                        _getImage(context, ImageSource.camera);
                      },
                    ),
                    FlatButton(
                      textColor: flatButtonColor,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          FaIcon(FontAwesomeIcons.images),
                          Text('Gallary'),
                        ],
                      ),
                      onPressed: () {
                        _getImage(context, ImageSource.gallery);
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
