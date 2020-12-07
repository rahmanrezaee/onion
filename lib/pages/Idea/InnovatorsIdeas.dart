import 'package:flutter/material.dart';
import 'package:onion/const/color.dart';
import 'package:onion/widgets/MyLittleAppbar.dart';

class InnovatorsIdeas extends StatefulWidget {
  @override
  _InnovatorsIdeasState createState() => _InnovatorsIdeasState();
}

class _InnovatorsIdeasState extends State<InnovatorsIdeas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight + 5),
        child: Column(
          children: [
            MyLittleAppbar(myTitle: "Find Ideas"),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("<User> Ideas"),
                  IconButton(
                    icon: Icon(Icons.info_outline),
                    onPressed: () {
                      print("You clicked in the info man!");
                    },
                  ),
                ],
              ),
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Industry: <IndustryName>"),
                          Text("Implemented")
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("Headline"), Text("Topic Name")],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("Location"), Text("Place/Location")],
                      ),
                      Divider(),
                      SizedBox(height: 10),
                      Text("Idea Details",
                          style: TextStyle(color: deepBlue, fontSize: 18)),
                      Text(
                          "lorem ipsum doloe sit amit, lorem ipsum doloe sit amit, lorem ipsum doloe sit amit, lorem ipsum doloe sit amit, lorem ipsum doloe sit amit, lorem ipsum doloe sit amit, lorem ipsum doloe sit amit, lorem ipsum doloe sit amit, lorem ipsum doloe sit amit, lorem ipsum doloe sit amit, lorem ipsum doloe sit amit, lorem ipsum doloe sit amit, "),
                      SizedBox(height: 4),
                      Text(
                        "Read More",
                        style: TextStyle(
                            color: middlePurple,
                            decoration: TextDecoration.underline),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Bids: 220"),
                          Text("Total Investors Request: 220"),
                        ],
                      ),
                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text("Post: 20-08-2020, 20:56"),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
