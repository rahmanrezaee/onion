
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/const/color.dart';

class MyInvestAs extends StatefulWidget {
  @override
  _MyInvestAsState createState() => _MyInvestAsState();
}

class _MyInvestAsState extends State<MyInvestAs> {
  int selectedShare;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: deviceSize(context).width * 0.18,
          child: AutoSizeText(
            "Invest As: ",
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Radio(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: 1,
          groupValue: selectedShare,
          activeColor: middlePurple,
          onChanged: (val) {
            setState(() {
              selectedShare = val;
            });
          },
        ),
        SizedBox(
          width: deviceSize(context).width * 0.2,
          child: AutoSizeText(
            "Share Holder",
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Radio(
          value: 2,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          groupValue: selectedShare,
          activeColor: middlePurple,
          onChanged: (val) {
            setState(() {
              selectedShare = val;
            });
          },
        ),
        SizedBox(
          width: deviceSize(context).width * 0.2,
          child: AutoSizeText(
            "Stake Money",
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
