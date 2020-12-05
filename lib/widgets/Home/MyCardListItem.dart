import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../const/Size.dart';
import '../../const/color.dart';
import '../../pages/authentication/Login.dart';
import '../../statemanagment/auth_provider.dart';
import './MyAutoTextSize.dart';

class MyCardListItem extends StatefulWidget {
  Function callBack;

  MyCardListItem({
    this.callBack,
    Key key,
  }) : super(key: key);

  @override
  _MyCardListItemState createState() => _MyCardListItemState();
}

class _MyCardListItemState extends State<MyCardListItem> {
  @override
  Widget build( context) {
    return Card(
      child: Container(
        height: deviceSize(context).height * 0.17,
        padding: EdgeInsets.only(
          left: deviceSize(context).height * 0.014,
          right: deviceSize(context).height * 0.014,
          top: deviceSize(context).height * 0.014,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Container(
                  height: deviceSize(context).width * 0.16,
                  width: deviceSize(context).width * 0.16,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(
                      deviceSize(context).width * 0.02,
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/empty_profile.jpg",
                      ),
                    ),
                  ),
                ),
                SizedBox(width: deviceSize(context).width * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MyAutoTextSize(
                      myTxt: "Your Ideas! Our Believe!, ",
                      myColor: Colors.black,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: deviceSize(context).width * 0.1,
                        maxWidth: deviceSize(context).width * 0.6,
                        minHeight: deviceSize(context).width * 0.01,
                        maxHeight: deviceSize(context).width * 0.09,
                      ),
                      child: Text(
                        "Lorem Ipsum is simply ",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: deviceSize(context).height * 0.02),
            Consumer<Auth>(
              builder: (consumerContext, val, child) {
                return Expanded(
                  child: GestureDetector(
                    child: Text(
                      "Post an Idea Now",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: firstPurple,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () => val.token != null
                        ? widget.callBack()
                        : Navigator.pushNamed(context, Login.routeName),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
