import 'package:flutter/material.dart';
import 'package:onion/statemanagment/dropDownItem/AnalyticsProvider.dart';
import 'package:onion/statemanagment/dropDownItem/CategoryProvider.dart';
import 'package:onion/statemanagment/dropDownItem/IndustryProvider.dart';
import 'package:onion/statemanagment/dropDownItem/MyFlagState.dart';
import 'package:provider/provider.dart';

import '../const/Size.dart';
import '../const/color.dart';
import './AnalysisWidget/MyBigDropDown.dart';
import './AnalysisWidget/MySmallDropdown.dart';

class MyAppBarContainer extends StatefulWidget {
  final String categoryName;

  const MyAppBarContainer({Key key, this.categoryName}) : super(key: key);

  @override
  _MyAppBarContainerState createState() => _MyAppBarContainerState();
}

class _MyAppBarContainerState extends State<MyAppBarContainer> {
  Future<void> fetchCategory;
  Future<void> fetchIndustry;
  Future<void> fetchAnalytics;
  bool industryFlag;
  bool analyticsFlag;

  // bool industryFlag;
  // bool analyticsFlag;

  // Future<void> fetchAnalytics;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // industryFlag = false;
    // analyticsFlag = false;
  }

  @override
  Widget build(BuildContext context) {
    this.fetchCategory = Provider.of<CategoryProvider>(context, listen: false)
        .fetchItems(context);

    return Container(
      height: deviceSize(context).height * 0.16,
      padding: EdgeInsets.symmetric(
        horizontal: deviceSize(context).width * 0.04,
      ),
      decoration: BoxDecoration(
        color: middlePurple,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(
            deviceSize(context).height * 0.04,
          ),
          bottomLeft: Radius.circular(
            deviceSize(context).height * 0.04,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FutureBuilder(
                future: fetchCategory,
                builder: (futureContext, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text(
                      "loading...",
                      style: TextStyle(color: Colors.white),
                    );
                  } else {
                    if (snapshot.error != null) {
                      return Text(
                        "Error...",
                        style: TextStyle(color: Colors.white),
                      );
                    } else {
                      return Consumer<CategoryProvider>(
                        builder: (context, value, Widget child) {
                          // industryFlag = true;
                          if (value.items.isEmpty) {
                            return Text(
                              "loading...",
                              style: TextStyle(color: Colors.white),
                            );
                          } else {
                            // this.fetchIndustry = Provider.of<IndustryProvider>(
                            //   context,
                            //   listen: false,
                            // ).fetchItems(name: value.items[0].name, context: context);
                            return MySmallDropdown(
                              myisExpanded: false,
                              myDropDownList: value.items,
                              dropDownAroundColor: Colors.white,
                              dropDownColor: middlePurple,
                              txtColor: Colors.white,
                              iconColor: Colors.white,
                              futureType: "category",
                              firstVal: value.firstItem.name,
                            );
                          }
                        },
                      );
                    }
                  }
                },
              ),
              FutureBuilder(
                future: fetchIndustry,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text(
                      "loading...",
                      style: TextStyle(color: Colors.white),
                    );
                  } else {
                    if (snapshot.error != null) {
                      return Center(
                        child: Text("Error Occurred!"),
                      );
                    } else {
                      return Consumer<IndustryProvider>(
                        builder: (BuildContext context, value, Widget child) {
                          if (value.items.isEmpty) {
                            return Text(
                              "loading...",
                              style: TextStyle(color: Colors.white),
                            );
                          } else {
                            // this.fetchAnalytics =
                            //     Provider.of<AnalyticsProvider>(
                            //   context,
                            //   listen: false,
                            // ).fetchItems(name: value.items[0].name);
                            return value.items == null
                                ? Text(
                                    "loading...",
                                    style: TextStyle(color: Colors.white),
                                  )
                                : MySmallDropdown(
                                    myisExpanded: false,
                                    myDropDownList:
                                        value.items == null ? [] : value.items,
                                    dropDownAroundColor: Colors.white,
                                    dropDownColor: middlePurple,
                                    iconColor: Colors.white,
                                    txtColor: Colors.white,
                                    futureType: "industry",
                                    firstVal: value.items[0].name,
                                  );
                          }
                        },
                      );
                    }
                  }
                },
              ),
              FutureBuilder(
                future: fetchAnalytics,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text(
                      "loading...",
                      style: TextStyle(color: Colors.white),
                    );
                  } else {
                    if (snapshot.error != null) {
                      return Center(
                        child: Text("Error Occurred!"),
                      );
                    } else {
                      return Consumer<AnalyticsProvider>(
                        builder: (BuildContext context, value, Widget child) {
                          if (value.items.isEmpty) {
                            return Text(
                              "loading...",
                              style: TextStyle(color: Colors.white),
                            );
                          } else {
                            return MySmallDropdown(
                              myisExpanded: false,
                              myDropDownList:
                                  value.items == null ? [] : value.items,
                              dropDownAroundColor: Colors.white,
                              dropDownColor: middlePurple,
                              iconColor: Colors.white,
                              txtColor: Colors.white,
                              futureType: "analytics",
                              firstVal: value.firstItem.name,
                            );
                          }
                        },
                      );
                    }
                  }
                },
              ),
            ],
          ),
          MyBigDropDown(),
        ],
      ),
    );
  }
}
