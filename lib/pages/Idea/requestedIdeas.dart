import 'package:flutter/material.dart';
import 'package:onion/const/color.dart';
import 'package:onion/pages/CustomDrawerPage.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/statemanagment/idea/ideasProviders.dart';
import 'package:onion/widgets/AnalysisWidget/MyAlert.dart';
import 'package:onion/widgets/IdeaWiget/itemIdea.dart';
import 'package:onion/services/ideasServices.dart';
import 'package:provider/provider.dart';

class RequestedIdeas extends StatefulWidget {
  static String routeName = "RequestedIdeas";
  @override
  _RequestedIdeasState createState() => _RequestedIdeasState();
}

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _RequestedIdeasState extends State<RequestedIdeas> {
  Future getIdeasList;
  String token;
  Auth authProvider;
  IdeasProvider ideasProvider;
  initState() {
    super.initState();
    authProvider = Provider.of<Auth>(context, listen: false);
    token = authProvider.token;
    getIdeasList = IdeasServices().getIdeaList(token);
    first = false;
  }

  bool first = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: middlePurple,
        title: Text("Requested Ideas"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            // Navigator.of(context)
            //     .pushReplacementNamed(CustomDrawerPage.routeName);
          },
        ),
        actions: [
          IconButton(
            icon: MyAlertIcon(num: 3),
            onPressed: () {},
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
              child: Consumer<IdeasProvider>(
                builder: (BuildContext context, value, Widget child) {
                  return value.myIdeas != null
                      ? value.myIdeas.length < 1
                          ? Center(child: Text("Your idea list is empty"))
                          : ListView.builder(
                              itemCount: value.myIdeas.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    ItemIdea(
                                      _scaffoldKey, value, value.myIdeas[index],
                                      () {
                                        setState(() {});
                                      },
                                      false,
                                      // SetupIdeaModel(
                                      //   id: ideas[index]["_id"],
                                      //   userId: ideas[index]["userId"],
                                      //   typeIdea: ideas[index]["ideaType"],
                                      //   category: ideas[index]["industry"],
                                      //   experienceYear: ideas[index]
                                      //       ["industryExperienceInMonth"],
                                      //   experienceMonth: ideas[index]
                                      //       ["industryExperienceInMonth"],
                                      //   ideaHeadline: ideas[index]["headline"],
                                      //   ideaText: ideas[index]["idea"],
                                      //   // timeline: json.decode(ideas[index]["timeline"]),
                                      // ),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                );
                              },
                            )
                      : FutureBuilder(
                          future: value.getMyIdeaList(token),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text("");
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text(
                                      "Something went wrong. Please try again later!"));
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
