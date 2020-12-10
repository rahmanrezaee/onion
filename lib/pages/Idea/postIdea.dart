import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onion/const/color.dart';
import 'package:onion/models/Idea.dart';
import 'package:onion/pages/Home.dart';
import 'package:onion/statemanagment/idea/ideasProviders.dart';
import 'package:onion/utilities/linkChecker.dart';
import 'package:onion/models/setupIdea.dart' as setupIdeaModel;
import 'package:onion/services/ideasServices.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/validation/postIdeaValidation.dart';
import 'package:onion/widgets/Checkbox/GlowCheckbox.dart';
import 'package:onion/widgets/DropdownWidget/DropDownFormField.dart';
import 'package:onion/widgets/Home/MyPopup.dart';
import 'package:onion/widgets/IdeaWiget/LocationWidget.dart';
import 'package:onion/widgets/MyLittleAppbar.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class PostIdea extends StatefulWidget {
  static final routeName = "/postIdea";

  @override
  _PostIdeaState createState() => _PostIdeaState();
}

SetupIdeaModel postForm = new SetupIdeaModel();

class _PostIdeaState extends State<PostIdea> {
  List image = [];
  List<String> list = new List<String>();
  List<TextEditingController> _controllers = [];

  int addinput = 1;
  bool submited = false;
  void addField() {
    setState(() {
      this.list.add("");
      this._controllers.add(new TextEditingController());
    });
  }

  String token;
  Auth authProvider;
  @override
  void initState() {
    authProvider = Provider.of<Auth>(context, listen: false);
    token = authProvider.token;
    print("this is the token bor: $token");
    addField();
    super.initState();
  }

  bool uploadingFile = false;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool checkboxSelectedNeedSerive = true;
  bool checkboxSelectedNeedInvestor = false;
  bool _autoValidate = false;
  int stages = 0;
  // List<File> documents = [];
  File video;
  SetupIdeaModel idea;
  bool first = true;
  @override
  Widget build(context) {
    // print("Setup Idea: ${setupIdea['category']}");
    if (ModalRoute.of(context).settings.arguments != null) {
      idea = ModalRoute.of(context).settings.arguments;
      if (first == true) {
        setState(() {
          postForm = idea;
          image = postForm.documents;
          stages = (postForm.timeline["details"] as List).length;
          // postForm.documents.forEach((element) {
          // image.add(element);
          // if (isUriImage(element["uriPath"])) {
          // }
          // });
        });
        print(idea);
      }
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight + 5),
        child: Column(
          children: [
            MyLittleAppbar(myTitle: "Post Idea Id"),
            uploadingFile == true
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: 5,
                    child: LinearProgressIndicator(),
                  )
                : Container()
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Form(
            autovalidate: _autoValidate,
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )),
                      InkWell(
                        child: Icon(Icons.info_outline),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Card(
                    // margin: EdgeInsets.all(10),
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Radio(
                                activeColor: Theme.of(context).primaryColor,
                                value: postForm.typeIdea == null
                                    ? 0
                                    : postForm.typeIdea == "new idea"
                                        ? 1
                                        : 0,
                                groupValue: 1,
                                onChanged: (va) {
                                  print(va);
                                  setState(() {
                                    postForm.typeIdea = "new idea";
                                  });
                                },
                              ),
                              new Text(
                                'New Idea',
                                style: new TextStyle(fontSize: 16.0),
                              ),
                              new Radio(
                                activeColor: Theme.of(context).primaryColor,
                                value: postForm.typeIdea == null
                                    ? 1
                                    : postForm.typeIdea == "Implemented Idea"
                                        ? 1
                                        : 0,
                                groupValue: 1,
                                onChanged: (va) {
                                  setState(() {
                                    postForm.typeIdea = "Implemented Idea";
                                  });
                                },
                              ),
                              new Text(
                                'Implement Idea',
                                style: new TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DropDownFormField(
                            value: postForm.category != null
                                ? postForm.category
                                : "Industry",
                            // value: setupIdea['category'],
                            onSaved: (value) {
                              setState(() {
                                postForm.category = value;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                postForm.category = value;
                              });
                            },
                            dataSource: [
                              {"display": 'Industry', "value": 'Industry'},
                              {"display": 'Technalogy', "value": 'Technalogy'},
                              {"display": 'Learning', "value": 'Learning'},
                            ],
                            textField: 'display',
                            valueField: 'value',
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.all(5),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Industry Experience",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  initialValue: postForm.experienceYear,
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(
                                        2), // for mobile
                                  ],
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    color: Colors.purple,
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty)
                                      return "Your Year is empty";
                                    // if (value.length != 4)
                                    //   return "Your Year is invalid";
                                  },
                                  onSaved: (value) {
                                    // user.occupation = value;
                                  },
                                  onChanged: (value) {
                                    // validationService.changeYear(value);
                                    postForm.experienceYear = value;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Year",
                                    // errorText: validationService.year.error,
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
                              Expanded(
                                child: TextFormField(
                                  initialValue: postForm.experienceMonth,
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(
                                        2), // for mobile
                                  ],
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    color: Colors.purple,
                                  ),
                                  onChanged: (value) {
                                    // validationService.changeMonth(value);
                                    postForm.experienceMonth = value;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty)
                                      return "Your Month is empty";
                                    if (value.length > 2)
                                      return "Your Month is invalid";
                                  },
                                  onSaved: (value) {
                                    // user.occupation = value;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Month",
                                    // errorText: validationService.month.error,
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
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            initialValue: postForm.ideaHeadline,
                            // keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: Colors.purple,
                            ),
                            validator: (value) {
                              if (value.isEmpty)
                                return "Your Idea Headline is empty";
                            },
                            // inputFormatters: [
                            //   new LengthLimitingTextInputFormatter(
                            //       5), // for mobile
                            // ],
                            onSaved: (value) {
                              // user.occupation = value;
                            },
                            onChanged: (value) {
                              // validationService.changeTeamSize(value);
                              postForm.ideaHeadline = value;
                            },
                            decoration: InputDecoration(
                              hintText: "Idea Headline",
                              //    errorText: validationService.teamSize.error,
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
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            initialValue: postForm.ideaText,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                              color: Colors.purple,
                            ),
                            validator: (value) {
                              if (value.isEmpty) return "Your Idea is empty";
                            },
                            onChanged: (value) {
                              // validationService.changeAbout(value);
                              postForm.ideaText = value;
                            },
                            onSaved: (value) {
                              // user.occupation = value;
                            },
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: "Idea",
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
                          SizedBox(
                            height: 10,
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                'TimeLine :',
                                style: new TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              new Radio(
                                activeColor: Theme.of(context).primaryColor,
                                value: postForm.timeline == null
                                    ? 0
                                    : postForm.timeline['timelineType'] ==
                                            "stages"
                                        ? 1
                                        : 0,
                                groupValue: 1,
                                onChanged: (va) {
                                  print(va);
                                  setState(() {
                                    postForm.timeline['timelineType'] =
                                        "stages";
                                  });
                                  // postForm.timeline['details'] = List.generate(
                                  //     stages,
                                  //     (index) => {
                                  //           "start": "0",
                                  //           "end": "0",
                                  //         }).toList();
                                  print(postForm.timeline['timelineType']);
                                },
                              ),
                              new Text(
                                'Stages',
                                style: new TextStyle(fontSize: 13),
                              ),
                              new Radio(
                                activeColor: Theme.of(context).primaryColor,
                                value: postForm.timeline['timelineType'] == null
                                    ? 1
                                    : postForm.timeline['timelineType'] ==
                                            "date"
                                        ? 1
                                        : 0,
                                groupValue: 1,
                                onChanged: (va) {
                                  setState(() {
                                    postForm.timeline['timelineType'] = "date";
                                  });
                                  postForm.timeline['details'] = {};
                                  print(postForm.timeline['timelineType']);
                                },
                              ),
                              new Text(
                                'Date',
                                style: new TextStyle(
                                  fontSize: 13.0,
                                ),
                              ),
                            ],
                          ),
                          postForm.timeline['timelineType'] == 'date'
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      Text("Enter date"),
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
                                              postForm.timeline['details'] = {
                                                "date": DateFormat.yMMMd()
                                                    .format(date)
                                              };
                                            });
                                          }
                                        },
                                        child: AbsorbPointer(
                                          child: TextFormField(
                                            enableInteractiveSelection: false,
                                            focusNode:
                                                new AlwaysDisabledFocusNode(),
                                            // initialValue: postForm.timeline[
                                            //                 'details'] !=
                                            //             null &&
                                            //         postForm.timeline['details']
                                            //                 ['date'] !=
                                            //             null
                                            //     ? postForm.timeline['details']
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
                                            //   postForm.timeline['details'] = {
                                            //     "date": value
                                            //   };
                                            // },
                                            onSaved: (value) {
                                              // user.occupation = value;
                                            },
                                            decoration: InputDecoration(
                                              hintText: postForm.timeline[
                                                              'details'] !=
                                                          null &&
                                                      postForm.timeline[
                                                                  'details']
                                                              ['date'] !=
                                                          null
                                                  ? postForm.timeline['details']
                                                      ['date']
                                                  : null,
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
                                    ])
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      Text("Select Total Stages"),
                                      SizedBox(height: 5),
                                      DropDownFormField(
                                        value: stages != 0 ? "$stages" : "none",
                                        onSaved: (value) {
                                          setState(() {
                                            stages = int.parse(value);
                                          });
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            stages = int.parse(value);
                                            postForm.timeline['details'] =
                                                List.generate(
                                              stages,
                                              (i) {
                                                return {"start": '', "end": ''};
                                              },
                                            );
                                          });
                                        },
                                        dataSource: [
                                          {"display": ' ', "value": 'none'},
                                          ...List.generate(12, (index) {
                                            return {
                                              "display": "${index + 1}",
                                              "value": "${index + 1}"
                                            };
                                          }).toList(),
                                        ],
                                        textField: 'display',
                                        valueField: 'value',
                                      ),
                                      SizedBox(height: 10),
                                      ...List.generate(stages, (index) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 5),
                                            Text(
                                                "Enter Start Date for Stage ${index + 1}"),
                                            SizedBox(height: 5),
                                            Theme(
                                              data: Theme.of(context).copyWith(
                                                primaryColor: Colors.amber,
                                              ),
                                              child: TextFormField(
                                                onTap: () async {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          new FocusNode());
                                                  DateTime date =
                                                      await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime(3200),
                                                    builder:
                                                        (BuildContext context,
                                                            Widget child) {
                                                      return Theme(
                                                        data: ThemeData.light()
                                                            .copyWith(
                                                          primaryColor:
                                                              middlePurple,
                                                          accentColor:
                                                              thirdPurple,
                                                          buttonTheme: ButtonThemeData(
                                                              textTheme:
                                                                  ButtonTextTheme
                                                                      .primary),
                                                        ),
                                                        child: child,
                                                      );
                                                    },
                                                  );
                                                  if (date != null) {
                                                    setState(() {
                                                      (postForm.timeline[
                                                                      'details']
                                                                  as List)[
                                                              index]['start'] =
                                                          DateFormat.yMMMd()
                                                              .format(date);
                                                    });
                                                  }
                                                },
                                                enableInteractiveSelection:
                                                    false,
                                                focusNode:
                                                    new AlwaysDisabledFocusNode(),
                                                // initialValue: postForm.timeline[
                                                //                 'details'] !=
                                                //             null &&
                                                //         postForm.timeline[
                                                //                     'details']
                                                //                 ['start'] !=
                                                //             null
                                                //     ? postForm.timeline['details']
                                                //         ['start']
                                                //     : null,
                                                keyboardType:
                                                    TextInputType.number,
                                                style: TextStyle(
                                                  color: Colors.purple,
                                                ),
                                                // validator: (value) {
                                                //   if (value.isEmpty)
                                                //     return "It's empty";
                                                //   return null;
                                                // },
                                                onChanged: (value) {
                                                  // validationService.changeAbout(value);
                                                  (postForm.timeline['details']
                                                          as List)[index]
                                                      ['start'] = value;
                                                },
                                                onSaved: (value) {
                                                  // user.occupation = value;
                                                },
                                                decoration: InputDecoration(
                                                  hintText: (postForm.timeline[
                                                                      'details']
                                                                  as List) !=
                                                              null &&
                                                          (postForm.timeline[
                                                                          'details']
                                                                      as List)[index]
                                                                  ['start'] !=
                                                              null
                                                      ? (postForm.timeline[
                                                                  'details']
                                                              as List)[index]
                                                          ['start']
                                                      : '',
                                                  hintStyle: TextStyle(
                                                      color: Colors.black),
                                                  // errorText: validationService
                                                  // .about.error,
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    vertical: 10,
                                                    horizontal: 10,
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.purple,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            //End date
                                            SizedBox(height: 5),
                                            Text(
                                                "Enter End Date for Stage ${index + 1}"),
                                            SizedBox(height: 5),
                                            TextFormField(
                                              onTap: () async {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        new FocusNode());
                                                DateTime date =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(3200),
                                                  builder:
                                                      (BuildContext context,
                                                          Widget child) {
                                                    return Theme(
                                                      data: ThemeData.light()
                                                          .copyWith(
                                                        primaryColor:
                                                            middlePurple,
                                                        accentColor:
                                                            thirdPurple,
                                                        buttonTheme: ButtonThemeData(
                                                            textTheme:
                                                                ButtonTextTheme
                                                                    .primary),
                                                      ),
                                                      child: child,
                                                    );
                                                  },
                                                );
                                                if (date != null) {
                                                  setState(() {
                                                    (postForm.timeline[
                                                                    'details']
                                                                as List)[index]
                                                            ['end'] =
                                                        DateFormat.yMMMd()
                                                            .format(date);
                                                  });
                                                }
                                              },
                                              enableInteractiveSelection: false,
                                              focusNode:
                                                  new AlwaysDisabledFocusNode(),
                                              // initialValue: postForm.timeline[
                                              //                 'details'] !=
                                              //             null &&
                                              //         postForm.timeline[
                                              //                     'details']
                                              //                 ['start'] !=
                                              //             null
                                              //     ? postForm.timeline['details']
                                              //         ['start']
                                              //     : null,
                                              keyboardType:
                                                  TextInputType.number,
                                              style: TextStyle(
                                                color: Colors.purple,
                                              ),
                                              // validator: (value) {
                                              //   if (value.isEmpty)
                                              //     return "It's empty";
                                              //   return null;
                                              // },
                                              onChanged: (value) {
                                                // validationService.changeAbout(value);
                                                (postForm.timeline['details']
                                                        as List)[index]['end'] =
                                                    value;
                                              },
                                              onSaved: (value) {
                                                // user.occupation = value;
                                              },
                                              decoration: InputDecoration(
                                                hintText: (postForm.timeline[
                                                                    'details']
                                                                as List) !=
                                                            null &&
                                                        (postForm.timeline[
                                                                        'details']
                                                                    as List)[
                                                                index]['end'] !=
                                                            null
                                                    ? (postForm
                                                            .timeline['details']
                                                        as List)[index]['end']
                                                    : '',
                                                hintStyle: TextStyle(
                                                    color: Colors.black),
                                                // errorText: validationService
                                                //     .about.error,
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
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.purple,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                          ],
                                        );
                                      }).toList(),
                                    ]),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 10,
                          ),
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
                          // postForm.documents.length < 1 && submited == true
                          //     ? Align(
                          //         alignment: Alignment.centerLeft,
                          //         child: Text(
                          //           "select documents",
                          //           textAlign: TextAlign.center,
                          //           style: TextStyle(color: Colors.red),
                          //         ),
                          //       )
                          //     : Container(),
                          //  Container(
                          //   padding: EdgeInsets.all(5),
                          //   alignment: Alignment.topLeft,
                          //   child: Text(
                          //     "Document",
                          //     style: TextStyle(
                          //         fontWeight: FontWeight.bold, fontSize: 14),
                          //   ),
                          // ),
                          SizedBox(
                            height: 10,
                          ),
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
                                                  child: image[index]["type"] ==
                                                              "jpg" ||
                                                          image[index]
                                                                  ["type"] ==
                                                              "jpeg" ||
                                                          image[index]
                                                                  ["type"] ==
                                                              "png"
                                                      ? Image.file(File(
                                                          image[index]['path']))
                                                      : Icon(
                                                          Icons.file_present)),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: IconButton(
                                                icon: Icon(Icons.delete,
                                                    color: Colors.red),
                                                onPressed: () {
                                                  setState(() {
                                                    image.removeAt(index);
                                                    postForm.documents
                                                        .removeAt(index);
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
                                                color: Theme.of(context)
                                                    .primaryColor,
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
                          // postForm.uploadVideo == null && submited == true
                          //     ? Align(
                          //         alignment: Alignment.centerLeft,
                          //         child: Text(
                          //           "select video",
                          //           textAlign: TextAlign.center,
                          //           style: TextStyle(color: Colors.red),
                          //         ),
                          //       )
                          //     : Container(),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.all(5),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Target Audience",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                          TextFormField(
                            initialValue: postForm.location,
                            // keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: Colors.purple,
                            ),
                            validator: (value) {
                              if (value.isEmpty) return "it is empty";
                            },
                            // inputFormatters: [
                            //   new LengthLimitingTextInputFormatter(
                            //       5), // for mobile
                            // ],
                            // onChanged: (value) =>
                            //     validationService.changeTeamSize(value),
                            onSaved: (value) {
                              // user.occupation = value;
                              postForm.location = value;
                            },
                            decoration: InputDecoration(
                              hintText: "Location",
                              // errorText: validationService.teamSize.error,
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
                          // Column(
                          //   children: [
                          //     ListView.builder(
                          //         shrinkWrap: true,
                          //         itemCount: list.length,
                          //         physics: NeverScrollableScrollPhysics(),
                          //         itemBuilder: (context, index) {
                          //           return LocationWidget(
                          //             text: list[index],
                          //             controller: _controllers[index],
                          //             locationRemove: () {
                          //               print(list.toString());
                          //               setState(() {
                          //                 _controllers.removeAt(index);
                          //                 list.removeAt(index);
                          //               });
                          //             },
                          //           );
                          //         }),
                          //     FlatButton(
                          //       onPressed: () => addField(),
                          //       child: Align(
                          //         alignment: Alignment.topRight,
                          //         child: Text("Add More"),
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       height: 10,
                          //     ),
                          //   ],
                          // ),

                          TextFormField(
                            initialValue: postForm.estimatedPeople,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: Colors.purple,
                            ),
                            validator: (value) {
                              if (value.isEmpty)
                                return "Your No of estimated people is empty";
                            },
                            // inputFormatters: [
                            //   new LengthLimitingTextInputFormatter(
                            //       5), // for mobile
                            // ],
                            // onChanged: (value) =>
                            //     validationService.changeTeamSize(value),
                            onSaved: (value) {
                              // user.occupation = value;
                              postForm.estimatedPeople = value;
                            },
                            decoration: InputDecoration(
                              hintText: "No of estimated people",
                              // errorText: validationService.teamSize.error,
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
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  enableInteractiveSelection: false,
                                  focusNode: new AlwaysDisabledFocusNode(),
                                  keyboardType: TextInputType.url,
                                  style: TextStyle(
                                    color: Colors.purple,
                                  ),
                                  // onChanged: (value) {
                                  //   validationService.changeWhitePaper(value);
                                  // },
                                  // validator: (value) {
                                  //   if (value.isEmpty)
                                  //     return "Your Upload White Paper is empty";
                                  // },
                                  // onSaved: (value) {
                                  //   // user.occupation = value;
                                  // },
                                  decoration: InputDecoration(
                                    hintText: "Upload White Paper",
                                    // errorText:
                                    //     validationService.whitePaper.error,
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
                                onPressed: () {
                                  loadWhitePaper();
                                },
                                child: Text("Upload",
                                    style: TextStyle(color: Colors.white)),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    text:
                                        'In order to Recieve bids and investor request. you need to upload white Paper',
                                    style: TextStyle(color: Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(text: ''),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    GlowCheckbox(
                                      color: Theme.of(context).primaryColor,
                                      value: postForm.needServiceProvider,
                                      enable: true,
                                      onChange: (bool value) {
                                        print(value);
                                        setState(() {
                                          checkboxSelectedNeedInvestor =
                                              !checkboxSelectedNeedInvestor;
                                          postForm.needServiceProvider = value;
                                        });
                                      },
                                    ),
                                    SizedBox(width: 5),
                                    Text("Need Service Provider"),
                                    SizedBox(width: 5),
                                    GlowCheckbox(
                                      color: Theme.of(context).primaryColor,
                                      value: postForm.needInvestor,
                                      enable: true,
                                      onChange: (bool value) {
                                        print(value);
                                        setState(() {
                                          checkboxSelectedNeedSerive =
                                              !checkboxSelectedNeedSerive;
                                          postForm.needInvestor = value;
                                        });
                                      },
                                    ),
                                    SizedBox(width: 5),
                                    Text("Need Investor"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: RaisedButton(
                              onPressed: uploadingFile == false
                                  ? () {
                                      addPostIdeaSetup(context);
                                    }
                                  : () {
                                      _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "Uploading file. Please wait..."),
                                        ),
                                      );
                                    },
                              child: isLoading == true
                                  ? CircularProgressIndicator()
                                  : Text(
                                      "Add Your Idea Setup",
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
                        ],
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
          image.add({
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
        authProvider.uploadFile(files[i], "document").then((value) {
          Map sendMap = {
            "_id": value["_id"],
            "uriPath": value["uriPath"],
          };
          postForm.documents.add(sendMap);
          // postForm.documents.add(value);
          setState(() {
            uploadingFile = false;
          });
        });
      }
    } else {
      // User canceled the picker
    }
  }

  Future<void> loadAssetsDocument() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    // FilePickerResult result = await FilePicker.platform.pickFiles();
    postForm.documents = [];
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
          postForm.documents.add(sendMap);
          // postForm.documents.add(value);
          setState(() {
            uploadingFile = false;
          });
        });
      }
    }
  }

  Future<void> loadWhitePaper() async {
    // FilePickerResult result = await FilePicker.platform.pickFiles();
    setState(() {
      uploadingFile = true;
    });
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      print("the result is not null and we are uploading files.............");
      List<File> files = result.paths.map((path) => File(path)).toList();
      for (int i = 0; i < files.length; i++) {
        authProvider.uploadFile(files[i], "video").then((value) {
          Map sendMap = {
            "uriPath": value["uriPath"],
          };
          postForm.whitePaper = sendMap;
          print("Video data $value");
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
          postForm.uploadVideo = sendMap;
          print("Video data $value");
          setState(() {
            uploadingFile = false;
          });
        });
      }
    }
  }

  bool isLoading = false;
  final _formKey = new GlobalKey<FormState>();
  void addPostIdeaSetup(context) {
    setState(() {
      submited = true;
    });
    // &&
    //     postForm.documents.length > 0 &&
    //     postForm.uploadVideo != null
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        isLoading = true;
      });
      // Scaffold.of(context).showSnackBar(SnackBar(
      //   duration: Duration(seconds: 5),
      //   content: Text("Under Development"),
      //   // backgroundColor: Colors.red,
      // ));
      print("postForm: ${postForm.toSendMap()}");
      //Update an idea
      idea != null
          ? IdeasProvider()
              .updateIdea(postForm.id, token, postForm.toSendMap())
              .then((status) {
              if (status == true) {
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text("Your Idea Updated."),
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
            })
          //Post an Idea
          : IdeasServices()
              .postIdea(postForm.toSendMap(), token)
              .then((status) {
              if (status == true) {
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text("Your Idea Posted."),
                  duration: Duration(seconds: 4),
                ));
                setState(() {
                  isLoading = false;
                });
                Timer(Duration(seconds: 4), () {
                  Navigator.pushNamed(context, "/");
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

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
