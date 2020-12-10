import 'dart:math';
import 'dart:ui';
import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:onion/pages/Idea/findIdea.dart';
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

class RequestFranchiesList extends StatelessWidget {
  static const routeName = "RequestFranchiesList";
  TextEditingController searchController = TextEditingController();
  RequestFranchiesList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Request Franch")
      ,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
         
            SizedBox(height: 10),
            Text("Request Franchies",
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
                                  FindIdeaWidget(franch: value.itemsAll[index]),
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
  const FindFranchiesWidget({
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
                  "Industry: <IndustryName>",
                  style: TextStyle(
                    color: middlePurple,
                  ),
                ),
                SizedBox(height: 10),
                Text("Headline: <Tapic Name>",
                    style: TextStyle(color: Colors.black)),
                SizedBox(height: 10),
                Text("Idea: ", style: TextStyle(fontSize: 18)),
                SizedBox(height: 5),
                DropCapText(
                  "Lorem ipsum dolor sit amit is simply, Lorem ipsum dolor sit amit is simply, Lorem ipsum dolor sit amit is simply, Lorem ipsum dolor sit amit is simply, Lorem ipsum dolor sit amit is simply, Lorem ipsum dolor sit amit is simply, Lorem ipsum dolor sit amit is simply, Lorem ipsum dolor sit amit is simply, Lorem ipsum dolor sit amit is simply, Lorem ipsum dolor sit amit is simply, Lorem ipsum dolor sit amit is simply, Lorem ipsum dolor sit amit is simply, Lorem ipsum dolor sit amit is simply, Lorem ipsum dolor sit amit is simply, Lorem ipsum dolor sit amit is simply, Lorem ipsum dolor sit amit is simply, Lorem ipsum dolor sit amit is simply, Lorem ipsum dolor sit amit is simply, ",
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
                              onPressed: () {},
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
