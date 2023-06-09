import 'dart:math';

import 'package:flutter/material.dart';
import 'package:onion/const/values.dart';
import 'package:onion/pages/Analysis.dart';
import 'package:onion/pages/AnalyticsOne.dart';
import 'package:onion/pages/CustomDrawerPage.dart';
import 'package:onion/pages/F&Q.dart';
import 'package:onion/pages/Idea/MyIdeaDetailes.dart';
import 'package:onion/pages/Idea/MyIdeaId.dart';
import 'package:onion/pages/MainScreen.dart';
import 'package:onion/pages/Services.dart';
import 'package:onion/pages/Settings.dart';
import 'package:onion/pages/authentication/Login.dart';
import 'package:onion/pages/franchises/FranchiesList.dart';
import 'package:onion/pages/franchises/RequestFranchies.dart';
import 'package:onion/pages/franchises/myFranchises.dart';
import 'package:onion/pages/franchises/requestFranchisesUser.dart';
import 'package:onion/pages/franchises/viewFranchisesUser.dart';
import 'package:onion/pages/profile/profile_page.dart';
import 'package:onion/pages/rating/RatingPage.dart';
import 'package:onion/pages/underDevelopment.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:http/http.dart';
import 'package:onion/pages/Settings.dart';
import 'package:onion/pages/request.dart';
import 'package:onion/services/SimpleHttp.dart';
import 'package:onion/widgets/T&C_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../pages/Analysis.dart';
import '../../pages/Home.dart';
import '../../statemanagment/DrawerScaffold.dart';
import '../../pages/AnalyticsOne.dart';
import '../../pages/CustomDrawerPage.dart';
import '../../pages/F&Q.dart';
import '../../pages/Idea/MyIdeaId.dart';
import '../../pages/Services.dart';
import '../../pages/authentication/Login.dart';
import '../../statemanagment/auth_provider.dart';
import '../DropdownWidget/Terms%20&%20Conditions.dart';
import '../../const/Size.dart';
import '../../const/color.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool _isAuth;

  __isAuth() async {
    _isAuth = await Auth().isAuth();
    setState(() {});
    print("_isAuth $_isAuth");
  }

  initState() {
    __isAuth();
    super.initState();
  }

  Column myListTile({
    String name,
    IconData icon,
    String routeName,
    context,
    bool justPush = false,
    bool hasDrawer = false,
  }) {
    return Column(
      children: [
        ListTile(
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
                  if (routeName == "show dialog") {
                    showTermAndConditions(context);
                  }
                  if (hasDrawer) {
                    Provider.of<DrawerScaffold>(
                      context,
                      listen: false,
                    ).scaffoldFunc(mScaffoldType: routeName);
                  } else {
                    if (justPush) {
                      Navigator.pushNamed(context, routeName);
                    } else {
                      Navigator.pushReplacementNamed(
                        context,
                        routeName,
                      );
                    }
                  }
                },
        ),
        Divider(color: Colors.white, height: 0.1),
      ],
    );
  }

  @override
  Widget build(context) {
    Auth().isAuth().then((auth) {
      _isAuth = auth;
    });
    return Consumer<Auth>(builder: (context, value, Widget child) {
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
                                  backgroundImage: value.token != null &&
                                          value.currentUser.profile != null
                                      ? NetworkImage(
                                          BASE_URL + value.currentUser.profile)
                                      : AssetImage(
                                          'assets/images/empty_profile.jpg'),
                                ),
                              ),
                              value.token != null
                                  ? Positioned(
                                      right: 8,
                                      bottom: 8,
                                      child: Container(
                                        height:
                                            deviceSize(context).width * 0.06,
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
                                            size: deviceSize(context).width *
                                                0.04,
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox()
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
                              onPressed: () => Navigator.pushReplacementNamed(
                                  context, Login.routeName),
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
              myListTile(
                context: context,
                name: "Home",
                icon: Icons.home,
                routeName: MainScreen.routeName,
                justPush: true,
                hasDrawer: true,
              ),

              myListTile(
                context: context,
                name: "analysis",
                icon: Icons.person,
                routeName: Analysis.routeName,
                justPush: true,
                hasDrawer: true,
              ),

              value.token != null
                  ? myListTile(
                      context: context,
                      name: "My Profile",
                      icon: Icons.person,
                      routeName: ProfilePage.routeName,
                      justPush: true)
                  : Container(),
              value.token != null
                  ? myListTile(
                      context: context,
                      name: "Setting",
                      icon: Icons.settings,
                      routeName: "Uder Development",
                      justPush: true)
                  : SizedBox(),

              Divider(color: Colors.white, height: 0.1),

              value.token != null
                  ? myListTile(
                      context: context,
                      name: "Notification Setting",
                      justPush: true,
                      icon: Icons.notifications,
                      routeName: Settings.routeName,
                    )
                  : Container(),

              value.token != null
                  ? myListTile(
                      context: context,
                      name: "Request",
                      icon: Icons.request_page,
                      routeName: RequestPage.routeName,
                      justPush: true)
                  : Container(),
              myListTile(
                context: context,
                name: "Services",
                icon: Icons.done,
                // routeName: Services.routeName,
                routeName: MyFranchises.routeName,
                justPush: true,
                hasDrawer: false,
              ),
              value.token != null
                  ? myListTile(
                      context: context,
                      name: "My Ideas Id",
                      icon: Icons.ac_unit,
                      routeName: MyIdeaId.routeName,
                      justPush: true)
                  : Container(),
              value.token != null
                  ? myListTile(
                      context: context,
                      name: "My Franchies",
                      icon: Icons.ac_unit,
                      routeName: MyFranchises.routeName,
                      justPush: true)
                  : Container(),
              myListTile(
                  context: context,
                  name: " Franchies List",
                  icon: Icons.ac_unit,
                  routeName: RequestFranchiesList.routeName,
                  justPush: true),

              value.token != null
                  ? myListTile(
                      context: context,
                      name: "Rating",
                      icon: Icons.multiline_chart,
                      routeName: RatingPage.routeName,
                      justPush: true,
                    )
                  : Container(),
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
                    icon: Icons.assignment,
                    justPush: true),
              ),
              myListTile(
                context: context,
                name: "FAQ",
                icon: Icons.question_answer_rounded,
                routeName: FandQ.routeName,
                justPush: true,
              ),
              // value.token != null
              //     ? myListTile(
              //         context: context,
              //         name: "My Idea List",
              //         icon: Icons.help,
              //         routeName: MyIdeaId.routeName,
              //         justPush: true,
              //       )
              //     : Container(),
              value.token != null
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: deviceSize(context).width * 0.07,
                      ),
                      child: RaisedButton(
                        child: Text("logout"),
                        elevation: 0,
                        onPressed: () {
                          value.logout(context);
                        },
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: deviceSize(context).width * 0.07,
                      ),
                      child: RaisedButton(
                        elevation: 0,
                        onPressed: () => Navigator.pushNamed(
                          context,
                          Login.routeName,
                        ),
                        child: Text("login"),
                      ),
                    ),
            ],
          ),
        ),
      );
    });
  }
}
