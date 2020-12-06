import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/const/color.dart';
import 'package:onion/pages/Analysis.dart';
import 'package:onion/pages/authentication/Login.dart';
import 'package:onion/statemanagment/SaveAnalModel.dart';
import 'package:onion/statemanagment/analysis_provider.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/statemanagment/dropdown_provider.dart';
import 'package:onion/widgets/AnalysisWidget/MyAlert.dart';
import 'package:onion/widgets/dashboardWidget/savedAnalysis.dart';
import 'package:onion/widgets/temp_popup.dart';
import 'package:provider/provider.dart';

class AnalysisList extends StatelessWidget {
  static final routeName = "MyAnalysisList";
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Analysis List"),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: MyAlertIcon(num: 3),
          )
        ],
      ),
      body: Consumer3<SaveAnalProvider, DropdownProvider, AnalysisProvider>(
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
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: false,
                            itemCount: consValue.items.length,
                            itemBuilder: (listContext, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Analysis.routeName);

                                  drValue.categorySelected =
                                      consValue.items[index].category;
                                  drValue.idustrySelected =
                                      consValue.items[index].industry;
                                  drValue.typeSelected =
                                      consValue.items[index].title;
                                  anaValue.country.forEach((element) {
                                    if (element.country ==
                                        consValue.items[index].region)
                                      anaValue.changeCountryColors(element);
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
                                  analysis: consValue.items[index].title,
                                  category: consValue.items[index].category,
                                  industry: consValue.items[index].industry,
                                  region: consValue.items[index].region,
                                ),
                              );
                            },
                          ),
                        )
                  : FutureBuilder(
                      future: consValue.getAnalysis(),
                      builder: (context, AsyncSnapshot<dynamic> snapshot) {
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
    );
  }
}
