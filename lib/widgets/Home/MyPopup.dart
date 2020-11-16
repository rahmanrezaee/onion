import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:onion/widgets/AnalysisWidget/MyBigDropDown.dart';
import '../../const/Size.dart';
import '../../const/color.dart';
import '../../statemanagment/dropDownItem/AnalyticsProvider.dart';
import '../../statemanagment/dropDownItem/CategoryProvider.dart';
import '../../statemanagment/dropDownItem/IndustryProvider.dart';
import '../AnalysisWidget/MySmallDropdown.dart';

import '../MyAppBarContainer.dart';

Future<void> showMyDialog({@required BuildContext context}) async {
  bool isCatLoading = true;
  bool isAnaLoading = true;

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
        // actions: <Widget>[
        //   TextButton(
        //     child: Text('Approve'),
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //   ),
        // ],
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
                  'Let us know what all analytics you are intrested in?',
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
                      return MyEmptyText(
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
                      return MyEmptyText(
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
                        futureType: "industry",
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
                      print("Mahdia IF ");
                      return MyEmptyText(
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
                        futureType: "analytics",
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
                      print("Mahdi IF ");
                      return MyEmptyText(
                        myTxt: value.isLoading ? "loading..." : "Empty",
                      );
                    } else {
                      print("Mahdi Else ");
                      // return Text("Mahdi");
                      return MySmallDropdown(
                        iconColor: Colors.black,
                        myisExpanded: true,
                        myDropDownList: value.items,
                        dropDownAroundColor: Colors.grey,
                        txtColor: Colors.grey,
                        dropDownColor: Colors.white,
                        firstVal: value.items[0].name,
                        futureType: "analytics",
                      );
                    }
                  },
                ),
                SizedBox(height: deviceSize(context).height * 0.01),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: middlePurple,
                    textColor: Colors.white,
                    elevation: 0,
                    child: Text("Save"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: middlePurple),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.white,
                    elevation: 0,
                    textColor: middlePurple,
                    child: Text("Manage Analytics"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: middlePurple),
                    ),
                    onPressed: () {},
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
