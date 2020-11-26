import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onion/models/circularChart.dart';
import 'package:onion/statemanagment/analysis_provider.dart';
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

  // Future<void> fetchAnalytics;

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
          Padding(
            padding: EdgeInsets.only(
              top: deviceSize(context).height * 0.03,
              left: deviceSize(context).width * 0.03,
              right: deviceSize(context).width * 0.03,
            ),
            child: Consumer<AnalysisProvider>(
              builder: (BuildContext context, anavalue, Widget child) {
                return DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: anavalue.selectedCountry.countryCode,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    dropdownColor: middlePurple,
                    isDense: true,
                    items: anavalue.country.map((e) {
                      return DropdownMenuItem(
                        child: Text(
                          e.country,
                          textScaleFactor: 1.4,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        value: e.countryCode,
                      );
                    }).toList(),
                    onChanged: (value) {
                      anavalue.country.forEach((element) {
                        if (element.countryCode == value) {
                          anavalue.changeCountryColors(element);
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),
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

// FutureBuilder(
//   future: fetchCategory,
//   builder: (futureContext, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return Text(
//         "loading...",
//         style: TextStyle(color: Colors.white),
//       );
//     } else {
//       if (snapshot.error != null) {
//         return Text(
//           "Error...",
//           style: TextStyle(color: Colors.white),
//         );
//       } else {
//         return Consumer<CategoryProvider>(
//           builder: (conContext, value, Widget child) {
//             if (categoryFlag) {
//               _categoryValue = value.items[0].name;
//             }
//             categoryFlag = false;
//             if (value.items.isEmpty) {
//               return Text(
//                 "loading...",
//                 style: TextStyle(color: Colors.white),
//               );
//             } else {
//               return Container(
//                 padding: EdgeInsets.all(
//                     deviceSize(context).width * 0.01),
//                 margin: EdgeInsets.symmetric(
//                   horizontal: deviceSize(context).width * 0.01,
//                 ),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.white),
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: Center(
//                     child: DropdownButton(
//                       value: _categoryValue,
//                       isExpanded: false,
//                       iconDisabledColor: Colors.white,
//                       iconEnabledColor: Colors.white,
//                       dropdownColor: middlePurple,
//                       onChanged: (value) async {
//                         setState(() {
//                           _categoryValue = value;
//                         });
//                         // await industryProvider.fetchItems(
//                         //   name: value,
//                         //   context: context,
//                         // );
//                         Provider.of<IndustryProvider>(
//                           context,
//                           listen: false,
//                         ).fetchItems(name: _categoryValue);
//                       },
//                       isDense: true,
//                       items: value.items.isNotEmpty
//                           ? value.items.map((e) {
//                               print("Mahdi: ${e.id}");
//                               return DropdownMenuItem(
//                                 child: SizedBox(
//                                   width:
//                                       deviceSize(context).width *
//                                           0.19,
//                                   child: Text(
//                                     "${e.name}",
//                                     overflow:
//                                         TextOverflow.ellipsis,
//                                     maxLines: 1,
//                                     textScaleFactor: 0.7,
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 value: e.name,
//                               );
//                             }).toList()
//                           : null,
//                     ),
//                   ),
//                 ),
//               );
//             }
//           },
//         );
//       }
//     }
//   },
// ),
// FutureBuilder(
//   future: fetchCategory,
//   builder: (futureContext, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return Text(
//         "loading...",
//         style: TextStyle(color: Colors.white),
//       );
//     } else {
//       if (snapshot.error != null) {
//         return Center(
//           child: Text("Error Occurred!"),
//         );
//       } else {
//         return Consumer<IndustryProvider>(
//           builder: (BuildContext conContext, value, Widget child) {
//             if (value.items.isEmpty) {
//               return Text(
//                 "loading...",
//                 style: TextStyle(color: Colors.white),
//               );
//             } else {
//               return Consumer<IndustryProvider>(
//                 builder: (context, value, Widget child) {
//                   if (industryFlag) {
//                     _industryValue = value.items[0].name;
//                   }
//                   industryFlag = false;
//                   if (value.items.isEmpty) {
//                     return Text(
//                       "loading...",
//                       style: TextStyle(color: Colors.white),
//                     );
//                   } else {
//                     return Container(
//                       padding: EdgeInsets.all(
//                           deviceSize(context).width * 0.01),
//                       margin: EdgeInsets.symmetric(
//                         horizontal:
//                             deviceSize(context).width * 0.01,
//                       ),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.white),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: DropdownButtonHideUnderline(
//                         child: Center(
//                           child: DropdownButton(
//                             value: _industryValue,
//                             isExpanded: false,
//                             iconDisabledColor: Colors.white,
//                             iconEnabledColor: Colors.white,
//                             dropdownColor: middlePurple,
//                             onChanged: (value) async {
//                               setState(() {
//                                 _industryValue = value;
//                               });
//                               // await industryProvider.fetchItems(
//                               //   name: value,
//                               //   context: context,
//                               // );
//                               Provider.of<AnalyticsProvider>(
//                                 context,
//                                 listen: false,
//                               ).fetchItems(
//                                 name: _industryValue,
//                               );
//                             },
//                             isDense: true,
//                             items: value.items.isNotEmpty
//                                 ? value.items.map((e) {
//                                     print("Mahdi: ${e.id}");
//                                     return DropdownMenuItem(
//                                       child: SizedBox(
//                                         width: deviceSize(context)
//                                                 .width *
//                                             0.19,
//                                         child: Text(
//                                           "${e.name}",
//                                           overflow: TextOverflow
//                                               .ellipsis,
//                                           maxLines: 1,
//                                           textScaleFactor: 0.7,
//                                           style: TextStyle(
//                                               color:
//                                                   Colors.white),
//                                         ),
//                                       ),
//                                       value: e.name,
//                                     );
//                                   }).toList()
//                                 : null,
//                           ),
//                         ),
//                       ),
//                     );
//                   }
//                 },
//               );
//             }
//           },
//         );
//       }
//     }
//   },
// ),
