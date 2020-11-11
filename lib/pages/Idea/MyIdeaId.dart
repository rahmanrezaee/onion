import 'package:flutter/material.dart';
import 'package:onion/widgets/IdeaWiget/itemIdea.dart';

class MyIdeaId extends StatefulWidget {
  @override
  _MyIdeaIdState createState() => _MyIdeaIdState();
}

class _MyIdeaIdState extends State<MyIdeaId> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return ItemIdea();
          },
        ));
  }
}
