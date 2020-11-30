import 'package:onion/pages/Analysis.dart';
import 'package:onion/statemanagment/SaveAnalModel.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/widgets/Home/MyPopup.dart';
import 'package:onion/widgets/SmallDropDown.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:onion/widgets/AnalysisWidget/MyBigDropDown.dart';
import '../const/Size.dart';
import '../const/color.dart';
import '../statemanagment/dropDownItem/AnalyticsProvider.dart';
import '../statemanagment/dropDownItem/CategoryProvider.dart';
import '../statemanagment/dropDownItem/IndustryProvider.dart';
import './AnalysisWidget/MySmallDropdown.dart';

import './MyAppBarContainer.dart';
import 'Home/MyGoogleMap.dart';

Future<void> tempShowMyDialog({@required BuildContext context}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.only(
          bottom: deviceSize(context).height * 0.03,
        ),
        titlePadding: EdgeInsets.zero,
        content: DialogContent(),
      );
    },
  );
}

class DialogContent extends StatefulWidget {
  const DialogContent({
    Key key,
  }) : super(key: key);

  @override
  _DialogContentState createState() => _DialogContentState();
}

class _DialogContentState extends State<DialogContent> {
  Future<void> fetchCategory;
  bool isCatLoading = true;
  bool isAnaLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchCategory = Provider.of<CategoryProvider>(
      context,
      listen: false,
    ).fetchItems(context).then((value) {
      isCatLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.cancel_outlined,
                color: middlePurple,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: deviceSize(context).height * 0.02,
              right: deviceSize(context).width * 0.03,
              left: deviceSize(context).width * 0.03,
            ),
            child: Column(
              children: [
                Text(
                  'Add New Analysis',
                  textScaleFactor: 1,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: deviceSize(context).height * 0.03),
                Consumer<CategoryProvider>(
                  builder: (
                    BuildContext consContext,
                    value,
                    Widget child,
                  ) {
                    if (value.items.isEmpty) {
                      print("Mahdia IF ");
                      return MyPopTxt(
                        myTxt: value.isLoading ? "loading..." : "Empty",
                      );
                    } else {
                      print("Mahdia Else ");
                      // return Text("Mahdi");
                      return MySmallDropdown(
                        iconColor: Colors.black,
                        myisExpanded: true,
                        myDropDownList: value.items,
                        dropDownAroundColor: Colors.grey,
                        txtColor: Colors.grey,
                        dropDownColor: Colors.white,
                        futureType: "category",
                        firstVal: value.items[0].name,
                        dropDownWidth: deviceSize(context).width * 0.7,
                        hintColor: Colors.grey,
                      );
                    }
                  },
                ),
                SizedBox(height: deviceSize(context).height * 0.03),
                Consumer<IndustryProvider>(
                  builder: (
                    BuildContext consContext,
                    value,
                    Widget child,
                  ) {
                    if (value.items.isEmpty) {
                      print("Mahdia IF ");
                      return MyPopTxt(
                        myTxt: value.isLoading ? "loading..." : "Empty",
                      );
                    } else {
                      print("Mahdia Else ");
                      // return Text("Mahdi");
                      return MySmallDropdown(
                        iconColor: Colors.black,
                        myisExpanded: true,
                        myDropDownList: value.items,
                        dropDownAroundColor: Colors.grey,
                        txtColor: Colors.grey,
                        dropDownColor: Colors.white,
                        firstVal: value.items[0].name,
                        futureType: "industry",                        hintColor: Colors.grey,

                        dropDownWidth: deviceSize(context).width * 0.7,
                      );
                    }
                  },
                ),
                SizedBox(height: deviceSize(context).height * 0.03),
                Consumer<AnalyticsProvider>(
                  builder: (
                    BuildContext consContext,
                    value,
                    Widget child,
                  ) {
                    if (value.items.isEmpty) {
                      return MyPopTxt(
                        myTxt: value.isLoading ? "loading..." : "Empty",
                      );
                    } else {
                      print("Mahdia Else ");
                      // return Text("Mahdi");
                      return MySmallDropdown(
                        iconColor: Colors.black,
                        myisExpanded: true,
                        hintColor: Colors.grey,
                        myDropDownList: [],
                        myDropDownAnal: value.items,
                        dropDownAroundColor: Colors.grey,
                        txtColor: Colors.grey,
                        dropDownColor: Colors.white,
                        firstVal: value.items[0].title,
                        futureType: "analytics",
                        dropDownWidth: deviceSize(context).width * 0.7,
                      );
                    }
                  },
                ),
                SizedBox(height: deviceSize(context).height * 0.03),
                Consumer<AnalyticsProvider>(
                  builder: (BuildContext context, value, Widget child) {
                    if (value.countryItems.isEmpty) {
                      return MyPopTxt(
                        myTxt: value.isLoading ? "loading..." : "Empty",
                      );
                    } else {
                      return SmallDropCount(
                        myDropDownList: value.countryItems.isNotEmpty
                            ? value.countryItems
                            : [],
                        dropDownAroundColor: Colors.grey,
                        dropDownColor: Colors.white,
                        iconColor: Colors.black,
                        myisExpanded: true,
                        txtColor: Colors.grey,
                        dropDownWidth: deviceSize(context).width * 0.7,
                      );
                    }
                  },
                ),
                SizedBox(height: deviceSize(context).height * 0.01),
                SizedBox(
                  width: deviceSize(context).width * 0.3,
                  child: Consumer<AnalyticsProvider>(
                    builder: (BuildContext context, value, Widget child) {
                      return RaisedButton(
                        color: middlePurple,
                        textColor: Colors.white,
                        elevation: 0,
                        child: Text("Add"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(color: middlePurple),
                        ),
                        onPressed: () async {
                          value.clearBoth();
                          if (value.getAnalId == null ||
                              value.getCountryId == null) {
                            print(
                                "Mahdi:If: ${value.getAnalId} ${value.getCountryId}");
                            return;
                          } else {
                            print(
                                "Mahdi:else: ${value.getAnalId} ${value.getCountryId}");
                            String token = Provider.of<Auth>(
                              context,
                              listen: false,
                            ).token;
                            Provider.of<SaveAnalProvider>(
                              context,
                              listen: false,
                            )
                                .saveAnalysis(
                              token: token,
                              analysisId: value.getAnalId,
                              region: value.getCountryId,
                            )
                                .then((value) {
                              Provider.of<SaveAnalProvider>(
                                context,
                                listen: false,
                              ).getAnalysis(token: token);
                              Navigator.pop(context);
                            });
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class MyPopTxt extends StatelessWidget {
  final String myTxt;
  const MyPopTxt({
    Key key,
    this.myTxt,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceSize(context).width * 0.8,
      padding: EdgeInsets.all(deviceSize(context).width * 0.02),
      margin: EdgeInsets.symmetric(
        horizontal: deviceSize(context).width * 0.01,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: SizedBox(
        width: deviceSize(context).width * 0.19,
        child: Text(
          myTxt,
          textScaleFactor: 0.8,
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}