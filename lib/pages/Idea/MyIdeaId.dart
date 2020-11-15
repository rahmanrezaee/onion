import 'package:flutter/material.dart';
import 'package:onion/const/color.dart';
import 'package:onion/pages/CustomDrawerPage.dart';
import 'package:onion/widgets/AnalysisWidget/MyAlert.dart';
import 'package:onion/widgets/IdeaWiget/itemIdea.dart';

class MyIdeaId extends StatefulWidget {
  static String routeName = "MyIdeaId";
  @override
  _MyIdeaIdState createState() => _MyIdeaIdState();
}

class _MyIdeaIdState extends State<MyIdeaId> {
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
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ItemIdea(),
                      SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
