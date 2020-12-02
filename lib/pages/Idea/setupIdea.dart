import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:onion/widgets/IdeasWidget/setupIdeaWidget.dart';
import 'package:onion/widgets/MyLittleAppbar.dart';

class SetupIdea extends StatefulWidget {
  static final routeName = "setupIdea";
  @override
  _SetupIdeaState createState() => _SetupIdeaState();
}

class _SetupIdeaState extends State<SetupIdea> {
 
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: MyLittleAppbar(myTitle: "Setup Idea"),
      ),
      body: SetupIdeaWidget(),
    );
  }

  
}
