import 'dart:math';

import 'package:flutter/material.dart';
import 'package:onion/pages/Analysis.dart';
import 'package:onion/pages/AnalyticsOne.dart';
import 'package:onion/pages/CustomDrawerPage.dart';
import 'package:onion/pages/F&Q.dart';
import 'package:onion/pages/Idea/MyIdeaId.dart';
import 'package:onion/pages/Services.dart';
import 'package:onion/pages/Settings.dart';
import 'package:onion/pages/authentication/Login.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/services/SimpleHttp.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../const/Size.dart';
import '../../const/color.dart';

class MyDrawer extends StatelessWidget {
  ListTile myListTile({
    String name,
    IconData icon,
    String routeName,
    BuildContext context,
  }) {
    return ListTile(
      dense: true,
      title: Text(
        name,
        style: TextStyle(color: Colors.white),
      ),
      leading: Icon(icon, color: Colors.white),
      onTap: routeName == null
          ? null
          : () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                context,
                routeName,
              );
            },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(builder: (BuildContext context, value, Widget child) {
      return Drawer(
        elevation: 0,
        child: Container(
          color: middlePurple,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: middlePurple,
                ),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/images/empty_profile.jpg'),
                                ),
                              ),
                              Positioned(
                                right: 1,
                                bottom: 1,
                                child: Container(
                                  height: deviceSize(context).width * 0.06,
                                  width: deviceSize(context).width * 0.06,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      deviceSize(context).width * 0.03,
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.edit,
                                      color: middlePurple,
                                      size: deviceSize(context).width * 0.04,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      value.token != null
                          ? Text(
                          
                              value.currentUser.name,
                              textScaleFactor: 1.2,
                              style: TextStyle(color: Colors.white),
                            )
                          : FlatButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, Login.routeName),
                              child: Text(
                                "click to login..",
                                textScaleFactor: 1.2,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.white, height: 0.1),
              myListTile(
                context: context,
                name: "Analytics List",
                icon: Icons.person,
                routeName: CustomDrawerPage.routeName,
              ),
              Divider(color: Colors.white, height: 0.1),
              myListTile(
                context: context,
                name: "Analytics One",
                icon: Icons.opacity,
                routeName: AnalyticsOne.routeName,
              ),
              Divider(color: Colors.white, height: 0.1),
              myListTile(
                context: context,
                name: "Settings",
                icon: Icons.settings,
                routeName: Settings.routeName,
              ),
              Divider(color: Colors.white, height: 0.1),
              myListTile(
                context: context,
                name: "Notification Setting",
                icon: Icons.notifications,
              ),
              Divider(color: Colors.white, height: 0.1),
              myListTile(
                context: context,
                name: "Innovator",
                icon: Icons.lightbulb,
              ),
              Divider(color: Colors.white, height: 0.1),
              myListTile(
                context: context,
                name: "Service Provider",
                icon: Icons.person,
              ),
              Divider(color: Colors.white, height: 0.1),
              myListTile(
                context: context,
                name: "Investor",
                icon: Icons.person,
              ),
              Divider(color: Colors.white, height: 0.1),
              myListTile(
                context: context,
                name: "My Connections",
                icon: Icons.connect_without_contact,
              ),
              Divider(color: Colors.white, height: 0.1),
              myListTile(
                context: context,
                name: "Services",
                icon: Icons.person,
                routeName: Services.routeName,
              ),
              Divider(color: Colors.white, height: 0.1),
              myListTile(
                context: context,
                name: "Completed Projects",
                icon: Icons.sticky_note_2_rounded,
              ),
              Divider(color: Colors.white, height: 0.1),
              myListTile(
                context: context,
                name: "My Analysis",
                icon: Icons.help,
              ),
              Divider(color: Colors.white, height: 0.1),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return TandCDialog();
                      });
                },
                child: myListTile(
                  context: context,
                  name: "Term and Condition",
                  icon: Icons.help,
                ),
              ),
              Divider(color: Colors.white, height: 0.1),
              myListTile(
                context: context,
                name: "FAQ",
                icon: Icons.help,
                routeName: FandQ.routeName,
              ),
              Divider(color: Colors.white, height: 0.1),
              myListTile(
                context: context,
                name: "My Idea List",
                icon: Icons.help,
                routeName: MyIdeaId.routeName,
              ),
              value.token != null
                  ? RaisedButton(
                      child: Text("logout"),
                      onPressed: () {
                        value.logout();
                      })
                  : RaisedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, Login.routeName),
                      child: Text("login"),
                    ),
            ],
          ),
        ),
      );
    });
  }
}

//THis is term and conditions Dialog
//it opens when click in the term and condition menu in the drawer
class TandCDialog extends StatelessWidget {
  TandCDialog({
    Key key,
  }) : super(key: key);

  ScrollController _controller = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          //Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: middlePurple,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4), topLeft: Radius.circular(4)),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(flex: 1, child: Text("")),
                    Expanded(
                      flex: 4,
                      child: Text(
                        "Terms & Conditions",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ]),
            ),
          ),
          //Content(Body)
          FutureBuilder(
            future: SimpleHttp().getTandC(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var content = snapshot.data["body"];
                return Expanded(
                  child: Scrollbar(
                    isAlwaysShown: true,
                    radius: Radius.circular(4),
                    controller: _controller,
                    child: ListView(controller: _controller, children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(content),
                      ),
                    ]),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text(
                    "Something went wrong will getting Terms and Conditions!! Please try again later.");
              } else {
                //Loading Shimmers
                return Expanded(
                    child: Shimmer.fromColors(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(children: [
                      ...List.generate(
                          100,
                          (index) => Column(
                                children: [
                                  Container(
                                    width: double.infinity - Random().nextInt(50 - 0),
                                    height: 5,
                                    color: Color(0xFFd8d8d8),
                                  ),
                                  SizedBox(height: 5),
                                ],
                              )),
                    ]),
                  ),
                  baseColor: Color(0xFFd8d8d8),
                  highlightColor: Colors.white,
                ));
              }
            },
          ),
          //Footer(OK Button)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                elevation: 0,
                child: Text("OK", style: TextStyle(color: Colors.white)),
                color: middlePurple,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
