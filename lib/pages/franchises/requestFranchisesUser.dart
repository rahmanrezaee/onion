// import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/const/color.dart';
import 'package:onion/const/public.dart';
import 'package:onion/pages/CustomDrawerPage.dart';
import 'package:onion/widgets/AnalysisWidget/MyAlert.dart';
import 'package:intl/intl.dart';

var textFieldBorderColor = 0xFFe8e9eb;
var textFieldBackgroundColor = 0xFFededed;

class RequestFranchisesUser extends StatefulWidget {
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

  @override
  void initState() {
    _selectedDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Franchise: <Franchise Name>",
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
                              Text("Industry", style: TextStyle(fontSize: 15)),
                              Text("<IndustryName>",
                                  style: TextStyle(fontSize: 15)),
                            ]),
                        Divider(),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Brand",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black87)),
                              Text("Brand Name",
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
                              Text("Place/Location",
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
                          "Automate th eprocess of sending emails with some features based on business requirements. You can have a list of email customized addresses. Automate the process of sendign emails with customized featrues base on business..",
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
                    _message = value;
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
                Text("Upload Documents",
                    style: TextStyle(fontSize: 20, color: deepBlue)),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.only(left: 10),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Select Document", style: TextStyle(fontSize: 15)),
                        SizedBox(
                          width: 100,
                          height: 50,
                          child: RaisedButton(
                            padding: EdgeInsets.zero,
                            color: middlePurple,
                            child: Text("Upload",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            onPressed: () async {
                              // FilePickerResult result =
                              //     await FilePicker.platform.pickFiles(
                              //   allowMultiple: true,
                              //   type: FileType.custom,
                              //   allowedExtensions: allowedDocumnetsFormat,
                              // );

                              // if (result != null) {
                              //   setState(() {
                              //     _documents = result.files;
                              //   });
                              // } else {
                              //   // User canceled the picker
                              // }
                            },
                          ),
                        ),
                      ]),
                ),
                SizedBox(height: 20),
                _documents == null
                    ? Container()
                    : Wrap(
                        children: [
                          ..._documents.map(
                            (doc) => SizedBox(
                              height: deviceSize(context).height,
                              width: deviceSize(context).width,
                              child: ChoosedFile(
                                () {
                                  int index = _documents.indexOf(doc);
                                  setState(() {
                                    _documents.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                SizedBox(height: 20),
                Text("Upload Video",
                    style: TextStyle(fontSize: 20, color: deepBlue)),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.only(left: 10),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Select Video File",
                            style: TextStyle(fontSize: 15)),
                        SizedBox(
                          width: 100,
                          height: 50,
                          child: RaisedButton(
                            padding: EdgeInsets.zero,
                            color: middlePurple,
                            child: Text("Upload",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            onPressed: () async {
                              // FilePickerResult result =
                              //     await FilePicker.platform.pickFiles(
                              //   type: FileType.video,
                              // );
                              // if (result != null) {
                              //   _video = result.files.first;
                              // } else {
                              //   // User canceled the picker
                              // }
                            },
                          ),
                        ),
                      ]),
                ),
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
                        Text(DateFormat('yyyy-MM-dd').format(_selectedDate),
                            style: TextStyle(fontSize: 15)),
                        InkWell(
                          child:
                              Icon(Icons.date_range, size: 30, color: deepBlue),
                          onTap: () async {
                            var newDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1000),
                              lastDate: DateTime(4000),
                            );
                            setState(() {
                              _selectedDate = newDate;
                            });
                          },
                        ),
                      ]),
                ),
                SizedBox(height: 20),
                Text("References",
                    style: TextStyle(fontSize: 20, color: deepBlue)),
                SizedBox(height: 10),
                TextFormField(
                  style: TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10),
                    filled: true,
                    fillColor: Color(textFieldBackgroundColor),
                    hintText: "User Search on System",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(textFieldBorderColor),
                      ),
                    ),
                  ),
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
                            TextSpan(text: ' while Requesting this Franchise!'),
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
                      child: Text("Send Request",
                          style: TextStyle(color: Colors.white)),
                      onPressed: _agreeWithTerm == false ? null : () {},
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
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