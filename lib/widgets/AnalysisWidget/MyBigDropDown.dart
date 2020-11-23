import 'package:flutter/material.dart';

import '../../const/Size.dart';
import '../../const/color.dart';

class MyBigDropDown extends StatefulWidget {
  @override
  _MyBigDropDownState createState() => _MyBigDropDownState();
}

class _MyBigDropDownState extends State<MyBigDropDown> {
  int _value = 1; 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: deviceSize(context).height * 0.03,
        left: deviceSize(context).width * 0.03,
        right: deviceSize(context).width * 0.03,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: _value,
          iconDisabledColor: Colors.white,
          iconEnabledColor: Colors.white,
          dropdownColor: middlePurple,
          isDense: true,
          items: [
            DropdownMenuItem(
              child: Text(
                "Select Region",
                textScaleFactor: 1.4,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: 1,
            ),
            DropdownMenuItem(
              child: Text(
                "Second",
                textScaleFactor: 1.4,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: 2,
            ),
            DropdownMenuItem(
              child: Text(
                "Third",
                textScaleFactor: 1.4,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: 3,
            ),
            DropdownMenuItem(
              child: Text(
                "Fourth",
                textScaleFactor: 1.4,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: 4,
            ),
            DropdownMenuItem(
              child: Text(
                "Fourth",
                textScaleFactor: 1.4,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: 5,
            ),
            DropdownMenuItem(
              child: Text(
                "Fourth",
                textScaleFactor: 1.4,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: 6,
            ),
            DropdownMenuItem(
              child: Text(
                "Second",
                textScaleFactor: 1.4,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: 7,
            ),
            DropdownMenuItem(
              child: Text(
                "Third",
                textScaleFactor: 1.4,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: 8,
            ),
            DropdownMenuItem(
              child: Text(
                "Fourth",
                textScaleFactor: 1.4,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: 9,
            ),
            DropdownMenuItem(
              child: Text(
                "Fourth",
                textScaleFactor: 1.4,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: 10,
            ),
            DropdownMenuItem(
              child: Text(
                "Fourth",
                textScaleFactor: 1.4,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: 11,
            ),
            DropdownMenuItem(
              child: Text(
                "Second",
                textScaleFactor: 1.4,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: 12,
            ),
            DropdownMenuItem(
              child: Text(
                "Third",
                textScaleFactor: 1.4,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: 13,
            ),
            DropdownMenuItem(
              child: Text(
                "Fourth",
                textScaleFactor: 1.4,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: 14,
            ),
            DropdownMenuItem(
              child: Text(
                "Fourth",
                textScaleFactor: 1.4,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: 15,
            ),
            DropdownMenuItem(
              child: Text(
                "Fourth",
                textScaleFactor: 1.4,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: 16,
            )
          ],
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
        ),
      ),
    );
  }
}
