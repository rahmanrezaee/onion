import 'package:flutter/material.dart';
import 'package:onion/const/color.dart';
import 'package:onion/widgets/AnalysisWidget/MyAlert.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
import 'CustomDrawerPage.dart';

class RequestPage extends StatelessWidget {
  static const routeName = "request";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: middlePurple,
        title: Text("Request"),
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
        padding: EdgeInsets.all(10),
        child: Container(
          width: double.infinity,
          child: Card(
              elevation: 5,
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [Text("title"), Text("content")],
                    )
                  ],
                ),
                Row(children: <Widget>[
                  Expanded(
                    child: new Container(
                        child: Divider(
                      color: Colors.black,
                      height: 36,
                    )),
                  ),
                ]),
                Row(
                  children: <Widget>[Text("below ")],
                ),
              ])),
        ),
      ),
    );
  }
}
