import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onion/statemanagment/MyDropDownState.dart';
import 'package:onion/statemanagment/analysis_provider.dart';
import 'package:onion/statemanagment/dropdown_provider.dart';
import 'package:provider/provider.dart';

import '../const/Size.dart';
import '../const/color.dart';
import './AnalysisWidget/MyBigDropDown.dart';
import './AnalysisWidget/MySmallDropdown.dart';
import './AnalysisWidget/extra/MyEmptyText.dart';
import 'AnalysisWidget/AnaylsisDropdownWidget.dart';

class MyAppBarContainer extends StatelessWidget {
  @override
  Widget build(context) {
    // var pro = Provider.of<DropdownProvider>(context, listen: false);
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
          Consumer<DropdownProvider>(
            builder: (context, dpvalue, Widget child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  dpvalue.categoryList == null
                      ? FutureBuilder(
                          future: dpvalue.fetchItemsCategory(),
                          builder: (futureContext, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return MyEmptyText(myTxt: "Loading...");
                            } else {
                              if (snapshot.connectionState ==
                                  ConnectionState.done)
                                return MyEmptyText(myTxt: "Done");
                            }
                          },
                        )
                      : dpvalue.categoryList.isEmpty
                          ? MyEmptyText(myTxt: "Empty")
                          : MySmallDropdown(
                              myisExpanded: false,
                              myDropDownList: dpvalue.categoryList.isEmpty
                                  ? []
                                  : dpvalue.categoryList,
                              dropDownAroundColor: Colors.white,
                              dropDownColor: middlePurple,
                              iconColor: Colors.white,
                              txtColor: Colors.white,
                              onChange: (value) async {
                                dpvalue.categorySelected = value;
                                await dpvalue.fetchItemsIndustry();
                              },
                              value: dpvalue.categorySelected,
                              dropDownWidth: deviceSize(context).width * 0.17,
                            ),
                  dpvalue.idustryList != null
                      ? dpvalue.idustryList.isEmpty
                          ? MyEmptyText(myTxt: "Empty")
                          : MySmallDropdown(
                              myisExpanded: false,
                              myDropDownList: dpvalue.idustryList.isEmpty
                                  ? []
                                  : dpvalue.idustryList,
                              dropDownAroundColor: Colors.white,
                              dropDownColor: middlePurple,
                              iconColor: Colors.white,
                              txtColor: Colors.white,
                              onChange: (value) async {
                                dpvalue.idustrySelected = value;
                                await dpvalue.fetchItemsType();
                              },
                              value: dpvalue.idustrySelected,
                              dropDownWidth: deviceSize(context).width * 0.17,
                            )
                      : MyEmptyText(myTxt: "Selected Category"),
                  dpvalue.typeList != null
                      ? dpvalue.idustryList.isEmpty
                          ? MyEmptyText(myTxt: "Empty")
                          : AnaylsisDropDown(
                              myisExpanded: false,
                              myDropDownList: dpvalue.typeList.isEmpty
                                  ? []
                                  : dpvalue.typeList,
                              dropDownAroundColor: Colors.white,
                              // myDropDownAnal: [],

                              dropDownColor: middlePurple,
                              iconColor: Colors.white,
                              txtColor: Colors.white,
                              onChange: (value) async {
                                dpvalue.typeSelected = value;
                                await dpvalue.fetchCountryType(context);
                              },

                              value: dpvalue.typeSelected,
                              dropDownWidth: deviceSize(context).width * 0.17,
                            )
                      : MyEmptyText(myTxt: "Selected Industry"),
                ],
              );
            },
          ),
          Consumer<AnalysisProvider>(
            builder: (context, anavalue, Widget child) {
              if (anavalue.countryInList.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10),
                  child: Text(
                    "Empty List",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              } else {
                return MyBigDropDown(
                  myDropDownAnal: anavalue.countryInList.isNotEmpty
                      ? anavalue.countryInList
                      : [],
                  firstVal: anavalue.selectedCountry.country,
                  onChange: (value) {
                    anavalue.countryInList.forEach((element) {
                      if (element.country == value) {
                        anavalue.changeCountryColors(element);
                      }
                    });
                  },
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
          // Padding(
          //   padding: EdgeInsets.only(
          //     top: deviceSize(context).height * 0.03,
          //     left: deviceSize(context).width * 0.03,
          //     right: deviceSize(context).width * 0.03,
          //   ),
          //   child: Consumer<AnalysisProvider>(
          //     builder: ( context, anavalue, Widget child) {
          //       return DropdownButtonHideUnderline(
          //         child: DropdownButton(
          //           value: anavalue.selectedCountry.countryCode,
          //           iconDisabledColor: Colors.white,
          //           iconEnabledColor: Colors.white,
          //           dropdownColor: middlePurple,
          //           isDense: true,
          //           items: anavalue.countryInList.isEmpty ? anavalue.countryInList.map((e) {
          //             return DropdownMenuItem(
          //               child: Text(
          //                 e.country,
          //                 textScaleFactor: 1.4,
          //                 style: TextStyle(
          //                   color: Colors.white,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //               value: e.countryCode,
          //             );
          //           }).toList(),
          //           onChanged: (value) {
          //             anavalue.country.forEach((element) {
          //               if (element.countryCode == value) {
          //                 anavalue.changeCountryColors(element);
          //               }
          //             });
          //           },
          //         ),
          //       );
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}
