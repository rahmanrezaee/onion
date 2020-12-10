import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/const/color.dart';
import 'package:onion/const/values.dart';
import 'package:onion/models/FranchiesModel.dart';

class Description extends StatelessWidget {
  FranchiesModel franchiesModel;
  
   Description(
    franchiesModel
    ,{
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
