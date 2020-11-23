import 'package:flutter/material.dart';
import 'package:onion/models/circularChart.dart';

import '../../const/Size.dart';
import '../../const/color.dart';

class MyBigDropDown extends StatefulWidget {
  List<CircularChart> countyList;

  MyBigDropDown({this.countyList});
  @override
  _MyBigDropDownState createState() => _MyBigDropDownState();
}

class _MyBigDropDownState extends State<MyBigDropDown> {
  String _value = 'ALL';

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
          items: widget.countyList.map((e) {
            return DropdownMenuItem(
              child: Text(
                e.country,
                textScaleFactor: 1.4,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: e.countryCode,
            );
          }).toList(),
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
