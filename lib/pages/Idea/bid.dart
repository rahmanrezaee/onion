import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/const/color.dart';
import 'package:onion/widgets/IdeaWiget/popupMenu.dart' as mypopup;
import 'package:onion/widgets/AnalysisWidget/MyAlert.dart';
import 'package:provider/provider.dart';
import 'package:onion/widgets/PlayWidget/VideoPlayer.dart';
// import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import '../../models/Idea.dart';
import '../../widgets/FiveRating.dart';
import '../../utilities/disabledFocusNode.dart';
import 'package:onion/widgets/Checkbox/GlowCheckbox.dart';
import '../../widgets/T&C_widget.dart';
import 'dart:ui';
import '../../models/bid.dart';
import 'package:flutter/gestures.dart';
import 'package:file_picker/file_picker.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import '../../statemanagment/idea/ideasProviders.dart';
import 'package:intl/intl.dart';

class Bid extends StatefulWidget {
  static String routeName = "Bid";
  // Bid( ModalRoute.of(context).settings.arguments, arguments);

  @override
  _BidState createState() => _BidState();
}

class _BidState extends State<Bid> {
  bool checkboxSelected = false;
  List image = [];
  BidModel bid = new BidModel();
  bool uploadingFile = false;
  String token;
  Auth authProvider;
  final _formKey = new GlobalKey<FormState>();
  bool _autoValidate = false;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  initState() {
    super.initState();
    authProvider = Provider.of<Auth>(context, listen: false);
    token = authProvider.token;
  }

  SetupIdeaModel idea;
  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context).settings.arguments != null) {
      idea = ModalRoute.of(context).settings.arguments;
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: middlePurple,
          title: Text("Bid"),
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
            ),
          ],
          bottom: PreferredSize(
              preferredSize: Size(deviceSize(context).width, 5.0),
              child: uploadingFile == true
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: 5,
                      child: LinearProgressIndicator(),
                    )
                  : Container()),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: _autoValidate == true
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Investor", style: TextStyle(color: Colors.black)),
                        Text("Posted On"),
                      ],
                    ),
                    Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("New Idea"),
                                  Expanded(
                                    child: Text("Need Service Proivder",
                                        textAlign: TextAlign.center),
                                  ),
                                  Text("Need Inovator"),
                                ]),
                            Divider(),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Industry: ",
                                    style: TextStyle(fontSize: 15)),
                                Text(
                                  "${idea.category}",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Headline: ",
                                    style: TextStyle(fontSize: 15)),
                                Text(
                                  "${idea.ideaHeadline}",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            Divider(),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(
                                  text: 'Idea: ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "${idea.ideaText}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Divider(),
                            Row(
                              children: [
                                MyFiveRating(rateVal: 2),
                                SizedBox(width: 10),
                                Text(
                                  "Give Rating",
                                  style: TextStyle(
                                    color: middlePurple,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                color: Colors.purple,
                              ),
                              validator: (value) {
                                if (value.isEmpty) return "Your Idea is empty";
                              },
                              onChanged: (value) {
                                // validationService.changeAbout(value);
                                // bid.ideaText = value;
                                bid.whatYouDo = value;
                              },
                              onSaved: (value) {
                                // user.occupation = value;
                              },
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText:
                                    "What you think and how you want to be part of this idea",
                                // errorText: validationService.about.error,
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
                            Text(
                              "Projects Done",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: .5,
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                      color: Colors.purple,
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty)
                                        return "Your Industry is empty";
                                    },
                                    onChanged: (value) {
                                      // validationService.changeAbout(value);
                                      // bid.ideaText = value;
                                      bid.industry = value;
                                    },
                                    onSaved: (value) {
                                      // user.occupation = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Industry",
                                      // errorText: validationService.about.error,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                      color: Colors.purple,
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty)
                                        return "Project name is empty";
                                    },
                                    onChanged: (value) {
                                      // validationService.changeAbout(value);
                                      // bid.ideaText = value;
                                      bid.projectName = value;
                                    },
                                    onSaved: (value) {
                                      // user.occupation = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Project Name",
                                      // errorText: validationService.about.error,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                      color: Colors.purple,
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty)
                                        return "Project Summary is empty";
                                    },
                                    onChanged: (value) {
                                      // validationService.changeAbout(value);
                                      // bid.ideaText = value;
                                      bid.projectJobSummary = value;
                                    },
                                    maxLines: 5,
                                    onSaved: (value) {
                                      // user.occupation = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Project Job Summary",
                                      // errorText: validationService.about.error,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                  SizedBox(height: 5),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          focusNode:
                                              new AlwaysDisabledFocusNode(),
                                          decoration: InputDecoration(
                                            hintText: "Upload Documents",
                                            // errorText: validationService.document.error,
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
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    height: 80,
                                    child: ListView.builder(
                                      itemCount: image.length + 1,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, int index) {
                                        return image.length > index
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
                                                          child: image[index][
                                                                          "type"] ==
                                                                      "jpg" ||
                                                                  image[index][
                                                                          "type"] ==
                                                                      "jpeg" ||
                                                                  image[index][
                                                                          "type"] ==
                                                                      "png"
                                                              ? Image.file(File(
                                                                  image[index]
                                                                      ['path']))
                                                              : Icon(Icons
                                                                  .file_present)),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: IconButton(
                                                        icon: Icon(Icons.delete,
                                                            color: Colors.red),
                                                        onPressed: () {
                                                          setState(() {
                                                            image.removeAt(
                                                                index);
                                                            // bid.documents
                                                            //     .removeAt(index);
                                                          });
                                                        }),
                                                  )
                                                ],
                                              )
                                            : FlatButton(
                                                onPressed: loadAssetsDocument,
                                                child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 5,
                                                            blurRadius: 7,
                                                            offset: Offset(0,
                                                                3), // changes position of shadow
                                                          ),
                                                        ],
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50))),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          focusNode:
                                              new AlwaysDisabledFocusNode(),
                                          decoration: InputDecoration(
                                            hintText: "Upload Video",
                                            // errorText: validationService.video.error,
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
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      RaisedButton(
                                        padding: EdgeInsets.all(13),
                                        color: Theme.of(context).primaryColor,
                                        onPressed: loadAssetsVideo,
                                        child: Text("Upload",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Text("Enter date"),
                                      SizedBox(height: 5),
                                      InkWell(
                                        onTap: () async {
                                          print("Ali Aad");
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                          DateTime date = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(3200),
                                            builder: (BuildContext context,
                                                Widget child) {
                                              return Theme(
                                                data:
                                                    ThemeData.light().copyWith(
                                                  primaryColor: middlePurple,
                                                  accentColor: thirdPurple,
                                                  buttonTheme: ButtonThemeData(
                                                      textTheme: ButtonTextTheme
                                                          .primary),
                                                ),
                                                child: child,
                                              );
                                            },
                                          );
                                          if (date != null) {
                                            setState(() {
                                              bid.date = date;
                                              // bid.timeline['details'] = {
                                              //   "date": DateFormat.yMMMd()
                                              //       .format(date)
                                              // };
                                            });
                                          }
                                        },
                                        child: AbsorbPointer(
                                          child: TextFormField(
                                            enableInteractiveSelection: false,
                                            focusNode:
                                                new AlwaysDisabledFocusNode(),
                                            // initialValue: bid.timeline[
                                            //                 'details'] !=
                                            //             null &&
                                            //         bid.timeline['details']
                                            //                 ['date'] !=
                                            //             null
                                            //     ? bid.timeline['details']
                                            //         ['date']
                                            //     : null,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(
                                              color: Colors.purple,
                                            ),
                                            // validator: (value) {
                                            //   if (value.isEmpty)
                                            //     return "Date is empty";
                                            // },
                                            // onChanged: (value) {
                                            //   // validationService.changeAbout(value);
                                            //   bid.timeline['details'] = {
                                            //     "date": value
                                            //   };
                                            // },
                                            onSaved: (value) {
                                              // user.occupation = value;
                                            },
                                            decoration: InputDecoration(
                                              hintText: bid.date == null
                                                  ? "Date"
                                                  : DateFormat.yMd()
                                                      .format(bid.date),
                                              suffixIcon:
                                                  Icon(Icons.date_range),
                                              // hintText: bid.timeline[
                                              //                 'details'] !=
                                              //             null &&
                                              //         bid.timeline[
                                              //                     'details']
                                              //                 ['date'] !=
                                              //             null
                                              //     ? bid.timeline['details']
                                              //         ['date']
                                              //     : null,
                                              hintStyle: TextStyle(
                                                  color: Colors.black),
                                              // errorText: validationService.about.error,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
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
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      bid.date == null && submited == true
                                          ? Column(children: [
                                              Text(
                                                "Please select date",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              SizedBox(height: 10),
                                            ])
                                          : Container(),
                                      Text("References"),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        keyboardType: TextInputType.text,
                                        style: TextStyle(
                                          color: Colors.purple,
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty)
                                            return "User Search is empty";
                                        },
                                        onChanged: (value) {
                                          // validationService.changeAbout(value);
                                          // bid. = value;
                                        },
                                        onSaved: (value) {
                                          // user.occupation = value;
                                        },
                                        decoration: InputDecoration(
                                          hintText: "User Search on System",
                                          // errorText: validationService.about.error,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
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
                                    ],
                                  ),
                                ],
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
                                  return "Project Summary is empty";
                              },
                              onChanged: (value) {
                                // validationService.changeAbout(value);
                                bid.message = value;
                              },
                              maxLines: 5,
                              onSaved: (value) {
                                // user.occupation = value;
                              },
                              decoration: InputDecoration(
                                hintText: "Add Message",
                                // errorText: validationService.about.error,
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
                            SizedBox(height: 5),
                            Row(
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
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  color: middlePurple,
                                  child: isLoading == true
                                      ? CircularProgressIndicator()
                                      : Text("Bid",
                                          style:
                                              TextStyle(color: Colors.white)),
                                  onPressed: checkboxSelected == true
                                      ? () {
                                          addBid(context);
                                        }
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      );

      // Future<void> loadAssets() async {
      //   FocusScope.of(context).requestFocus(new FocusNode());
      //   // FilePickerResult result = await FilePicker.platform.pickFiles();

      //   FilePickerResult result = await FilePicker.platform.pickFiles(
      //     allowMultiple: true,
      //     type: FileType.custom,
      //     allowedExtensions: ['jpg', 'pdf', 'gif', 'jpeg', 'png'],
      //   );

      //   if (result != null) {
      //     List<PlatformFile> file = result.files;

      //     file.forEach((element) {
      //       setState(() {
      //         image.add({
      //           "name": element.name,
      //           "path": element.path,
      //           "type": element.extension,
      //         });
      //       });
      //     });
      //     print(
      //         "the result is not null and we are uploading files.............");
      //     setState(() {
      //       uploadingFile = true;
      //     });
      //     List<File> files = result.paths.map((path) => File(path)).toList();
      //     for (int i = 0; i < files.length; i++) {
      //       authProvider.uploadFile(files[i], "document").then((value) {
      //         Map sendMap = {
      //           "_id": value["_id"],
      //           "uriPath": value["uriPath"],
      //         };
      //         bid.uploadDocuments.add(sendMap);
      //         // bid.documents.add(value);
      //         setState(() {
      //           uploadingFile = false;
      //         });
      //       });
      //     }
      //   } else {
      //     // User canceled the picker
      //   }
      // }

    } else {}
  }

  Future<void> loadAssetsDocument() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    // FilePickerResult result = await FilePicker.platform.pickFiles();
    // bid.documents = [];
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
          image.add({
            "name": element.name,
            "path": element.path,
            "type": element.extension,
          });
        });
      });
      print("the result is not null and we are uploading files.............");
      List<File> files = result.paths.map((path) => File(path)).toList();
      for (int i = 0; i < files.length; i++) {
        authProvider.uploadFile(files[i], "document").then((value) {
          Map sendMap = {
            "_id": value["_id"],
            "uriPath": value["uriPath"],
          };
          bid.uploadDocuments.add(sendMap);
          setState(() {
            uploadingFile = false;
          });
        });
      }
    }
  }

  Future<void> loadAssetsVideo() async {
    // FilePickerResult result = await FilePicker.platform.pickFiles();
    setState(() {
      uploadingFile = true;
    });
    FilePickerResult result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: [
      'WEBM',
      "MPG",
      "MP2",
      "MPEG",
      "MPE",
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
      print("the result is not null and we are uploading files.............");
      List<File> files = result.paths.map((path) => File(path)).toList();
      for (int i = 0; i < files.length; i++) {
        authProvider.uploadFile(files[i], "video").then((value) {
          Map sendMap = {
            "_id": value["_id"],
            "uriPath": value["uriPath"],
          };
          bid.uploadVideo = sendMap;
          print("Video data $value");
          setState(() {
            uploadingFile = false;
          });
        });
      }
    }
  }

  bool submited = false;
  bool isLoading = false;
  //Post bid
  void addBid(context) {
    setState(() {
      submited = true;
    });
    // &&
    //     bid.documents.length > 0 &&
    //     bid.uploadVideo != null
    if (_formKey.currentState.validate()) {
      bid.ideaId = idea.id;
      _formKey.currentState.save();
      setState(() {
        isLoading = true;
      });
      // Scaffold.of(context).showSnackBar(SnackBar(
      //   duration: Duration(seconds: 5),
      //   content: Text("Under Development"),
      //   // backgroundColor: Colors.red,
      // ));
      print("bid: ${bid.toJson()}");
      //Update an idea
      IdeasProvider().bidIdea(bid.toJson(), token).then((status) {
        if (status == true) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Done."),
            duration: Duration(seconds: 4),
          ));
          setState(() {
            isLoading = false;
          });
          Timer(Duration(seconds: 4), () {
            // Navigator.pushNamed(context, "/");
            Navigator.pop(context);
          });
        } else {
          setState(() {
            isLoading = false;
          });
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            duration: Duration(seconds: 5),
            content: Text("Something went wrong. Try again"),
            backgroundColor: Colors.red,
          ));
        }
      }).catchError((e) {
        setState(() {
          isLoading = false;
        });
        print("this is the error: $e");
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          duration: Duration(seconds: 5),
          content: Text("Something went wrong. Try again"),
          backgroundColor: Colors.red,
        ));
      });
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
