import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:onion/const/color.dart';
import 'package:onion/pages/CustomDrawerPage.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/services/SettingsHttp.dart';
import 'package:onion/widgets/AnalysisWidget/MyAlert.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  static String routeName = "Settings";

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool receiveEmail = false;
  bool receiveWebsite = false;
  bool receiveSMS = false;
  bool receiveAppUpdates = false;

  String profileType = "Select Profile Type";
  List profileTypes = [
    "Service Provider",
    "Project Manager",
    "Investor",
  ];
  String token;
  bool _loadingButton = false;
  bool defaultDataLoaded = false;

  Future notifcationSetting;

  Future<void> getDefaultData() async {
    notifcationSetting = SettingsHttp().getDefaultSettings(token).then((value) {
      if (value != null) {
        Map data = value[0];
        setState(() {
          print(data['notification_website']);
          receiveEmail = data["notification_email"];
          receiveWebsite = data["notification_website"];
          receiveSMS = data["notification_sms"];
          receiveAppUpdates = data["notification_update"];
        });
      }
    });
  }

  initState() {
    token = Provider.of<Auth>(context,listen: false).token;
    getDefaultData();
    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build( context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: middlePurple,
        title: Text("Notification"),
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
      body: FutureBuilder(
        future: notifcationSetting,
        builder: ( context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Padding(
                padding: EdgeInsets.all(10),
                child: ListView(children: [
                  SizedBox(height: 10),
                  //popup section start
                  Text("Select your primary profile",
                      style: TextStyle(color: middlePurple)),
                  InkWell(
                    onTap: () {
                      showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(25.0, 25.0, 0.0,
                            0.0), //position where you want to show the menu on screen
                        items: [
                          ...profileTypes
                              .map(
                                (e) => PopupMenuItem(
                                  value: profileTypes.indexOf(e),
                                  child: Text(e),
                                ),
                              )
                              .toList(),
                        ],
                        elevation: 8.0,
                      ).then<void>(
                        (index) {
                          setState(() {
                            profileType = profileTypes[index];
                          });
                        },
                      );
                    },
                    child: Container(
                      height: 25,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 3,
                              blurRadius: 4,
                              offset: Offset(0, 3),
                            ),
                          ]),
//             alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            profileType,
                          ),
                          // PopupMenuButton(
                          //     padding: EdgeInsets.all(0),
                          //     icon: Icon(Icons.arrow_drop_down,
                          //         color: Colors.black),
                          //     onSelected: (index) {
                          //       setState(() {
                          //         profileType = profileTypes[index];
                          //       });
                          //     },
                          //     itemBuilder: (context) {
                          //       return [
                          //         ...profileTypes
                          //             .map(
                          //               (e) => PopupMenuItem(
                          //                 value: profileTypes.indexOf(e),
                          //                 child: Text(e),
                          //               ),
                          //             )
                          //             .toList(),
                          //       ];
                          //     })
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  //popup section End
                  //Card section start
                  Text("Notification settings",
                      style: TextStyle(color: middlePurple)),
                  SizedBox(height: 10),
                  Card(
                    elevation: 3,
                    shadowColor: Colors.black12,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Receive Email"),
                                  Transform.scale(
                                    scale: 0.6,
                                    alignment: Alignment.centerRight,
                                    child: CupertinoSwitch(
                                        activeColor: middlePurple,
                                        value: receiveEmail,
                                        onChanged: (v) {
                                          setState(() {
                                            receiveEmail = v;
                                          });
                                        }),
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Receive Website"),
                                  Transform.scale(
                                    scale: 0.6,
                                    alignment: Alignment.centerRight,
                                    child: CupertinoSwitch(
                                        activeColor: middlePurple,
                                        value: receiveWebsite,
                                        onChanged: (v) {
                                          setState(() {
                                            receiveWebsite = v;
                                          });
                                        }),
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Receive SMS"),
                                  Transform.scale(
                                    scale: 0.6,
                                    alignment: Alignment.centerRight,
                                    child: CupertinoSwitch(
                                        activeColor: middlePurple,
                                        value: receiveSMS,
                                        onChanged: (v) {
                                          setState(() {
                                            receiveSMS = v;
                                          });
                                        }),
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Receive App Updates"),
                                  Transform.scale(
                                    scale: 0.6,
                                    alignment: Alignment.centerRight,
                                    child: CupertinoSwitch(
                                        activeColor: middlePurple,
                                        value: receiveAppUpdates,
                                        onChanged: (v) {
                                          setState(() {
                                            receiveAppUpdates = v;
                                          });
                                        }),
                                  ),
                                ]),
                          ]),
                    ),
                  ),
                  //Card section End
                  SizedBox(height: 50),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      color: middlePurple,
                      child: _loadingButton == true
                          ? LinearProgressIndicator(
                              backgroundColor: firstPurple)
                          : Text("SAVE CHANGES",
                              style: TextStyle(color: Colors.white)),
                      onPressed: saveSetting,
                    ),
                  ),
                ]),
              );
              break;
            case ConnectionState.none:
              return Text("error in catch Data");
              break;
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
              // TODO: Handle this case.
              break;
          }
        },
      ),
    );
  }

  void saveSetting() {
    setState(() {
      _loadingButton = true;
    });

    SettingsHttp()
        .setSettings(
      profileType: profileType,
      email: receiveEmail,
      website: receiveWebsite,
      sms: receiveSMS,
      update: receiveAppUpdates,
      token: token,
    )
        .then((value) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Succesfuly Saved"),
      ));
      setState(() {
        _loadingButton = false;
      });
    }).catchError((err) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(err),
      ));
      setState(() {
        _loadingButton = false;
      });
    });
  }
}
