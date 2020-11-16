import 'dart:ui';

import 'package:flutter/material.dart';

import '../../widgets/Franchise/CardListItem.dart';
import '../../const/Size.dart';
import '../../const/color.dart';
import '../../const/values.dart';
import '../../widgets/Franchise/Discription.dart';
import '../../widgets/MyLittleAppbar.dart';

class RequestOnFranchise extends StatelessWidget {
  static const routeName = "request_on_franchise";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: MyLittleAppbar(
          myTitle: "Request On Franchise",
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(deviceSize(context).height * 0.01),
        child: Column(
          children: [
            Description(),
            CardListItem(),
            CardListItem(),
            CardListItem(),
          ],
        ),
      ),
    );
  }
}
