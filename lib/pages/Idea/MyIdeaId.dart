import 'package:flutter/material.dart';
import 'package:onion/widgets/IdeaWiget/itemIdea.dart';
import 'package:onion/widgets/MyLittleAppbar.dart';

class MyIdeaId extends StatefulWidget {
  static const routeName = "my_idea_list";
  @override
  _MyIdeaIdState createState() => _MyIdeaIdState();
}

class _MyIdeaIdState extends State<MyIdeaId> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: MyLittleAppbar(myTitle: "My List Idea"),
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return ItemIdea();
          },
        ));
  }
}
