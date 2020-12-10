import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:onion/models/FranchiesModel.dart';
import 'package:onion/models/requestFranchiesModel.dart';
import 'package:onion/pages/franchises/view_franchies_intersted_reqeust.dart';
import 'package:onion/widgets/IdeaWiget/popupMenu.dart' as mypopup;
import '../../const/Size.dart';
import '../../const/color.dart';
import '../../const/values.dart';

import '../MRaiseButton.dart';

class CardListItem extends StatefulWidget {

  Map dat;
  
  CardListItem(
    this.dat, {
    Key key,
  }) : super(key: key);

  @override
  _CardListItemState createState() => _CardListItemState();
}

class _CardListItemState extends State<CardListItem> {
  final GlobalKey _menuKey = new GlobalKey();
  RequestFranchiesModel franchiesRequestModel;
  FranchiesModel franchiesModel;

  var _selection;
 @override
  initState() {
    
    super.initState();
    franchiesModel = widget.dat["franch"];
    franchiesRequestModel = widget.dat["request"];
  
  }

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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: deviceSize(context).height * 0.08,
                    width: deviceSize(context).height * 0.08,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        '$BASE_URL/user/avatar/${franchiesRequestModel.id}',
                      ),
                    ),
                  ),
                  SizedBox(width: deviceSize(context).width * 0.01),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyRichText(
                        firstTxt: "Name",
                        secondTxt: "${franchiesRequestModel.userData.username}",
                      ),
                      // Spacer(),
                      SizedBox(height: 5),
                      MyRichText(
                        firstTxt: "Interested",
                        secondTxt: "${franchiesRequestModel.userData.interst}",
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
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
                              value: "View Profile",
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
                                    Text("View Profile"),
                                  ],
                                ),
                              ),
                            ),
                            mypopup.PopupMenuItem(
                              value: "Message",
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  // Navigator.pushNamed(
                                  //     context, RequestOnFranchise.routeName,
                                  //     arguments: widget.franchiesModel);
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
                                      Text("Message"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            mypopup.PopupMenuItem(
                              value: "View",
                              child: InkWell(
                                onTap: () {

                                  Navigator.pushNamed(context, viewFranchiesInterstedReqeust.routeName,arguments: widget.dat);

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
                                      Text("View"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 3.0),
                          child: Text(
                            Jiffy("${franchiesRequestModel.date}").yMMMd,
                            // Jiffy("${franchiesRequestModel.date}").fromNow(),
                            textScaleFactor: 0.8,
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
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
                      text: "${franchiesRequestModel.message}",
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
