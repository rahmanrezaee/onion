import 'package:flutter/material.dart';
import 'package:onion/pages/CustomDrawerPage.dart';

class AnalyticsOne extends StatelessWidget {
  static const routeName = "analytics_one";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          MyListItem(listItem: "Hello"),
          MyListItem(listItem: "Hello"),
        ],
      ),
    );
  }
}

class MyListItem extends StatelessWidget {
  final String listItem;

  const MyListItem({
    Key key,
    this.listItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, CustomDrawerPage.routeName);
      },
      child: Row(
        children: [
          Text(listItem),
          Spacer(),
          Icon(Icons.arrow_forward_ios_sharp),
        ],
      ),
    );
  }
}
