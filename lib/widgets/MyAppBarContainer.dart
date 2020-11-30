import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onion/statemanagment/analysis_provider.dart';
import 'package:onion/statemanagment/dropDownItem/AnalyticsProvider.dart';
import 'package:onion/statemanagment/dropDownItem/CategoryProvider.dart';
import 'package:onion/statemanagment/dropDownItem/IndustryProvider.dart';
import 'package:onion/statemanagment/dropdown_provider.dart';
import 'package:provider/provider.dart';

import '../const/Size.dart';
import '../const/color.dart';
import './AnalysisWidget/MyBigDropDown.dart';
import './AnalysisWidget/MySmallDropdown.dart';

class MyAppBarContainer extends StatefulWidget {
  final String categoryName;
  final bool notLoading;

  const MyAppBarContainer({
    Key key,
    this.categoryName,
    this.notLoading = true,
  }) : super(key: key);

  @override
  _MyAppBarContainerState createState() => _MyAppBarContainerState();
}

class _MyAppBarContainerState extends State<MyAppBarContainer> {
  Future<void> fetchCategory;
  Future<void> fetchIndustry;
  bool isCatLoading = true;
  bool isAnaLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.notLoading) {
      Future.delayed(Duration.zero, () {
        this.fetchCategory = Provider.of<CategoryProvider>(
          context,
          listen: false,
        ).fetchItems(context).then((value) {
          isCatLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    return MyEmptyText(myTxt: "Loading...");
                  } else {
                    if (snapshot.error != null) {
                      return MyEmptyText(myTxt: "Error...  ");
                    } else {
                      return Consumer<CategoryProvider>(
                        builder: (
                          BuildContext consContext,
                          value,
                          Widget child,
                        ) {
                          if (value.items.isEmpty) {
                            return MyEmptyText(
                              myTxt:
                                  value.isLoading ? "loading..." : "Empty     ",
                            );
                          } else {
                            return MySmallDropdown(
                              myisExpanded: false,
                              myDropDownList:
                                  value.items.isEmpty ? [] : value.items,
                              dropDownAroundColor: Colors.white,
                              // myDropDownAnal: [],
                              dropDownColor: middlePurple,
                              iconColor: Colors.white,
                              txtColor: Colors.white,
                              futureType: "category",
                              firstVal: value.items[0].name,
                              dropDownWidth: deviceSize(context).width * 0.17,
                            );
                          }
                        },
                      );
                    }
                  }
                },
              ),
              Consumer<IndustryProvider>(
                builder: (BuildContext consContext, value, Widget child) {
                  if (value.items.isEmpty) {
                    return MyEmptyText(
                      myTxt: value.isLoading ? "loading..." : "Empty     ",
                    );
                  } else {
                    isAnaLoading = false;
                    return MySmallDropdown(
                      myisExpanded: false,
                      myDropDownList: value.items.isEmpty ? [] : value.items,
                      // myDropDownAnal: [],
                      dropDownAroundColor: Colors.white,
                      dropDownColor: middlePurple,
                      iconColor: Colors.white,
                      txtColor: Colors.white,
                      futureType: "industry",
                      dropDownWidth: deviceSize(context).width * 0.17,
                      firstVal: value.items[0].name,
                    );
                  }
                },
              ),
              Consumer<AnalyticsProvider>(
                builder: (BuildContext consContext, value, Widget child) {
                  if (value.items.isEmpty) {
                    return MyEmptyText(
                      myTxt: value.isLoading ? "loading..." : "Empty     ",
                    );
                  } else {
                    return MySmallDropdown(
                      myisExpanded: false,
                      myDropDownList: [],
                      dropDownAroundColor: Colors.white,
                      myDropDownAnal: value.items == null ? [] : value.items,
                      dropDownColor: middlePurple,
                      iconColor: Colors.white,
                      txtColor: Colors.white,
                      futureType: "analytics",
                      firstVal: value.items[0].title,
                      dropDownWidth: deviceSize(context).width * 0.17,
                    );
                  }
                },
              ),
            ],
          ),
          Consumer<AnalyticsProvider>(
            builder: (BuildContext context, value, Widget child) {
              if (value.countryItems.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10),
                  child: Text(
                    value.isLoading ? "loading..." : "Empty     ",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              } else {
                return MyBigDropDown(
                  myDropDownAnal:
                      value.countryItems.isNotEmpty ? value.countryItems : [],
                );
              }
            },
          ),
        //   Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: <Widget>[
        //       Expanded(
        //         child: SmallDropdown(
        //           futureType: "category",
        //         ),
        //       ),
        //       Expanded(
        //         child: SmallDropdown(
        //           futureType: "industry",
        //         ),
        //       ),
        //       Expanded(
        //         child: SmallDropdown(
        //           futureType: "analytics",
        //         ),
        //       ),
        //     ],
        //   ),
        //   Padding(
        //     padding: EdgeInsets.only(
        //       top: deviceSize(context).height * 0.03,
        //       left: deviceSize(context).width * 0.03,
        //       right: deviceSize(context).width * 0.03,
        //     ),
        //     child: Consumer<AnalysisProvider>(
        //       builder: (BuildContext context, anavalue, Widget child) {
        //         return DropdownButtonHideUnderline(
        //           child: DropdownButton(
        //             value: anavalue.selectedCountry.countryCode,
        //             iconDisabledColor: Colors.white,
        //             iconEnabledColor: Colors.white,
        //             dropdownColor: middlePurple,
        //             isDense: true,
        //             items: anavalue.countryInList.map((e) {
        //               return DropdownMenuItem(
        //                 child: Text(
        //                   e.country,
        //                   textScaleFactor: 1.4,
        //                   style: TextStyle(
        //                     color: Colors.white,
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //                 ),
        //                 value: e.countryCode,
        //               );
        //             }).toList(),
        //             onChanged: (value) {
        //               anavalue.country.forEach((element) {
        //                 if (element.countryCode == value) {
        //                   anavalue.changeCountryColors(element);
        //                 }
        //               });
        //             },
        //           ),
        //         );
        //       },
        //     ),
        //   )
        ],
      ),
    );
  }
}

class MyEmptyText extends StatelessWidget {
  final String myTxt;
  final Color mColor;

  const MyEmptyText({Key key, this.myTxt, this.mColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(deviceSize(context).width * 0.02),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(5),
      ),
      child: SizedBox(
        width: deviceSize(context).width * 0.2,
        child: Text(
          myTxt,
          textScaleFactor: 0.7,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
