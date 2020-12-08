import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:onion/models/Idea.dart';
import 'package:onion/pages/Idea/MyIdeaDetailes.dart';
import 'package:onion/pages/Idea/postIdea.dart';
import 'package:onion/pages/Idea/viewIdeas.dart';
import 'package:onion/services/ideasServices.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/statemanagment/idea/ideasProviders.dart';
import 'package:onion/widgets/IdeaWiget/popupMenu.dart' as mypopup;
import 'package:provider/provider.dart';
import '../../models/Idea.dart';

class ItemIdea extends StatefulWidget {
  final SetupIdeaModel idea;
  final Function onDelete;
  final IdeasProvider ideasProvider;
  final GlobalKey<ScaffoldState> scaffoldKey;

  ItemIdea(this.scaffoldKey, this.ideasProvider, this.idea, this.onDelete);

  @override
  _ItemIdeaState createState() => _ItemIdeaState();
}

class _ItemIdeaState extends State<ItemIdea> {
  Auth authProvider;

  // IdeasProvider ideasProvider;
  String token;

  initState() {
    super.initState();
    authProvider = Provider.of<Auth>(context, listen: false);
    // ideasProvider = Provider.of<IdeasProvider>(context, listen: true);
    token = authProvider.token;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(MyIdeaDetails.routeName, arguments: widget.idea);
        // Navigator.of(context)
        //     .pushNamed(ViewIdeas.routeName, arguments: widget.idea);
      },
      child: Card(
        elevation: 4,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(authProvider
                            .currentUser.profile ??
                        "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png"),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Industry: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: "${widget.idea.category}",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ]),
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "HeadLine: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: "${widget.idea.ideaHeadline}",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ]),
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        mypopup.PopupMenuButton<int>(
                          elevation: 20,
                          padding: EdgeInsets.all(10),
                          onSelected: (value) {},
                          offset: Offset(50, 50),
                          itemBuilder: (context) => [
                            mypopup.PopupMenuItem(
                              value: 1,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      PostIdea.routeName,
                                      arguments: widget.idea);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    // border:
                                    //     Border.all(color: Colors.grey[200], width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Edit",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            mypopup.PopupMenuItem(
                              value: 2,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  // color: ,
                                  border: Border.all(
                                      color: Colors.grey[200], width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("View Bids"),
                                  ],
                                ),
                              ),
                            ),
                            mypopup.PopupMenuItem(
                              value: 2,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                  // color: ,
                                  border: Border.all(
                                      color: Colors.grey[200], width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("View Interseted Investment"),
                                  ],
                                ),
                              ),
                            ),
                            mypopup.PopupMenuItem(
                              value: 2,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  // color: ,
                                  border: Border.all(
                                      color: Colors.grey[200], width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Find Investor"),
                                  ],
                                ),
                              ),
                            ),
                            mypopup.PopupMenuItem(
                              onClick: () {
                                print("Ali Azad");
                                // showDialog(
                                //     context: context,
                                //     builder: (context) {
                                //       return AlertDialog(
                                //           title: Text("Are you sure?"),
                                //           actions: [
                                //             FlatButton(
                                //               child: Text("Yes"),
                                //               onPressed: () {
                                //                 IdeasServices().deleteIdea(
                                //                   widget.idea.id,
                                //                   token,
                                //                 );
                                //               },
                                //             ),
                                //             FlatButton(
                                //               child: Text("Cancel"),
                                //               onPressed: () {
                                //                 Navigator.of(context).pop();
                                //               },
                                //             ),
                                //           ]);
                                //     });
                              },
                              value: 2,
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                            title: Text("Are you sure?"),
                                            actions: [
                                              FlatButton(
                                                child: Text("Yes"),
                                                onPressed: () {
                                                  widget
                                                      .scaffoldKey.currentState
                                                      .showSnackBar(SnackBar(
                                                    content: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text("Waiting"),
                                                          CircularProgressIndicator(),
                                                        ]),
                                                    duration: Duration(
                                                      minutes: 1000,
                                                    ),
                                                  ));
                                                  widget.ideasProvider
                                                      .deleteIdea(
                                                          widget.idea.id, token)
                                                      .then((status) {
                                                    if (status == true) {
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context)
                                                          .pop();
                                                      widget.scaffoldKey
                                                          .currentState
                                                          .hideCurrentSnackBar();
                                                    } else {
                                                      widget.scaffoldKey
                                                          .currentState
                                                          .showSnackBar(
                                                              SnackBar(
                                                        content: Text(
                                                            "Something went wrong!! Please try again later."),
                                                        backgroundColor:
                                                            Colors.red,
                                                      ));
                                                    }
                                                  }).catchError((e) {
                                                    widget.scaffoldKey
                                                        .currentState
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Something went wrong!! Please try again later."),
                                                      backgroundColor:
                                                          Colors.red,
                                                    ));
                                                  });
                                                  // IdeasServices()
                                                  //     .deleteIdea(
                                                  //         widget.idea.id, token)
                                                  //     .then((status) {
                                                  //   if (status == true) {
                                                  //     Navigator.of(context)
                                                  //         .pop();
                                                  //     widget.onDelete();
                                                  //     setState(() {});
                                                  //   } else {
                                                  //     setState(() {});
                                                  //     Navigator.of(context)
                                                  //         .pop();
                                                  //     print("Not working");
                                                  //   }
                                                  // });
                                                },
                                              ),
                                              FlatButton(
                                                child: Text("Cancel"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ]);
                                      });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  decoration: BoxDecoration(
                                    // color: ,
                                    border: Border.all(
                                        color: Colors.grey[200], width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Delete"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Post On",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: "Requirments: ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: "${widget.idea.ideaText}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ]),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget myPopMenu() {
    return PopupMenuButton(
        onSelected: (value) {
          print(value);
        },
        itemBuilder: (context) => [
              PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                        child: Icon(Icons.print),
                      ),
                      Text('Print')
                    ],
                  )),
              PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                        child: Icon(Icons.share),
                      ),
                      Text('Share')
                    ],
                  )),
              PopupMenuItem(
                  value: 3,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                        child: Icon(Icons.add_circle),
                      ),
                      Text('Add')
                    ],
                  )),
            ]);
  }
}
