import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:onion/const/color.dart';
import 'package:onion/models/FranchiesModel.dart';
import 'package:onion/pages/CustomDrawerPage.dart';
import 'package:onion/pages/Idea/postIdea.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/statemanagment/franchise_provider.dart';
import 'package:onion/widgets/AnalysisWidget/MyAlert.dart';
import 'package:onion/widgets/DropdownWidget/DropDownFormField.dart';
import 'package:onion/widgets/IdeaWiget/LocationWidget.dart';
import 'package:provider/provider.dart';

class AddFranchise extends StatefulWidget {
  static String routeName = "AddFranchise";
  @override
  _AddFranchiseState createState() => _AddFranchiseState();
}

class _AddFranchiseState extends State<AddFranchise> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = new GlobalKey<FormState>();
  String token;
  //Fields

  FranchiesModel addFranch = new FranchiesModel();

  //For Generating Location fields
  List<String> list = new List<String>();
  // List<String> list = new List<String>();
  List<TextEditingController> _controllers = [];
  void addField() {
    setState(() {
      this.list.add("");
      this._controllers.add(new TextEditingController());
    });
  }

  Auth authProvider;
  FranchiesProvider franchiesProvider;
  @override
  initState() {
    super.initState();
    authProvider = Provider.of<Auth>(context, listen: false);
    franchiesProvider = Provider.of<FranchiesProvider>(context, listen: false);
    token = authProvider.token;
    addField();
  }

  bool uploadingFile = false;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: middlePurple,
        title: Text("Add Franchise"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: MyAlertIcon(num: 3),
            onPressed: () {},
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(5.0),
          child: uploadingFile == true
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 5,
                  child: LinearProgressIndicator(),
                )
              : Container(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(children: [
                      DropDownFormField(
                        value: addFranch.industry != ""
                            ? addFranch.industry
                            : "none",
                        onSaved: (value) {
                          setState(() {
                            addFranch.industry = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            addFranch.industry = value;
                          });
                        },
                        dataSource: [
                          {"display": 'Industry Interested', "value": 'none'},
                          {"display": 'Industry', "value": 'Industry'},
                          {"display": 'Learning', "value": 'Learning'},
                          {"display": 'Technoligy', "value": 'Technoligy'},
                          {"display": 'Art', "value": 'Art'},
                        ],
                        textField: 'display',
                        valueField: 'value',
                      ),
                      _submitted == true && addFranch.industry == "" ||
                              addFranch.industry == "none"
                          ? Container(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Please select industry",
                                style: TextStyle(
                                  color: Color(0xffB00020),
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            )
                          : Container(),
                      SizedBox(height: 15),
                      TextFormField(
                        // initialValue: setupIdea['aboutYourBusiness'],
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          color: Colors.purple,
                        ),
                        validator: (value) {
                          if (value.isEmpty) return "Please enter brand name";
                        },
                        onChanged: (value) {
                          addFranch.brandName = value;
                        },
                        onSaved: (value) {},
                        decoration: InputDecoration(
                          hintText: "Brand name",
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
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
                      Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: list.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    LocationWidget(
                                      // borderColor: _submitted == true &&
                                      //         _controllers[index].text == ""
                                      // ? Colors.red
                                      // : Colors.black87,
                                      text: list[index],
                                      controller: _controllers[index],
                                      locationRemove: () {
                                        print(list.toString());
                                        setState(() {
                                          _controllers.removeAt(index);
                                          list.removeAt(index);
                                        });
                                      },
                                    ),
                                    _submitted == true &&
                                            _controllers[index].text == ""
                                        ? Container(
                                            padding: EdgeInsets.only(
                                                left: 10, bottom: 15),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Please enter location",
                                              style: TextStyle(
                                                color: Color(0xffB00020),
                                                fontSize: 12,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          )
                                        : Container(),
                                  ],
                                );
                              }),
                          FlatButton(
                            onPressed: () => addField(),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text("Add More"),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      // SizedBox(height: 15),
                      TextFormField(
                        // initialValue: setupIdea['aboutYourBusiness'],
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          color: Colors.purple,
                        ),
                        validator: (value) {
                          if (value.isEmpty) return "Please enter requirments";
                          return null;
                        },
                        onChanged: (value) {
                          addFranch.requirments = value;
                        },
                        onSaved: (value) {},
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Requirments",
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                color: Colors.purple,
                              ),
                              // validator: (value) {
                              //   if (value.isEmpty)
                              //     return "Your Document is empty";
                              // },
                              // onChanged: (value) {
                              //   validationService.changeDocument(value);
                              // },
                              onSaved: (value) {
                                // user.occupation = value;
                              },
                              enableInteractiveSelection: false,
                              focusNode: new AlwaysDisabledFocusNode(),
                              decoration: InputDecoration(
                                hintText: "Upload Documents",
                                // errorText: validationService.document.error,
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
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () => loadAssetsDocument(),
                            child: Container(
                              padding: EdgeInsets.all(15),
                              color: Theme.of(context).primaryColor,
                              child: Text("Upload",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 15),
                      Container(
                        height: 80,
                        child: ListView.builder(
                          itemCount: addFranch.uploadDocuments.length + 1,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return addFranch.uploadDocuments.length > index
                                ? Stack(
                                    overflow: Overflow.visible,
                                    children: [
                                      Positioned(
                                        bottom: 0,
                                        top: 0,
                                        left: 0,
                                        right: 0,
                                        child: Card(
                                          child: Container(
                                              height: 50,
                                              width: 50,
                                              child: addFranch.uploadDocuments[index]
                                                              ["type"] ==
                                                          "jpg" ||
                                                      addFranch.uploadDocuments[index]
                                                              ["type"] ==
                                                          "jpeg" ||
                                                      addFranch.uploadDocuments[
                                                              index]["type"] ==
                                                          "png"
                                                  ? Image.file(File(addFranch
                                                          .uploadDocuments[index]
                                                      ['path']))
                                                  : Icon(Icons.file_present)),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: IconButton(
                                            icon: Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: () {
                                              setState(() {
                                                addFranch.uploadDocuments
                                                    .removeAt(index);
                                                // postForm.documents
                                                //     .removeAt(index);
                                              });
                                            }),
                                      )
                                    ],
                                  )
                                : FlatButton(
                                    onPressed: loadAssets,
                                    child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50))),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        )),
                                  );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.url,
                              style: TextStyle(
                                color: Colors.purple,
                              ),
                              // onChanged: (value) =>
                              //     validationService.changeVideo(value),
                              // validator: (value) {
                              //   if (value.isEmpty)
                              //     return "Your Upload Video is empty";
                              // },
                              onSaved: (value) {
                                // user.occupation = value;
                              },
                              enableInteractiveSelection: false,
                              focusNode: new AlwaysDisabledFocusNode(),
                              decoration: InputDecoration(
                                hintText: "Upload Video",
                                // errorText: validationService.video.error,
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
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          RaisedButton(
                            padding: EdgeInsets.all(13),
                            color: Theme.of(context).primaryColor,
                            onPressed: () => loadAssetsVideo(),
                            child: Text("Upload",
                                style: TextStyle(color: Colors.white)),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          onPressed: uploadingFile == false
                              ? () {
                                  addFranchise();
                                }
                              : () {
                                  _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Uploading File. Please wait..."),
                                    ),
                                  );
                                },
                          child: _isLoading == true
                              ? CircularProgressIndicator()
                              : Text(
                                  "Add Franchise",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Metodes
  Future<void> loadAssetsDocument() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    // FilePickerResult result = await FilePicker.platform.pickFiles();
    // postForm.documents = [];
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'txt', 'docx'],
    );
    if (result != null) {
      setState(() {
        uploadingFile = true;
      });
      List<PlatformFile> file = result.files;
      file.forEach((element) {
        setState(() {
          addFranch.uploadDocuments.add({
            "name": element.name,
            "path": element.path,
            "type": element.extension,
          });
        });
      });

      List<File> files = result.paths.map((path) => File(path)).toList();
      for (int i = 0; i < files.length; i++) {
        authProvider.uploadFile(files[i], "document").then((value) {
          // _documents.add(value);
          setState(() {
            uploadingFile = false;
          });
        });
      }
    }
  }

  //Show Loaded documnets and images in bottom of Upload bottom
  /////////////////////////////////////////
  Future<void> loadAssets() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    // FilePickerResult result = await FilePicker.platform.pickFiles();

    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'gif', 'jpeg', 'png'],
    );

    if (result != null) {
      List<PlatformFile> file = result.files;

      file.forEach((element) {
        setState(() {
          addFranch.uploadDocuments.add({
            "name": element.name,
            "path": element.path,
            "type": element.extension,
          });
        });
      });
      print("the result is not null and we are uploading files.............");
      setState(() {
        uploadingFile = true;
      });
      List<File> files = result.paths.map((path) => File(path)).toList();
      for (int i = 0; i < files.length; i++) {
        print(files[i]);

        authProvider.uploadFile(files[i], "document").then((value) {
          // _documents.add(value);
          setState(() {
            uploadingFile = false;
          });
        });
      }
    } else {
      // User canceled the picker
    }
  } //////////////////////////////////

  //Upload video
  Future<void> loadAssetsVideo() async {
    // FilePickerResult result = await FilePicker.platform.pickFiles();

    FilePickerResult result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: [
      'WEBM',
      "MPG",
      "MP2",
      "MPEG",
      "MPE",
      "MPV",
      "OGG",
      "MP4",
      "M4P",
      "M4V",
      "AVI",
      "WMV",
      "MOV",
      "QT",
      "FLV",
      "SWF",
      "AVCHD"
    ]);

    if (result != null) {
      setState(() {
        uploadingFile = true;
      });
      print("the result is not null and we are uploading files.............");
      List<File> files = result.paths.map((path) => File(path)).toList();
      for (int i = 0; i < files.length; i++) {
        authProvider.uploadFile(files[i], "video").then((value) {
          addFranch.uploadVideo.add(value);
          print("Video data $value");
          setState(() {
            uploadingFile = false;
          });
        });
      }
    }
  } ///////////////////////////////////////

  bool _submitted = false;
  //Subite the form
  addFranchise() {
    addFranch.location = [];
    setState(() {
      _submitted = true;
    });
    bool locationAdded = true;
    _controllers.forEach((TextEditingController controller) {
      if (controller.text == '') {
        locationAdded = false;
      } else {
        addFranch.location.add("${controller.text}");
      }
    });
    for (final controller in _controllers) {
      if (controller.text == "" || controller.text == null) {
        locationAdded = false;
        addFranch.location = null;
        break;
      } else {
        addFranch.location.add("${controller.text}");
      }
    }
    // print("Locations $_location");
    if (_formKey.currentState.validate() &&
        addFranch.location != "" &&
        addFranch.industry != "none" &&
        addFranch.location != [] &&
        addFranch.location != null) {
      setState(() {
        _isLoading = true;
      });

      franchiesProvider.addFranchise(addFranch.sendMap(), token).then((result) {
        setState(() {
          _isLoading = false;
        });
        // if (result = true) {
        //   _scaffoldKey.currentState.showSnackBar(SnackBar(
        //     content: Text("Successfuly added."),
        //     duration: Duration(seconds: 3),
        //   ));
        //   Timer(Duration(seconds: 3), () {
        //     Navigator.of(context)
        //         .pushReplacementNamed(CustomDrawerPage.routeName);
        //   });
        // }
      }).catchError((error) {
        setState(() {
          _isLoading = false;
        });
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Something went wrong!! Please try again later."),
          duration: Duration(seconds: 4),
        ));
      });
    } else {}
  }
}
