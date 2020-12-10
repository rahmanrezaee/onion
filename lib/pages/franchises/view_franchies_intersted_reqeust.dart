import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/const/color.dart';
import 'package:onion/models/FranchiesModel.dart';
import 'package:onion/models/requestFranchiesModel.dart';
import 'package:onion/statemanagment/franchise_provider.dart';
import 'package:onion/widgets/Franchise/interstedDiscription.dart';
import 'package:onion/widgets/MyLittleAppbar.dart';
import 'package:onion/widgets/PlayWidget/SingleVideoPlayer.dart';
import 'package:provider/provider.dart';

class viewFranchiesInterstedReqeust extends StatefulWidget {
  static final routeName = "viewFranchiesInterstedReqeust";

  Map dat;

  viewFranchiesInterstedReqeust(
    this.dat, {
    Key key,
  }) : super(key: key);

  @override
  _viewFranchiesInterstedReqeustState createState() =>
      _viewFranchiesInterstedReqeustState();
}

class _viewFranchiesInterstedReqeustState
    extends State<viewFranchiesInterstedReqeust> {
  RequestFranchiesModel franchiesRequestModel;
  FranchiesModel franchiesModel;
  bool _agreeWithTerm = false;

  @override
  initState() {
    super.initState();
    franchiesModel = widget.dat["franch"];
    franchiesRequestModel = widget.dat["request"];
  }

  bool isSubmited = false;

  @override
  Widget build(BuildContext context) {
    var providerFran = Provider.of<FranchiesProvider>(context, listen: false);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: MyLittleAppbar(
          myTitle: "View Franchies Interst Request",
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(deviceSize(context).height * 0.01),
        child: RefreshIndicator(
          onRefresh: () async {
            // value.clearToNullList();
            // await value.getFranchies(isMyList: true);
          },
          child: Column(
            children: [
              DescriptionIntersted(
                franchiesRequestModel: franchiesRequestModel,
                franchiesModel: franchiesModel,
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 8.0,
                    right: 8.0,
                    bottom: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Message: ${franchiesModel.requirments}",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Upload Documents",
                        style: TextStyle(fontSize: 18, color: deepBlue),
                      ),
                      SizedBox(height: 5),
                      Container(
                        height: 80,
                        child: ListView.builder(
                          itemCount: franchiesModel.uploadDocuments.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Container(
                                  height: 50,
                                  width: 50,
                                  child: franchiesModel.uploadDocuments[index]
                                                  ["type"] ==
                                              "jpg" ||
                                          franchiesModel.uploadDocuments[index]
                                                  ["type"] ==
                                              "jpeg" ||
                                          franchiesModel.uploadDocuments[index]
                                                  ["type"] ==
                                              "png"
                                      ? Image.file(File(franchiesModel
                                          .uploadDocuments[index]['path']))
                                      : Icon(Icons.file_present)),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Video",
                        style: TextStyle(fontSize: 18, color: deepBlue),
                      ),
                      SizedBox(height: 5),
                      SingleVideoPlayer(
                          clipsUrl: franchiesModel.uploadVideo[0]["uriPath"]),
                      SizedBox(
                        height: 10,
                      ),
                      MyTxtRow(
                        firstTxt: "Date",
                        secondTxt: Jiffy("${franchiesRequestModel.date}").yMMMd,
                      ),
                      MyTxtRow(
                          firstTxt: "Refrence",
                          secondTxt:
                              "${franchiesRequestModel.users.join(', ')}"),
                      SizedBox(height: 20),
                      Visibility(
                        visible: !isSubmited,
                        child: Column(
                          children: [
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
                                          text:
                                              'Term and Condition and contract',
                                          style: TextStyle(color: middlePurple),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              // open desired screen
                                              print(
                                                  "Ali Azad is agree with term and condition");
                                            },
                                        ),
                                        TextSpan(
                                            text:
                                                ' while Requesting this Franchise!'),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                onPressed: () async {
                                  var result = await providerFran
                                      .pendingRequestFrenchies(
                                          franchiesRequestModel.id, true);
                                  print("result $result");
                                  setState(() {
                                    isSubmited = true;
                                  });
                                },
                                child: Text(
                                  "Accept",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                    )),
                                onPressed: () async {
                                  var result = await providerFran
                                      .pendingRequestFrenchies(
                                          franchiesRequestModel.id, false);
                                  print("result $result");
                                  setState(() {
                                    isSubmited = true;
                                  });
                                },
                                child: Text(
                                  "Decline",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
