import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:number_display/number_display.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/const/color.dart';
import 'package:onion/pages/Analysis.dart';
import 'package:onion/pages/authentication/Login.dart';
import 'package:onion/statemanagment/SaveAnalModel.dart';
import 'package:onion/statemanagment/analysis_provider.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/statemanagment/dropdown_provider.dart';
import 'package:onion/widgets/AnalysisWidget/Charts/TableChart.dart';
import 'package:onion/widgets/AnalysisWidget/Charts/pie.dart';
import 'package:onion/widgets/AnalysisWidget/MyAlert.dart';
import 'package:onion/widgets/DropdownWidget/DropDownFormField.dart';
import 'package:onion/widgets/Home/MyGoogleMap.dart';
import 'package:onion/widgets/dashboardWidget/MyBtn.dart';
import 'package:onion/widgets/dashboardWidget/savedAnalysis.dart';
import 'package:onion/widgets/temp_popup.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  static const routeName = "analysis";
  // final Function openDrawer;

  const Dashboard({Key key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  final myController = TextEditingController();
  GlobalKey<FormState> _formKey;

  _formSub(BuildContext context) async {
    print("Mahdi: ${myController.text}");
    if (!_formKey.currentState.validate()) {
      return;
    }

    print("Mahdi:After ${myController.text}");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _formKey = null;
    myController.dispose();
  }

  final display = createDisplay(
    length: 3,
    decimal: 0,
  );
  final displayDigitOnly = new NumberFormat("#,##0", "en_US");

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Dashboard",
            textAlign: TextAlign.center,
            textScaleFactor: 1.2,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: MyAlertIcon(num: 3),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            MyGoogleMap(
              key: widget.key,
            ),
            Consumer<AnalysisProvider>(
                builder: (BuildContext context, analysisValue, Widget child) {
              return analysisValue.country != null
                  ? Column(children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Text(
                                "View By:",
                                textAlign: TextAlign.start,
                                style: new TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 18.0),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: DropDownFormField(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 0,
                                        horizontal: 3,
                                      ),
                                      onChanged: (value) {
                                        analysisValue.setchartType(value);
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                      },
                                      value: analysisValue.chartTypeSelected,
                                      dataSource: analysisValue.chartTypes,
                                      textField: 'display',
                                      valueField: 'value',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  // Visibility(
                                  //   visible:
                                  //       analysisValue.chartTypeSelected == "line",
                                  //   child: Expanded(
                                  //     child: DropDownFormField(
                                  //       onChanged: (value) {
                                  //         analysisValue.setbarChartType(value);
                                  //         FocusScope.of(context)
                                  //             .requestFocus(new FocusNode());
                                  //       },
                                  //       value: analysisValue.barSelectType,
                                  //       dataSource: analysisValue.barType,
                                  //       textField: 'display',
                                  //       valueField: 'value',
                                  //     ),
                                  //   ),
                                  // ),
                                  Visibility(
                                    visible: analysisValue.chartTypeSelected ==
                                        "pie",
                                    child: Expanded(
                                      child: DropDownFormField(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 0,
                                          horizontal: 3,
                                        ),
                                        onChanged: (value) {
                                          analysisValue.setpieChartType(value);
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                        },
                                        value: analysisValue.pieSelectType,
                                        dataSource: analysisValue.pieType,
                                        textField: 'display',
                                        valueField: 'value',
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: RaisedButton(
                                      elevation: 0,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      color: middlePurple,
                                      child: Text(
                                        "Save Data",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        auth.token != null
                                            ? tempShowMyDialog(context: context)
                                            : Navigator.pushNamed(
                                                context,
                                                Login.routeName,
                                              );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10),
                      Visibility(
                        visible: analysisValue.chartTypeSelected == "pie",
                        child: PieChartAnalysisWidget(analysisValue),
                      ),
                      // Visibility(
                      //   visible: analysisValue.chartTypeSelected == "line",
                      //   child: Container(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child:
                      //         analysisValue.selectedCountry.countryCode != "ALL"
                      //             ? SplineDefault(widget.key)
                      //             : Text("Please Select A country to analysis"),
                      //   ),
                      // ),
                      Visibility(
                        visible: analysisValue.chartTypeSelected == "table",
                        child: TableChart(analysisValue.tableSatatis),
                      ),
                      Visibility(
                        visible: analysisValue.chartTypeSelected == "date",
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Card(
                                    elevation: 4,
                                    margin: EdgeInsets.all(10),
                                    child: Container(
                                      width: 200,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              "Conformed",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 8.0),
                                            child: Text(
                                              "${displayDigitOnly.format(analysisValue.selectedCountry.totalConfirmed)}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.red[400],
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 4,
                                    margin: EdgeInsets.all(10),
                                    child: Container(
                                      width: 200,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              "Active",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 8.0),
                                            child: Text(
                                              "${displayDigitOnly.format(analysisValue.selectedCountry.totalConfirmed - analysisValue.selectedCountry.totalDeaths - analysisValue.selectedCountry.totalRecovered)}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 4,
                                    margin: EdgeInsets.all(10),
                                    child: Container(
                                      width: 200,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              "Recoverd",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 8.0),
                                            child: Text(
                                              "${displayDigitOnly.format(analysisValue.selectedCountry.totalRecovered)}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 4,
                                    margin: EdgeInsets.all(10),
                                    child: Container(
                                      width: 200,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              "Deaths",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 8.0),
                                            child: Text(
                                              "${displayDigitOnly.format(analysisValue.selectedCountry.totalDeaths)}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ])
                  : FutureBuilder(
                      future: analysisValue.getAnalysisData(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      });
            }),
            Column(
              children: [
                Consumer3<SaveAnalProvider, DropdownProvider, AnalysisProvider>(
                  builder: (consContext, consValue, drValue, anaValue, child) {
                    return Column(
                      children: [
                        Divider(color: Colors.grey),
                        Container(
                          padding: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "My Saved Analysis",
                                textScaleFactor: 1.1,
                                style: TextStyle(color: Colors.black),
                              ),
                              GestureDetector(
                                onTap: () {
                                  auth.token != null
                                      ? tempShowMyDialog(context: context)
                                      : Navigator.pushNamed(
                                          context,
                                          Login.routeName,
                                        );
                                },
                                child: Icon(
                                  Icons.add_circle,
                                  color: firstPurple,
                                  size: deviceSize(context).height * 0.055,
                                ),
                              ),
                            ],
                          ),
                        ),
                        consValue.items != null
                            ? consValue.items.isEmpty
                                ? Container(
                                    height: 80,
                                    alignment: Alignment.center,
                                    child: Text("Empty List"),
                                  )
                                : Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    height: deviceSize(context).height * 0.4,
                                    child: Scrollbar(
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: consValue.items.length,
                                        itemBuilder: (listContext, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, Analysis.routeName);

                                              drValue.categorySelected =
                                                  consValue
                                                      .items[index].category;
                                              drValue.idustrySelected =
                                                  consValue
                                                      .items[index].industry;
                                              drValue.typeSelected =
                                                  consValue.items[index].title;
                                              anaValue.country
                                                  .forEach((element) {
                                                if (element.country ==
                                                    consValue
                                                        .items[index].region)
                                                  anaValue.changeCountryColors(
                                                      element);
                                              });
                                              // dp.country = consValue.items[index].title;
                                            },
                                            child: MyCardItem(
                                              onDelete: (value) {
                                                consValue.deleteAnalysis(
                                                  id: value,
                                                );
                                              },
                                              id: consValue.items[index].id,
                                              analysis:
                                                  consValue.items[index].title,
                                              category: consValue
                                                  .items[index].category,
                                              industry: consValue
                                                  .items[index].industry,
                                              region:
                                                  consValue.items[index].region,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                            : FutureBuilder(
                                future: consValue.getAnalysis(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(
                                      height: 80,
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return Container(
                                      height: 80,
                                      alignment: Alignment.center,
                                      child: Text("Error In Fetch Data"),
                                    );
                                  }
                                },
                              )
                      ],
                    );
                  },
                ),
                Divider(color: Colors.grey),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Search Users by Social",
                        textScaleFactor: 1.1,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Card(
                    margin: EdgeInsets.all(15),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: deviceSize(context).height * 0.03,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MySocialIcon(
                                myImg: FaIcon(
                                  FontAwesomeIcons.facebook,
                                  color: Colors.blue,
                                  size: 40,
                                ),
                              ),
                              MySocialIcon(
                                myImg: FaIcon(
                                  FontAwesomeIcons.linkedin,
                                  color: Colors.blue[600],
                                  size: 40,
                                ),
                              ),
                              MySocialIcon(
                                myImg: FaIcon(
                                  FontAwesomeIcons.googlePlus,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: deviceSize(context).width * 0.05,
                            ),
                            child: TextFormField(
                              controller: myController,
                              textInputAction: TextInputAction.search,
                              keyboardType: TextInputType.number,
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Empty";
                                }
                                return null;
                              },
                              onFieldSubmitted: (_) {
                                return _formSub(context);
                              },
                              decoration: InputDecoration(
                                hintText: "Search Name",
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 8.0),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: deviceSize(context).height * 0.01),
                          MyBtn(
                            txt: "Search Connections",
                            btnWidth: deviceSize(context).width * 0.6,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      MyBtn(
                        txt: "Add a Franchise",
                        btnWidth: deviceSize(context).width,
                      ),
                      MyBtn(
                        txt: "Post and Idea",
                        btnWidth: deviceSize(context).width,
                      ),
                      InkWell(
                        child: Container(
                          width: deviceSize(context).width,
                          height: deviceSize(context).height * 0.05,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [firstPurple, thirdPurple],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Find User",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ]),
        ));
  }
}
