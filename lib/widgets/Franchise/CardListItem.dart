import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/const/values.dart';

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

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

  Widget _childPopup() => PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text(
              "Earth",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Text(
              "Moon",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          PopupMenuItem(
            value: 3,
            child: Text(
              "Sun",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
        child: Container(
          height: 50,
          width: 200,
          decoration: ShapeDecoration(
            color: Colors.green,
            shape: StadiumBorder(
              side: BorderSide(color: Colors.black, width: 2),
            ),
          ),
          child: Icon(Icons.airplanemode_active),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final button = new PopupMenuButton(
      key: _menuKey,
      padding: EdgeInsets.zero,
      color: Colors.grey,
      itemBuilder: (_) => <PopupMenuItem<String>>[
        PopupMenuItem<String>(
          child: const Text('Doge'),
          value: 'Doge',
        ),
        PopupMenuItem<String>(
          child: const Text('Lion'),
          value: 'Lion',
        ),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
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
                      text: lormIpsum,
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
