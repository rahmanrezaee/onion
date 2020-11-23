import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../const/Size.dart';
import '../../const/color.dart';
import '../../const/values.dart';

import '../MRaiseButton.dart';

class CardListItem extends StatefulWidget {
  const CardListItem({
    Key key,
  }) : super(key: key);

  @override
  _CardListItemState createState() => _CardListItemState();
}

class _CardListItemState extends State<CardListItem> {
  final GlobalKey _menuKey = new GlobalKey();
  var _selection;

  @override
  Widget build(BuildContext context) {
    final button = new PopupMenuButton(
      key: _menuKey,
      padding: EdgeInsets.zero,
      color: Colors.white,
      itemBuilder: (_) => <PopupMenuItem<String>>[
        PopupMenuItem<String>(
          child: Container(
            width: deviceSize(context).width * 0.5,
            height: deviceSize(context).height * 0.06,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[firstPurple, thirdPurple],
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              "View Profile",
              style: TextStyle(color: Colors.white.withOpacity(0.7)),
            ),
          ),
          value: 'Doge',
        ),
        PopupMenuItem(
          child: RaisedButton(
            child: Text("data"),
            onPressed: () {},
          ),
        ),
        // PopupMenuItem<String>(
        //   child: MRaiseButton(
        //     isIcon: false,
        //     mFunc: null,
        //     mHeight: deviceSize(context).height * 0.06,
        //     mWidth: deviceSize(context).width * 0.07,
        //     mTxtBtn: "View Profile",
        //   ),
        //   value: 'Lion',
        // ),
      ],
      onSelected: (_) {},
    );

    return Card(
      child: Padding(
        padding: EdgeInsets.all(deviceSize(context).height * 0.02),
        child: Column(
          children: [
            SizedBox(
              height: deviceSize(context).height * 0.08,
              child: Row(
                children: [
                  SizedBox(
                    height: deviceSize(context).height * 0.08,
                    width: deviceSize(context).height * 0.08,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/images/empty_profile.jpg',
                      ),
                    ),
                  ),
                  SizedBox(width: deviceSize(context).width * 0.01),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyRichText(
                        firstTxt: "Name",
                        secondTxt: "Stephen",
                      ),
                      MyRichText(
                        firstTxt: "Brand",
                        secondTxt: "Abcdxyz",
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    color: Colors.blue,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: button,
                          onTap: () {
                            dynamic state = _menuKey.currentState;
                            state.showButtonMenu();
                          },
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 3.0),
                        //   child: Text(
                        //     "30/08/2020-11:00AM",
                        //     textScaleFactor: 0.8,
                        //     style: TextStyle(color: Colors.grey),
                        //   ),
                        // )
                      ],
                    ),
                  )
                ],
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: deviceSize(context).height * 0.1,
                maxHeight: deviceSize(context).height * 0.4,
              ),
              child: RichText(
                text: TextSpan(
                  text: "Wrote: ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                  children: [
                    TextSpan(
                      text: loremIpsum,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyRichText extends StatelessWidget {
  final String firstTxt;
  final String secondTxt;

  const MyRichText({
    Key key,
    this.firstTxt,
    this.secondTxt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "$firstTxt: ",
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: "$secondTxt",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
