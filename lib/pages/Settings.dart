import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Settings extends StatelessWidget {
  static String routeName = "Settings";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(children: [
          SizedBox(height: 15),
          //popup section start
          Text("Select your primary profile"),
          Container(
            height: 30,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ]),
//             alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Select Profile Type",
                    style: TextStyle(color: Colors.black)),
                PopupMenuButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                    onSelected: (result) {},
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          value: 1,
                          child: Text('I am Services provider'),
                        ),
                        const PopupMenuItem(
                          value: 2,
                          child: Text('I am Project manager'),
                        ),
                      ];
                    })
              ],
            ),
          ),
          SizedBox(height: 15),
          //popup section End
          //Card section start
          Text("Notification settings"),
          SizedBox(height: 10),
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Receive Email"),
                          Transform.scale(
                            scale: 0.6,
                            alignment: Alignment.centerRight,
                            child:
                                CupertinoSwitch(value: true, onChanged: (v) {}),
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Receive Website"),
                          Transform.scale(
                            scale: 0.6,
                            alignment: Alignment.centerRight,
                            child:
                                CupertinoSwitch(value: true, onChanged: (v) {}),
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Receive SMS"),
                          Transform.scale(
                            scale: 0.6,
                            alignment: Alignment.centerRight,
                            child:
                                CupertinoSwitch(value: true, onChanged: (v) {}),
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Receive App Updates"),
                          Transform.scale(
                            scale: 0.6,
                            alignment: Alignment.centerRight,
                            child:
                                CupertinoSwitch(value: true, onChanged: (v) {}),
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
              child: Text("SAVE CHANGES"),
              onPressed: () {},
            ),
          ),
        ]),
      ),
    );
  }
}
