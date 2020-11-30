import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onion/const/values.dart';
import 'package:onion/models/users.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/validation/signup_validation.dart';
import 'package:onion/widgets/DropdownWidget/DropDownFormField.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  static final routeName = "/profile";
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = new GlobalKey<FormState>();

  User user = new User();
  List interstedList = [
    {
      "name": "technalogy",
    },
    {
      "name": "Working",
    }
  ];
  bool _autovalidate = false;

  @override
  Widget build(BuildContext context) {
    final validationService = Provider.of<SignupValidation>(context);
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidate: _autovalidate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  child: Text(
                    "Investor",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () => _openImagePickerModal(context),
                            child: new Container(
                                width: 70,
                                height: 70,
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(70.0)),
                                  border: new Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 4.0,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(70.0),
                                  child: _isUploadingImage
                                      ? CircularProgressIndicator()
                                      : user.profile != null
                                          ? Image.network(
                                              BASE_URL + user.profile)
                                          : Icon(Icons.add_a_photo),
                                )),
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
                            // user.name = value;
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
                          onChanged: (String value) {
                            validationService.changeEmail(value);
                          },
                          onSaved: (value) {
                            user.email = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Email",
                            errorText: validationService.email.error,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Material(
                                color: Colors.blue, // button color
                                child: InkWell(
                                  splashColor: Colors.red, // inkwell color
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    alignment: Alignment.center,
                                    child: false
                                        ? SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                                backgroundColor: Colors.white))
                                        : FaIcon(FontAwesomeIcons.facebookF,
                                            color: Colors.white, size: 18),
                                  ),
                                  onTap: (){},
                                ),
                              ),
                            ),
                            
                            SizedBox(width: 15),
                            ClipOval(
                              child: Material(
                                color: Colors.redAccent, // button color
                                child: InkWell(
                                  splashColor: Colors.red, // inkwell color
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    alignment: Alignment.center,
                                    child: false
                                        ? SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                                backgroundColor: Colors.white))
                                        : FaIcon(FontAwesomeIcons.googlePlusG,
                                            color: Colors.white, size: 18),
                                  ),
                                  onTap: (){},
                                ),
                              ),
                            ),SizedBox(width: 15),
                             ClipOval(
                              child: Material(
                                color: Colors.blue[800], // button color
                                child: InkWell(
                                  splashColor: Colors.red, // inkwell color
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    alignment: Alignment.center,
                                    child: false
                                        ? SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                                backgroundColor: Colors.white))
                                        : FaIcon(FontAwesomeIcons.linkedinIn,
                                            color: Colors.white, size: 18),
                                  ),
                                  onTap: (){},
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: RaisedButton(
                            onPressed: null,
                            //  checkboxSelected == false ? null : signUp,
                            // child: submitButton(),
                            child: Text("Save"),
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
                )
              ],
            ),
          ),
        ));
  }

  File _imageFile;
  bool _isUploadingImage = false;

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

    // try {
    //   Map result = await Auth().uploadFile(_imageFile, "profile");
    // } on UploadException catch (e) {
    //   // _scaffoldKey.currentState
    //   //     .showSnackBar(showSnackbar(e.cause, Icon(Icons.error), Colors.red));
    // }

    setState(() {
      _isUploadingImage = false;
    });
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
}
