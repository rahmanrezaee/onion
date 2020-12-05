import 'package:flutter/material.dart';
import 'package:onion/widgets/AnalysisWidget/MyAlert.dart';
import 'package:onion/widgets/FiveRating.dart';
import 'package:onion/widgets/ViewRatingWidget/CardRating.dart';

class ViewRating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Rating"),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: MyAlertIcon(num: 3),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Card(
            elevation: 8,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text("View Rating ",
                              style: Theme.of(context).textTheme.headline6)),
                      MyFiveRating(
                        rateVal: 3.4,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text("new Idea",
                      style: Theme.of(context).textTheme.bodyText2),
                  Divider(),
                  Row(
                    children: [
                      Expanded(
                          child: Text("Industry ",
                              style: Theme.of(context).textTheme.bodyText2)),
                      Text("Lorem Ipsum Dummey",
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Expanded(
                          child: Text("Industry Experience",
                              style: Theme.of(context).textTheme.bodyText2)),
                      Text("Lorem Ipsum Dummey",
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Expanded(
                          child: Text("Idea Headline ",
                              style: Theme.of(context).textTheme.bodyText2)),
                      Text("Lorem Ipsum Dummey",
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return CardRating();
            },
          ),
        ]),
      ),
    );
  }
}
