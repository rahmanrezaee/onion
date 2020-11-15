
import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/const/color.dart';

class AgreementTxt extends StatefulWidget {
  @override
  _AgreementTxtState createState() => _AgreementTxtState();
}

class _AgreementTxtState extends State<AgreementTxt> {
  bool checkedValue = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          activeColor: middlePurple,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: checkedValue,
          onChanged: (newValue) {
            setState(() {
              checkedValue = newValue;
            });
          },
        ),
        SizedBox(
          width: deviceSize(context).width * 0.8,
          child: RichText(
            text: TextSpan(
              text: "Agree to ",
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: "Terms and Condition",
                  style: TextStyle(
                    fontSize: 13.0,
                    color: firstPurple,
                  ),
                ),
                TextSpan(
                  text: " and",
                  children: [
                    TextSpan(
                      text: " Contract ",
                      style: TextStyle(
                        fontSize: 13.0,
                        color: firstPurple,
                      ),
                    ),
                  ],
                ),
                TextSpan(text: "while investing on this idea")
              ],
            ),
          ),
        )
      ],
    );
  }
}
