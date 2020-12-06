import 'package:flutter/material.dart';
import 'package:onion/const/color.dart';
import 'package:onion/pages/CustomDrawerPage.dart';
import 'package:onion/pages/franchises/addFranchise.dart';
import 'package:onion/statemanagment/franchise_provider.dart';
import 'package:onion/widgets/AnalysisWidget/MyAlert.dart';
import 'package:onion/widgets/Franchise/franchiseItem.dart';
import 'package:onion/widgets/IdeaWiget/itemIdea.dart';
import 'package:provider/provider.dart';

class MyFranchises extends StatefulWidget {
  static String routeName = "MyFranchises";
  @override
  _MyFranchisesState createState() => _MyFranchisesState();
}

class _MyFranchisesState extends State<MyFranchises> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: middlePurple,
        title: Text("My Franchises"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed(CustomDrawerPage.routeName);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(AddFranchise.routeName);
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 15),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {},
                child: Icon(
                  Icons.info_outline,
                  color: middlePurple,
                ),
              ),
            ),
            Expanded(
              child: Consumer<FranchiesProvider>(
                  builder: (BuildContext context, value, Widget child) {
                return value.items != null
                    ? ListView.builder(
                        itemCount: value.items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              FranchiseItem(value.items[index]),
                              SizedBox(height: 10),
                            ],
                          );
                        },
                      )
                    : FutureBuilder(
                        future: value.getFranchies(),
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.connectionState ==  ConnectionState.waiting) {
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
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
