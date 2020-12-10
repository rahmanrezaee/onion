import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';
import 'package:onion/const/color.dart';
import 'package:onion/pages/Idea/ViewIdeas.dart';

import '../../models/Idea.dart';

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
