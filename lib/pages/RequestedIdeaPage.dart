import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:onion/const/Size.dart';
import 'package:onion/widgets/FiveRating.dart';
import 'package:onion/widgets/MyAppBar.dart';

class RequestedIdeaPage extends StatelessWidget {
  static const routeName = "requested_idea_page";
  String txtText =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Requested Ideas",
      ),
      body: ListView(
        children: [
          MyCardItem(txtText: txtText),
        ],
      ),
    );
  }
}

class MyCardItem extends StatelessWidget {
  const MyCardItem({
    Key key,
    @required this.txtText,
  }) : super(key: key);

  final String txtText;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: deviceSize(context).height * 0.1,
                width: deviceSize(context).height * 0.1,
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/empty_profile.jpg',
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTxt(
                    name: "Jamesh H.Matt",
                    fontWeight: FontWeight.bold,
                  ),
                  MyTxt(
                    name: "Industry",
                    fontWeight: FontWeight.normal,
                  ),
                  Row(
                    children: [
                      MyTxt(
                        name: "Rated:",
                        fontWeight: FontWeight.normal,
                      ),
                      MyFiveRating(),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    Icons.list,
                    color: Colors.grey,
                    // padding: EdgeInsets.zero,
                    // alignment: Alignment.topRight,
                    // icon: Icon(
                    //   Icons.list,
                    //   color: Colors.grey,
                    // ),
                    // onPressed: () {},
                  ),
                  Text(
                    "30/8/2020--11:00AM",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(deviceSize(context).height * 0.02),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                    minWidth: deviceSize(context).width * 0.8,
                    maxWidth: deviceSize(context).width * 0.8,
                    minHeight: deviceSize(context).height * 0.02,
                    maxHeight: deviceSize(context).height * 0.2,
                  ),
                  child: RichText(
                    text: TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Idea: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: txtText),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// RichText(
//   text: new TextSpan(
//     // Note: Styles for TextSpans must be explicitly defined.
//     // Child text spans will inherit styles from parent
//     style: new TextStyle(
//       fontSize: 14.0,
//       color: Colors.black,
//     ),
//     children: <TextSpan>[
//       TextSpan(text: 'Hello'),
//     ],
//   ),
// ),
// ConstrainedBox(
//   constraints: BoxConstraints(
//     minWidth: deviceSize(context).width * 0.8,
//     maxWidth: deviceSize(context).width * 0.8,
//     minHeight: deviceSize(context).height * 0.02,
//     maxHeight: deviceSize(context).height * 0.2,
//   ),
//   child: AutoSizeText(
//     "Idea: $txtText",
//     textScaleFactor: 1.1,
//   ),
// ),

class MyTxt extends StatelessWidget {
  final String name;
  final FontWeight fontWeight;

  const MyTxt({
    Key key,
    this.name,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: deviceSize(context).height * 0.01),
      child: Text(
        name,
        style: TextStyle(fontWeight: fontWeight),
      ),
    );
  }
}
