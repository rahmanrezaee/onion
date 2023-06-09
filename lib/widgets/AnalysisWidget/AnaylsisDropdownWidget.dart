import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onion/models/AnalyticsModel.dart';
import '../../const/Size.dart';

class AnaylsisDropDown extends StatelessWidget {
  final List<AnalyticsModel> myDropDownList;
  final Color dropDownAroundColor;
  final Color txtColor;
  final Color dropDownColor;
  final Color iconColor;
  final bool myisExpanded;
  final String futureType;
  String value;
  Function onChange;
  final Color hintColor;
  final double dropDownWidth;

  AnaylsisDropDown({
    Key key,
    @required this.myDropDownList,
    @required this.dropDownAroundColor,
    @required this.myisExpanded,
    this.txtColor,
    this.onChange,
    this.dropDownColor,
    this.iconColor,
    this.futureType,
    this.value,
    this.dropDownWidth,
    this.hintColor = Colors.white,
  });

  String hintTxt = "country";
  bool isOpened = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(deviceSize(context).width * 0.01),
      margin: EdgeInsets.symmetric(
        horizontal: deviceSize(context).width * 0.01,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: dropDownAroundColor),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: Center(
          child: DropdownButton(
              value: value,
              isExpanded: myisExpanded,
              iconDisabledColor: iconColor,
              iconEnabledColor:iconColor,
              dropdownColor: dropDownColor,
              hint: Text(
                hintTxt,
                textScaleFactor: 0.7,
                style: TextStyle(color: hintColor),
              ),
              onChanged: onChange,
              isDense: true,
              items: myDropDownList.isNotEmpty
                  ?myDropDownList.map((e) {
                      return DropdownMenuItem(
                        child: SizedBox(
                          width: dropDownWidth,
                          child: Text(
                            "${e.title}",
                            textScaleFactor: 0.7,
                            style: TextStyle(color: txtColor),
                          ),
                        ),
                        value: e.title,
                      );
                    }).toList()
                  : null),
        ),
      ),
    );
  }
}
