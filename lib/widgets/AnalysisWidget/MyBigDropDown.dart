import 'package:flutter/material.dart';
import 'package:onion/models/circularChart.dart';
import '../../const/Size.dart';
import '../../const/color.dart';

class MyBigDropDown extends StatelessWidget {
  final List<CircularChart> myDropDownAnal;
  final Color iconEnabledColor;
  final Color txtColor;
  final String firstVal;
  Function onChange;

  MyBigDropDown({
    Key key,
    this.myDropDownAnal,
    this.iconEnabledColor = Colors.white,
    this.txtColor = Colors.white,
    this.firstVal,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: deviceSize(context).height * 0.03,
        left: deviceSize(context).width * 0.03,
        right: deviceSize(context).width * 0.03,
      ),
      child: DropdownButtonHideUnderline(
        child: Center(
          child: DropdownButton(
            value: firstVal,
            isExpanded: true,
            iconDisabledColor: iconEnabledColor,
            iconEnabledColor: iconEnabledColor,
            dropdownColor: middlePurple,
            hint: Text(
              "Country",
              style: TextStyle(color: txtColor),
            ),
            onChanged: onChange,
            isDense: true,
            items: myDropDownAnal.isNotEmpty
                ? myDropDownAnal.map((e) {
                    return DropdownMenuItem(
                      child: SizedBox(
                        width: deviceSize(context).width * 0.8,
                        child: Text(
                          "${e.country}",
                          textScaleFactor: 0.7,
                          style: TextStyle(color: txtColor),
                        ),
                      ),
                      value: e.country,
                    );
                  }).toList()
                : null,
          ),
        ),
      ),
    );
  }
}
