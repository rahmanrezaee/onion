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
import 'package:onion/widgets/MyLittleAppbar.dart';
import 'package:provider/provider.dart';

class FindIdea extends StatefulWidget {
  @override
  _FindIdeaState createState() => _FindIdeaState();
}

class _FindIdeaState extends State<FindIdea> {
  String token;
  Auth authProvider;

  initState() {
    super.initState();
    authProvider = Provider.of<Auth>(context, listen: false);
    token = authProvider.token;
  }

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
                      prefixIcon: Icon(Icons.search),
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
                        ? Center(child: Text("Your idea list is empty"))
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
                        });
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
}

class FindIdeaWidget extends StatelessWidget {
  final SetupIdeaModel idea;
  const FindIdeaWidget(this.idea);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ViewIdeas.routeName, arguments: idea);
      },
      child: Stack(
        children: [
          Card(
            elevation: 3,
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Industry: ${idea.category}",
                    style: TextStyle(
                      color: middlePurple,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("Headline: ${idea.ideaHeadline}",
                      style: TextStyle(color: Colors.black)),
                  SizedBox(height: 10),
                  Text("Idea: ", style: TextStyle(fontSize: 18)),
                  SizedBox(height: 5),
                  DropCapText(
                    "${idea.ideaText}",
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
      ),
    );
  }
}
