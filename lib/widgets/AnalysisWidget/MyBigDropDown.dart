import 'package:flutter/material.dart';
import 'package:onion/statemanagment/dropDownItem/CategoryProvider.dart';

import '../../const/Size.dart';
import '../../const/color.dart';

class MyBigDropDown extends StatefulWidget {
  final List<CategoryModel> myDropDownList;

  final Color txtColor;

  const MyBigDropDown({
    Key key,
    this.myDropDownList,
    this.txtColor,
  }) : super(key: key);

  @override
  _MyBigDropDownState createState() => _MyBigDropDownState();
}

class _MyBigDropDownState extends State<MyBigDropDown> {
  String _value;

  @override
  Widget build(BuildContext context) {
    print("Mahdi: ${widget.myDropDownList}");
    widget.myDropDownList.map((e) => print("Mahdi: $e"));
    return Padding(
      padding: EdgeInsets.only(
        top: deviceSize(context).height * 0.03,
        left: deviceSize(context).width * 0.03,
        right: deviceSize(context).width * 0.03,
      ),
      child: DropdownButtonHideUnderline(
        child: Center(
          child: DropdownButton(
            value: _value,
            isExpanded: true,
            iconDisabledColor: Colors.grey,
            iconEnabledColor: Colors.white,
            dropdownColor: middlePurple,
            hint: Text(
              "Country",
              style: TextStyle(color: Colors.white),
            ),
            onChanged: (value) async {
              setState(() {
                _value = value;
              });
            },
            isDense: true,
            items: widget.myDropDownList.isNotEmpty
                ? widget.myDropDownList.map((e) {
              return DropdownMenuItem(
                child: SizedBox(
                  width: deviceSize(context).width * 0.17,
                  child: Text(
                    "${e.name}",
                    textScaleFactor: 0.7,
                    style: TextStyle(color: widget.txtColor),
                  ),
                ),
                value: e.name,
              );
            }).toList()
                : null,
          ),
        ),
      ),
    );
  }
}
