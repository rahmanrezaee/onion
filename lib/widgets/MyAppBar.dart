import 'package:flutter/material.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/widgets/AnalysisWidget/MyAlert.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function openDrawer;

  /// you can add more fields that meet your needs

  const MyAppBar({Key key, this.title, this.openDrawer}) : super(key: key);

  @override
  Widget build( context) {
    return Consumer<Auth>(builder: ( context, value, Widget child) {
      return AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          title,
          textAlign: TextAlign.center,
          textScaleFactor: 1.2,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading:  IconButton(
          icon: Icon(openDrawer == null ? Icons.arrow_back_ios : Icons.menu, color: Colors.white),
          color: Colors.white,
          onPressed: openDrawer == null ? () => Navigator.pop(context) : openDrawer,
        ),
        actions: [
          value.token != null
              ? Padding(
                  padding: EdgeInsets.all(15.0),
                  child: MyAlertIcon(num: 3),
                )
              : SizedBox(),
        ],
      );
    });
  }

  @override
  Size get preferredSize => new Size.fromHeight(AppBar().preferredSize.height);
}
