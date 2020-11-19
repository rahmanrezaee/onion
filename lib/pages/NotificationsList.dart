import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/pages/ProjectChat.dart';

import '../const/values.dart';

class NotificationsList extends StatefulWidget {
  static const routeName = "notification_list";

  @override
  _NotificationsListState createState() => _NotificationsListState();
}

class _NotificationsListState extends State<NotificationsList> {
  int count = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_sweep),
            onPressed: () {
              setState(() {
                count = 0;
              });
            },
          )
        ],
        centerTitle: true,
      ),
      // bottomNavigationBar: SizedBox(
      //   height: deviceSize(context).height * 0.08,
      //   child: Padding(
      //     padding: const EdgeInsets.only(right: 5),
      //     child: Text(
      //       "Clear Notification",
      //       textScaleFactor: 1.1,
      //       textAlign: TextAlign.right,
      //       style: TextStyle(color: Colors.black),
      //     ),
      //   ),
      // ),
      body: count > 0 ? ListView.builder(
        itemCount: count,
        padding: EdgeInsets.symmetric(
          horizontal: deviceSize(context).width * 0.03,
          vertical: deviceSize(context).height * 0.01,
        ),
        itemBuilder: (BuildContext context, int index) {
          
          return  MyCardItem(myImageType: "rectangle") ;
        },
      ): Center(child:Text("List is Empty")),
    );
  }
}

class MyCardItem extends StatelessWidget {
  final String myImageType;
  final String clickType;

  const MyCardItem({
    Key key,
    this.myImageType,
    this.clickType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: clickType == "message"
          ? () {
              Navigator.pushNamed(context, ProjectChat.routeName);
            }
          : null,
      child: Card(
        elevation: 3,
        margin: EdgeInsets.symmetric(
          vertical: deviceSize(context).height * 0.005,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: deviceSize(context).width * 0.02,
            vertical: deviceSize(context).height * 0.025,
          ),
          child: SizedBox(
            height: deviceSize(context).height * 0.11,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                myImageType == "rectangle" ? RectangleImage() : MyCircleImage(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: deviceSize(context).width * 0.65,
                        child: Row(
                          children: [
                            Text(
                              "James H. Matt",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Text(
                              "28-Sep, 10:40",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: deviceSize(context).height * 0.1,
                            maxHeight: deviceSize(context).height,
                            minWidth: deviceSize(context).width * 0.4,
                            maxWidth: deviceSize(context).width * 0.6,
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: AutoSizeText(
                              loremIpsum,
                              textScaleFactor: 1.1,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                color: Colors.black,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyCircleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: deviceSize(context).width * 0.03,
      ),
      height: deviceSize(context).height * 0.08,
      width: deviceSize(context).height * 0.08,
      child: SizedBox(
        child: CircleAvatar(
          backgroundImage: AssetImage("assets/images/empty_profile.jpg"),
        ),
      ),
    );
  }
}

class RectangleImage extends StatelessWidget {
  const RectangleImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      margin: EdgeInsets.only(
        right: deviceSize(context).width * 0.03,
      ),
      child: Image.asset(
        "assets/images/logo.png",
        width: deviceSize(context).height * 0.11,
      ),
    );
  }
}
