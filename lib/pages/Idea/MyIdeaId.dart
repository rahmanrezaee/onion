import 'package:flutter/material.dart';
import 'package:onion/const/color.dart';
// import 'package:onion/models/SetupIdea%20(2).dart';
import 'package:onion/pages/CustomDrawerPage.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/widgets/AnalysisWidget/MyAlert.dart';
import 'package:onion/widgets/IdeaWiget/itemIdea.dart';
import 'package:onion/services/ideasServices.dart';
import 'package:provider/provider.dart';
import '../../models/Idea.dart';

class MyIdeaId extends StatefulWidget {
  static String routeName = "MyIdeaId";
  @override
  _MyIdeaIdState createState() => _MyIdeaIdState();
}

class _MyIdeaIdState extends State<MyIdeaId> {
  Future getIdeasList;
  String token;
  Auth authProvider;
  initState() {
    super.initState();
    authProvider = Provider.of<Auth>(context, listen: false);
    token = authProvider.token;
    getIdeasList = IdeasServices().getIdeaList(token);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: middlePurple,
        title: Text("My Idea Id"),
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
              child: FutureBuilder(
                future: getIdeasList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List ideas = snapshot.data;
                    return ListView.builder(
                      itemCount: ideas.length - 1,
                      itemBuilder: (BuildContext context, int index) {
                        SetupIdeaModel idea = new SetupIdeaModel();
                        idea.id = ideas[index]["_id"];
                        idea.userId = ideas[index]["userId"];
                        idea.typeIdea = ideas[index]["ideaType"];
                        idea.category = ideas[index]["industry"];
                        idea.experienceYear =
                            ideas[index]["industryExperienceInMonth"];
                        idea.experienceMonth =
                            ideas[index]["industryExperienceInMonth"];
                        idea.ideaHeadline = ideas[index]["headline"];
                        idea.ideaText = ideas[index]["idea"];
                        idea.estimatedPeople =
                            ideas[index]["estimatedPeople"].toString();
                        idea.location = ideas[index]["targetAudience"];
                        idea.documents = ideas[index]["uploadDocuments"];

                        // idea.timeline = ideas[index]["timeline"];
                        return Column(
                          children: [
                            ItemIdea(idea
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
                    );
                    ;
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text(
                            "Something went wrong. Please try again later!"));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                  // return ListView.builder(
                  //   itemCount: 10,
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return Column(
                  //       children: [
                  //         ItemIdea(),
                  //         SizedBox(height: 10),
                  //       ],
                  //     );
                  //   },
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
