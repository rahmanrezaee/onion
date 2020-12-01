import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onion/statemanagment/ChatManagement/Constants.dart';
import 'package:onion/statemanagment/ChatManagement/HelperFunctions.dart';
import 'package:onion/statemanagment/ChatManagement/database.dart';
import 'package:onion/widgets/MRaiseButton.dart';
import 'package:onion/widgets/MyAppBar.dart';
import 'package:provider/provider.dart';

import './NotificationsList.dart';
import '../const/color.dart';
import '../const/Size.dart';
import '../widgets/MyLittleAppbar.dart';

class MyMessagePage extends StatefulWidget {
  static const routeName = "my_message";
  Function openDrawer;

  MyMessagePage({Key key, this.openDrawer});

  @override
  _MyMessagePageState createState() => _MyMessagePageState();
}

class _MyMessagePageState extends State<MyMessagePage> {
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPereference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "My Message", openDrawer: widget.openDrawer),
      body: FutureBuilder(
        future: Provider.of<DatabaseMethods>(context, listen: false)
            .getUserByUserName(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.error != null) {
              return Center(
                child: Text("Error Occurred"),
              );
            } else {
              return Column(
                children: [
                  MyTextFieldMessage(),
                  Expanded(
                    child: Consumer<DatabaseMethods>(
                      builder: (BuildContext context, value, Widget child) {
                        return ListView.builder(
                          itemCount: value.searchSnapshot.documents.length,
                          padding: EdgeInsets.symmetric(
                            horizontal: deviceSize(context).width * 0.03,
                            vertical: deviceSize(context).height * 0.01,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            print("Mahdi Listview: ");
                            print(
                                "Mahdi Listview: ${value.searchSnapshot.documents[index].get('name')}");
                            print(
                                "Mahdi Listview: ${value.searchSnapshot.documents[index].get('email')}");
                            // return SizedBox.shrink();
                            return MyCardItem(
                              myImageType: "circle",
                              clickType: "message",
                              name:
                                  "${value.searchSnapshot.documents[index].get('name')}",
                              message:
                                  "${value.searchSnapshot.documents[index].get('email')}",
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }
}

class MyTextFieldMessage extends StatefulWidget {
  @override
  _MyTextFieldMessageState createState() => _MyTextFieldMessageState();
}

class _MyTextFieldMessageState extends State<MyTextFieldMessage> {
  DateTime selectedDate;
  final searchController = TextEditingController();
  QuerySnapshot searchSnapshot;

  DatabaseMethods databaseMethods = new DatabaseMethods();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: middlePurple,
            accentColor: middlePurple,
            colorScheme: ColorScheme.light(primary: middlePurple),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  void submitForm() {
    print("Mahdi");
    // databaseMethods.getUserByUserName(searchController.text).then((val) {
    //   searchSnapshot = val;
    //   var list = val.documents;
    //   print("Mahdi Name: ${searchSnapshot.documents[0].get('name')}");
    //   print("Mahdi Name: fire $val");
    //   print("Mahdi Name: list $list");
    // });
    // searchSnapshot.documents.map((e) => print("Mahdi Name: list $e"));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: deviceSize(context).height * 0.02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: deviceSize(context).width * 0.5,
            height: deviceSize(context).height * 0.06,
            child: TextFormField(
              controller: searchController,
              onFieldSubmitted: (_) => submitForm(),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: grey),
                ),
                contentPadding: EdgeInsets.only(
                  top: deviceSize(context).height * 0.01,
                  left: deviceSize(context).width * 0.02,
                ),
                fillColor: grey,
                hintText: "Search Users |",
                filled: true,
              ),
            ),
          ),
          MRaiseButton(
            mFunc: _selectDate,
            mTxtBtn: selectedDate == null
                ? "Choose Date"
                : DateFormat("yyy-M-dd").format(selectedDate),
            isIcon: true,
            mWidth: deviceSize(context).width * 0.4,
            mHeight: deviceSize(context).height * 0.06,
          ),
        ],
      ),
    );
  }
}
