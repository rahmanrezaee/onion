import 'dart:math';
import 'dart:ui';
import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:onion/models/FranchiesModel.dart';
import 'package:onion/pages/Idea/findIdea.dart';
import 'package:onion/pages/franchises/viewFranchisesUser.dart';
import 'package:onion/statemanagment/franchise_provider.dart';
import 'package:onion/widgets/Franchise/CardListItem.dart';
import 'package:onion/widgets/Franchise/Discription.dart';
import 'package:onion/widgets/MyLittleAppbar.dart';
import 'package:onion/widgets/SearchTab/MyCardItemR.dart';
import 'package:onion/widgets/SearchTab/MyCardItemT.dart';
import 'package:provider/provider.dart';

import '../../const/Size.dart';
import '../../const/color.dart';
import '../../widgets/MyAppBar.dart';

class FranchiesList extends StatelessWidget {
  static const routeName = "franchiesList";
  TextEditingController searchController = TextEditingController();
  FranchiesList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight + 100),
        child: Column(
          children: [
            MyLittleAppbar(myTitle: "Find Franchies"),
            // SizedBox(height: 10),
            Container(
              alignment: Alignment.bottomCenter,
              height: deviceSize(context).height * 0.1,
              padding: EdgeInsets.only(
                left: deviceSize(context).width * 0.04,
                right: deviceSize(context).width * 0.04,
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextField(
                    controller: searchController,
                    // textDirection: D,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(20.0),
                        ),
                      ),
                      contentPadding: EdgeInsets.all(2),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.black),
                      hintText: "Search by locaion, Industrty",
                      fillColor: Colors.white,
                      prefixIcon: InkWell(
                          onTap: () {
                            Provider.of<FranchiesProvider>(context,
                                    listen: false)
                                .setSearchKeyword(searchController.text);
                          },
                          child: Icon(Icons.search)),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                // color: ,
                border:
                    Border.all(color: Theme.of(context).primaryColor, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("View Analysis"),
                ],
              ),
            ),
            SizedBox(height: 5),
            Text("Search Recommendation",
                style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 10),
            Consumer<FranchiesProvider>(
                builder: (BuildContext context, value, Widget child) {
              return RefreshIndicator(
                onRefresh: () async {
                  // value.clearToNullList();
                  await value.getFranchies(isMyList: false);
                },
                child: value.itemsAll != null
                    ? value.itemsAll.isEmpty
                        ? ListView(
                            children: [
                              Container(
                                height: 80,
                                alignment: Alignment.center,
                                child: Text("Empty List"),
                              ),
                            ],
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: value.itemsAll.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  FindFranchiesWidget(
                                      franch: value.itemsAll[index]),
                                  // (),
                                  SizedBox(height: 10),
                                ],
                              );
                            },
                          )
                    : FutureBuilder(
                        future: value.getFranchies(isMyList: false),
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
                      ),
              );
            }),
          ]),
        ),
      ),
    );
  }
}

class FindFranchiesWidget extends StatelessWidget {
  FranchiesModel franch;
  FindFranchiesWidget({
    this.franch,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 3,
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Industry: ${franch.industry}",
                  style: TextStyle(
                    color: middlePurple,
                  ),
                ),
                SizedBox(height: 10),
                Text("BrandName: ${franch.brandName}",
                    style: TextStyle(color: Colors.black)),
                SizedBox(height: 10),
                Text("Requirment: ", style: TextStyle(fontSize: 18)),
                SizedBox(height: 5),
                DropCapText(
                  "${franch.requirments}",
                  dropCapPosition: DropCapPosition.end,
                  dropCap: DropCap(
                    width: 120,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 120,
                          child: RaisedButton(
                              color: middlePurple,
                              onPressed: () {},
                              child: Text("View Profile",
                                  style: TextStyle(color: Colors.white))),
                        ),
                        SizedBox(
                            width: 120,
                            child: OutlineButton(
                                onPressed: () {}, child: Text("Message"))),
                        SizedBox(
                          width: 120,
                          child: OutlineButton(
                              padding: EdgeInsets.zero,
                              onPressed: () => Navigator.of(context).pushNamed(
                                  ViewFranchisesUser.routeName,
                                  arguments: franch),
                              child: Text("View Franchies")),
                        ),
                      ],
                    ),
                  ),
                ),
                // Text(
                //     "Lorem ipsum dolor sit amit is simply, Lorem ipsum dolor sit amit is simply, Lorem ipsum dolor sit amit is simply, Lorem ipsum dolor sit amit is simply, Lorem ipsum dolor sit amit is simply, Lorem ipsum dolor sit amit is simply, "),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Post: 28-08-2020",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.only(topRight: Radius.circular(5)),
            child: SizedBox(
              width: 40,
              height: 40,
              child: Image.asset("assets/images/new.png"),
            ),
          ),
        ),
      ],
    );
  }
}
