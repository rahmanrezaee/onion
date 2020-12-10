import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/const/color.dart';
import 'package:onion/models/Idea.dart';
import 'package:onion/pages/Idea/ViewIdeas.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/statemanagment/idea/ideasProviders.dart';
import 'package:onion/models/FranchiesModel.dart';
import 'package:onion/pages/franchises/viewFranchisesUser.dart';
import 'package:onion/widgets/IdeasWidget/findIdeaWidget.dart';
import 'package:onion/widgets/MyLittleAppbar.dart';
import 'package:provider/provider.dart';

class FindIdea extends StatefulWidget {
  @override
  _FindIdeaState createState() => _FindIdeaState();
}

class _FindIdeaState extends State<FindIdea> {
  String token;
  Auth authProvider;
  IdeasProvider ideasProvider;
  initState() {
    super.initState();
    authProvider = Provider.of<Auth>(context, listen: false);
    ideasProvider = Provider.of<IdeasProvider>(context, listen: false);
    token = authProvider.token;
  }

  String searchKey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight + 100),
        child: Column(
          children: [
            MyLittleAppbar(myTitle: "Find Ideas"),
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
                    onChanged: (v) {
                      if (v == null || v == "") {
                        ideasProvider.getAllIdeaList(token);
                      }
                      setState(() {
                        searchKey = v;
                      });
                    },
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
                            findIdea(searchKey);
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
          padding: EdgeInsets.all(15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Search Recommendation",
                style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 10),
            Consumer<IdeasProvider>(
              builder: (BuildContext context, value, Widget child) {
                return value.allIdeas != null
                    ? value.allIdeas.length < 1
                        ? Center(child: Text("Nothing Found!"))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: value.allIdeas.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  FindIdeaWidget(value.allIdeas[index]),
                                  SizedBox(height: 10),
                                ],
                              );
                            },
                          )
                    : FutureBuilder(
                        future: value.getAllIdeaList(token),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text("");
                          } else if (snapshot.hasError) {
                            print(
                                "error to getting All Idea List ${snapshot.error}");
                            return Center(
                                child: Text(
                                    "Something went wrong. Please try again later!"));
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      );
              },
            ),
            // ListView.builder(
            //   itemCount: 10,
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   itemBuilder: (context, i) {
            //     return FindIdeaWidget();
            //   },
            // ),
          ]),
        ),
      ),
    );
  }

  findIdea(key) {
    ideasProvider.findIdea(key, token);
  }
}
