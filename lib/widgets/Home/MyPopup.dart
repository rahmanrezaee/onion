import 'package:onion/pages/Analysis.dart';
import 'package:onion/statemanagment/analysis_provider.dart';
import 'package:onion/statemanagment/dropdown_provider.dart';
import 'package:onion/widgets/AnalysisWidget/extra/MyEmptyText.dart';
import 'package:onion/widgets/DropdownWidget/DropDownFormField.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../const/Size.dart';
import '../../const/color.dart';

import '../MyAppBarContainer.dart';

Future<void> showMyDialog({@required  context}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: ( context) {
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

class DialogContent extends StatelessWidget {
  const DialogContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build( context) {
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
                 Consumer<DropdownProvider>(
                    builder: ( context, dpvalue, Widget child) {
                  return Column(
                    children: [
                      Text(
                        'Let us know what all analytics you are intrested in?',
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: deviceSize(context).height * 0.03),
                      dpvalue.categoryList.isEmpty
                          ? FutureBuilder(
                              future: dpvalue.fetchItemsCategory(),
                              builder: (futureContext, snapshot) {
                                return MyEmptyText(myTxt: "Loading...");
                              },
                            )
                          : DropDownFormField(
                              value: dpvalue.categorySelected,
                              onChanged: (value) async {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                dpvalue.categorySelected = value;
                                await dpvalue.fetchItemsIndustry();
                              },
                              dataSource: dpvalue.categoryList.isEmpty
                                  ? []
                                  : dpvalue.categoryList.map((data) {
                                      return {
                                        "display": data.name,
                                        "value": data.name
                                      };
                                    }).toList(),
                              textField: 'display',
                              valueField: 'value',
                            ),
                      SizedBox(height: deviceSize(context).height * 0.03),
                      dpvalue.idustryList.isNotEmpty
                          ? DropDownFormField(
                              value: dpvalue.idustrySelected,
                              onChanged: (value) async {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                dpvalue.idustrySelected = value;
                                await dpvalue.fetchItemsType();
                              },
                              dataSource: dpvalue.idustryList.isEmpty
                                  ? []
                                  : dpvalue.idustryList.map((data) {
                                      return {
                                        "display": data.name,
                                        "value": data.name
                                      };
                                    }).toList(),
                              textField: 'display',
                              valueField: 'value',
                            )
                          : Text("No Item To Analysis"),
                      SizedBox(height: deviceSize(context).height * 0.03),
                      dpvalue.typeList.isNotEmpty
                          ? DropDownFormField(
                              value: dpvalue.typeSelected,
                              onChanged: (value) async {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                dpvalue.typeSelected = value;
                                await dpvalue.fetchCountryType(context);
                              },
                              dataSource: dpvalue.typeList.isEmpty
                                  ? []
                                  : dpvalue.typeList.map((data) {
                                      return {
                                        "display": data.title,
                                        "value": data.title
                                      };
                                    }).toList(),
                              textField: 'display',
                              valueField: 'value',
                            )
                          : Text("No Item To Analysis"),
                      SizedBox(height: deviceSize(context).height * 0.03),
                    ],
                  );
                }),
                Consumer<AnalysisProvider>(
                  builder: ( context, anavalue, Widget child) {
                    if (anavalue.countryInList.isEmpty) {
                      return DropDownFormField(
                              value: "no Item",
                              dataSource: [
                                {"display": "no Item", "value": "no Item"}
                              ],
                              textField: 'display',
                              valueField: 'value',
                            )
                          ;
                    } else {
                      return Column(
                        children: [
                          DropDownFormField(
                            value: anavalue.selectedCountry.country,
                            onChanged: (value) async {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());

                              anavalue.countryInList.forEach((element) {
                                if (element.country == value) {
                                  anavalue.changeCountryColors(element);
                                }
                              });
                              
                            },
                            dataSource: anavalue.countryInList.map((data) {
                              return {
                                "display": data.country,
                                "value": data.country
                              };
                            }).toList(),
                            textField: 'display',
                            valueField: 'value',
                          ),
                          SizedBox(height: deviceSize(context).height * 0.01),
                          SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                              color: middlePurple,
                              textColor: Colors.white,
                              elevation: 0,
                              child: Text("See Analysis"),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(color: middlePurple),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                  context,
                                  Analysis.routeName,
                                );
                              },
                            ),
                          ),
                        ],
                      );
                      // DropdownButtonFormField(items: null, onChanged: null);
                    }
                  },
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

class MyPopTxt extends StatelessWidget {
  final String myTxt;

  const MyPopTxt({
    Key key,
    this.myTxt,
  }) : super(key: key);

  @override
  Widget build( context) {
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
