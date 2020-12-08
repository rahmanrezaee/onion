// import 'package:file_picker/file_picker.dart';
import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/const/color.dart';
import 'package:onion/const/public.dart';
import 'package:onion/models/FranchiesModel.dart';
import 'package:onion/models/requestFranchiesModel.dart';
import 'package:onion/pages/CustomDrawerPage.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/statemanagment/franchise_provider.dart';
import 'package:onion/utilities/disabledFocusNode.dart';
import 'package:onion/widgets/AnalysisWidget/MyAlert.dart';
import 'package:intl/intl.dart';
import 'package:onion/widgets/IdeaWiget/LocationWidget.dart';
import 'package:provider/provider.dart';

var textFieldBorderColor = 0xFFe8e9eb;
var textFieldBackgroundColor = 0xFFededed;

class RequestFranchisesUser extends StatefulWidget {
  FranchiesModel franchiesModel;
  RequestFranchisesUser(this.franchiesModel);
  static String routeName = "RequestFranchisesUser";

  @override
  _RequestFranchisesUserState createState() => _RequestFranchisesUserState();
}

class _RequestFranchisesUserState extends State<RequestFranchisesUser> {
  String _message;
  List _documents;

  // PlatformFile _video;
  DateTime _selectedDate;
  String _references;
  bool _agreeWithTerm = false;
  bool _submitted = false;

  RequestFranchiesModel addRequestFranchies = new RequestFranchiesModel();
  Auth authProvider;
  FranchiesProvider franchiesProvider;
//For Generating Location fields
  List<String> list = new List<String>();
  // List<String> list = new List<String>();
  List<TextEditingController> _controllers = [];
  void addField({text}) {
    setState(() {
      this.list.add(text != null ? text.toString() : "");
      var textController = new TextEditingController();
      textController.text = text;
      this._controllers.add(textController);
    });
  }

  @override
  void initState() {
    _selectedDate = DateTime.now();
    super.initState();
    addField();
    addRequestFranchies.franchiesId = widget.franchiesModel.id;
  }

  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<Auth>(context, listen: false);
    franchiesProvider = Provider.of<FranchiesProvider>(context, listen: false);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: middlePurple,
        title: Text("Franchise Name"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed(CustomDrawerPage.routeName);
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Franchise: ${widget.franchiesModel.industry}",
                          style: TextStyle(color: firstPurple, fontSize: 18),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Icon(Icons.info_outline,
                              size: 30, color: firstPurple),
                        ),
                      ]),
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 8.0, right: 8.0, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Industry",
                                    style: TextStyle(fontSize: 15)),
                                Text("${widget.franchiesModel.industry}",
                                    style: TextStyle(fontSize: 15)),
                              ]),
                          Divider(),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Brand",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black87)),
                                Text("${widget.franchiesModel.brandName}",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black87)),
                              ]),
                          Divider(),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Location",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black87)),
                                Text(
                                    "${widget.franchiesModel.location.join(", ")}",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black87)),
                              ]),
                          Divider(),
                          SizedBox(height: 15),
                          Text(
                            "Requirement Details:",
                            style: TextStyle(fontSize: 22, color: deepBlue),
                          ),
                          Text(
                            "${widget.franchiesModel.requirments}",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Add Message",
                      style: TextStyle(fontSize: 20, color: deepBlue)),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 3,
                    style: TextStyle(color: Colors.black87),
                    onChanged: (value) {
                      addRequestFranchies.message = value;
                    },
                    onSaved: (value) {
                      addRequestFranchies.message = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(textFieldBackgroundColor),
                      hintText: "Start typing your messages..",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(textFieldBorderColor),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
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
                      itemCount: addRequestFranchies.uploadDocuments.length + 1,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return addRequestFranchies.uploadDocuments.length >
                                index
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
                                          child: addRequestFranchies
                                                              .uploadDocuments[index]
                                                          ["type"] ==
                                                      "jpg" ||
                                                  addRequestFranchies
                                                              .uploadDocuments[index]
                                                          ["type"] ==
                                                      "jpeg" ||
                                                  addRequestFranchies
                                                              .uploadDocuments[index]
                                                          ["type"] ==
                                                      "png"
                                              ? Image.file(File(
                                                  addRequestFranchies
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
                                            addRequestFranchies.uploadDocuments
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
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        color: Theme.of(context).primaryColor,
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

                  SizedBox(height: 20),
                  Text("Select Date",
                      style: TextStyle(fontSize: 20, color: deepBlue)),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(textFieldBackgroundColor),
                      border: Border.all(
                        width: 2,
                        color: Color(textFieldBorderColor),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              addRequestFranchies.date == null
                                  ? "select data"
                                  : addRequestFranchies.date,
                              style: TextStyle(fontSize: 15)),
                          InkWell(
                            child: Icon(Icons.date_range,
                                size: 30, color: deepBlue),
                            onTap: () async {
                              var newDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1000),
                                lastDate: DateTime(4000),
                              );
                              setState(() {
                                addRequestFranchies.date =
                                    DateFormat('yyyy-MM-dd').format(newDate);
                              });
                            },
                          ),
                        ]),
                  ),
                  SizedBox(height: 20),
                  Text("References",
                      style: TextStyle(fontSize: 20, color: deepBlue)),
                  SizedBox(height: 10),
                  // TextFormField(
                  //   style: TextStyle(color: Colors.black87),
                  //   decoration: InputDecoration(
                  //     contentPadding: EdgeInsets.only(left: 10),
                  //     filled: true,
                  //     fillColor: Color(textFieldBackgroundColor),
                  //     hintText: "User Search on System",
                  //     border: OutlineInputBorder(
                  //       borderSide: BorderSide(
                  //         color: Color(textFieldBorderColor),
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                                  hintText: "User Search on System",
                                  hasLocationIcon: false,
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
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Checkbox(
                        value: _agreeWithTerm,
                        activeColor: middlePurple,
                        onChanged: (v) {
                          setState(() {
                            _agreeWithTerm = v;
                          });
                        },
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: 'Agree to  ',
                            style: TextStyle(color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Term and Condition and contract',
                                style: TextStyle(color: middlePurple),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // open desired screen
                                    print(
                                        "Ali Azad is agree with term and condition");
                                  },
                              ),
                              TextSpan(
                                  text: ' while Requesting this Franchise!'),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: RaisedButton(
                        color: middlePurple,
                        child: _isLoading == true
                            ? CircularProgressIndicator()
                            : Text("Send Request",
                                style: TextStyle(color: Colors.white)),
                        onPressed: _agreeWithTerm == false
                            ? null
                            : addFranchiseRequest,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool uploadingFile = false;
  bool _isLoading = false;

  addFranchiseRequest() {
    addRequestFranchies.users = [];
    _controllers.forEach((TextEditingController controller) {
      if (controller.text != '') {
        addRequestFranchies.users.add("${controller.text}");
      }
    });

    setState(() {
      _submitted = true;
    });

    if (_formKey.currentState.validate() &&
        addRequestFranchies.users != [] &&
        addRequestFranchies.users != null) {
      setState(() {
        _isLoading = true;
      });

      franchiesProvider
          .addFranchiseRequest(addRequestFranchies.sendMap())
          .then((result) {
        setState(() {
          _isLoading = false;
        });
        if (result = true) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Successfuly added."),
            duration: Duration(seconds: 3),
          ));
          Timer(Duration(seconds: 3), () {
            Navigator.of(context).pop();
          });
        }
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

  //Metodes
  Future<void> loadAssetsDocument() async {
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
          addRequestFranchies.uploadDocuments.add({
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
          addRequestFranchies.uploadDocuments.add({
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
          addRequestFranchies.uploadVideo.add(value);
          print("Video data $value");
          setState(() {
            uploadingFile = false;
          });
        });
      }
    }
  } ///////////////////////////////////////

}

class ChoosedFile extends StatelessWidget {
  ChoosedFile(this.onClose);

  final Function onClose;

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Icon(Icons.file_present, size: 90, color: Color(0xFFaaaaaa)),
        Positioned(
          right: -15,
          top: -20,
          child: IconButton(
            icon: Icon(Icons.close, color: Colors.redAccent),
            onPressed: onClose,
          ),
        ),
      ],
    );
  }
}
