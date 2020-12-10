import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/const/color.dart';
import 'package:onion/const/values.dart';
import 'package:onion/models/FranchiesModel.dart';
import 'package:onion/models/requestFranchiesModel.dart';
import 'package:onion/widgets/IdeaWiget/popupMenu.dart' as mypopup;
import 'CardListItem.dart';

class DescriptionIntersted extends StatelessWidget {
  RequestFranchiesModel franchiesRequestModel;
  FranchiesModel franchiesModel;
  DescriptionIntersted({
    this.franchiesRequestModel,
    this.franchiesModel,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: deviceSize(context).width,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(deviceSize(context).height * 0.02),
          child: Column(
            children: [
              MyTxtRow(
                  firstTxt: "Industry",
                  secondTxt: "${franchiesModel.industry}"),
              Divider(color: Colors.grey),
              MyTxtRow(
                  firstTxt: "Brand", secondTxt: "${franchiesModel.brandName}"),
              Divider(color: Colors.grey),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: franchiesModel.location.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      MyTxtRow(
                          firstTxt: "${franchiesModel.location[index]}",
                          isIcon: true),
                      Divider(color: Colors.grey),
                    ],
                  );
                },
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: deviceSize(context).height * 0.1,
                  maxHeight: deviceSize(context).height * 0.4,
                ),
                child: RichText(
                  text: TextSpan(
                    text: "Requirements: ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    children: [
                      TextSpan(
                        text: "${franchiesModel.requirments}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                ),
              ),
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
                          secondTxt:
                              "${franchiesRequestModel.userData.username}",
                        ),
                        // Spacer(),
                        SizedBox(height: 5),
                        MyRichText(
                          firstTxt: "Interested",
                          secondTxt:
                              "${franchiesRequestModel.userData.interst}",
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Message"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                             
                            ],
                          ),
                         
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTxtRow extends StatelessWidget {
  final String firstTxt;
  final Color firstColor;
  final String secondTxt;
  final bool isIcon;

  const MyTxtRow({
    Key key,
    this.firstTxt,
    this.secondTxt,
    this.isIcon = false,
    this.firstColor = null,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$firstTxt",
          textScaleFactor: 0.9,
          style: TextStyle(
            color: firstColor == null ? Colors.grey : firstColor,
          ),
        ),
        Spacer(),
        isIcon
            ? Icon(Icons.location_on_outlined, color: middlePurple)
            : Text(
                "$secondTxt",
                textScaleFactor: 0.9,
                style: TextStyle(color: Colors.black),
              ),
      ],
    );
  }
}
