import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:onion/widgets/SearchTab/MyCardItemT.dart';

import '../../widgets/SearchTab/MRaisedBtn.dart';
import '../../widgets/SearchTab/MyCardItemR.dart';
import '../../const/Size.dart';
import '../../const/color.dart';
import '../../widgets/MyAppBar.dart';

class SearchTab extends StatelessWidget {
  static const routeName = "search_tab";
  Function openDrawer;
  bool isSelected;
  var _currencies = [
    "Food",
    "Transport",
    "Food",
    "Transport",
  ];

  SearchTab({this.openDrawer});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      openDrawer: openDrawer,
      title: 'List Example',
      slivers: [
        _StickyHeaderList(
          index: 0,
          myWidget: MyCardItemR(),
          myTitle: "Search Recommendation",
        ),
        _StickyHeaderList(
          index: 1,
          myWidget: MyCardItemT(),
          myTitle: "Top Investors",
        ),
      ],
    );
  }
}

class _StickyHeaderList extends StatelessWidget {
  final Widget myWidget;
  final String myTitle;

  const _StickyHeaderList({
    Key key,
    this.index,
    this.myWidget,
    this.myTitle,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: Header(index: index, title: myTitle),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) => myWidget,
          childCount: 6,
        ),
      ),
    );
  }
}

class AppScaffold extends StatelessWidget {
  final Function openDrawer;

  const AppScaffold({
    Key key,
    @required this.title,
    @required this.slivers,
    this.reverse = false,
    this.openDrawer,
  }) : super(key: key);

  final String title;
  final List<Widget> slivers;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    return DefaultStickyHeaderController(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: MyAppBar(
          title: "Find Connections",
          openDrawer: openDrawer,
        ),
        body: Column(
          children: [
            Container(
              height: deviceSize(context).height * 0.1,
              padding: EdgeInsets.only(
                left: deviceSize(context).width * 0.04,
                right: deviceSize(context).width * 0.04,
              ),
              decoration: BoxDecoration(
                color: middlePurple,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(
                    deviceSize(context).height * 0.04,
                  ),
                  bottomLeft: Radius.circular(
                    deviceSize(context).height * 0.04,
                  ),
                ),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(20.0),
                    ),
                  ),
                  contentPadding: EdgeInsets.all(2),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Searched Keyword",
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: slivers,
                reverse: reverse,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key key,
    this.index,
    this.title,
    this.color = Colors.lightBlue,
  }) : super(key: key);

  final String title;
  final int index;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.grey.shade200,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        textAlign: TextAlign.start,
        textScaleFactor: 1.1,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
