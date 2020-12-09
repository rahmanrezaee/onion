import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:onion/const/values.dart';
import 'package:onion/models/FranchiesModel.dart';
import 'package:onion/pages/Idea/MyIdeaDetailes.dart';
import 'package:onion/pages/franchises/RequestOnFranchise.dart';
import 'package:onion/pages/franchises/ViewMyRequestFranchise.dart';
import 'package:onion/pages/franchises/addFranchise.dart';
import 'package:onion/pages/franchises/viewFranchisesUser.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/statemanagment/franchise_provider.dart';
import 'package:onion/widgets/IdeaWiget/popupMenu.dart' as mypopup;
import 'package:provider/provider.dart';

class FranchiseItem extends StatefulWidget {
  FranchiesModel franchiesModel;
  FranchiseItem(this.franchiesModel);
  @override
  _FranchiseItemState createState() => _FranchiseItemState();
}

class _FranchiseItemState extends State<FranchiseItem> {
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Auth>(context, listen: false);
    var franchies = Provider.of<FranchiesProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ViewFranchisesUser.routeName,
            arguments: widget.franchiesModel);
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
                    backgroundImage:
                        NetworkImage(BASE_URL + "/user/avatar/${auth.id}"),
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
                              text: widget.franchiesModel.industry,
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
                              text: "Brand: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: widget.franchiesModel.brandName,
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
                        mypopup.PopupMenuButton<String>(
                          elevation: 20,
                          padding: EdgeInsets.all(10),
                          offset: Offset(50, 50),
                          itemBuilder: (context) => [
                            mypopup.PopupMenuItem(
                              value: "edit",
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                      context, AddFranchise.routeName,
                                      arguments: widget.franchiesModel);
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
                              value: "view",
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
                                    Text("View Request"),
                                  ],
                                ),
                              ),
                            ),
                            mypopup.PopupMenuItem(
                              value: "franchies",
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                      context, RequestOnFranchise.routeName,
                                      arguments: widget.franchiesModel);
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
                                      Text("View Franchise"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            mypopup.PopupMenuItem(
                              value: "delete",
                              child: InkWell(
                                onTap: () {
                                  Widget okButton = FlatButton(
                                    child: Text("OK"),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      franchies.deleteFranchies(
                                          id: widget.franchiesModel.id);
                                      Navigator.pop(context);
                                    },
                                  );

                                  Widget cancelButton = FlatButton(
                                    child: Text("Cancel"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  );

                                  // set up the AlertDialog
                                  AlertDialog alert = AlertDialog(
                                    title: Text("Delete"),
                                    content: Text(
                                        "Do you want to delete this Analysis?"),
                                    actions: [
                                      cancelButton,
                                      okButton,
                                    ],
                                  );

                                  // show the dialog
                                  return showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alert;
                                    },
                                  );
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
                          text: widget.franchiesModel.requirments,
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
