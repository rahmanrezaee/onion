import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/models/CountryDensityModel.dart';
import 'package:onion/widgets/Home/MyGoogleMap.dart';
import 'package:provider/provider.dart';

class SmallDropCount extends StatefulWidget {
  final List<CountryDensityModel> myDropDownList;
  final Color dropDownAroundColor;
  final Color txtColor;
  final Color dropDownColor;
  final Color iconColor;
  final bool myisExpanded;
  final double dropDownWidth;

  SmallDropCount({
    Key key,
    @required this.myDropDownList,
    @required this.dropDownAroundColor,
    @required this.myisExpanded,
    this.txtColor,
    this.dropDownColor,
    this.iconColor,
    this.dropDownWidth,
  });

  @override
  _MySmallDropCount createState() => _MySmallDropCount();
}

class _MySmallDropCount extends State<SmallDropCount> {
  String _value;
  String hintTxt = "Country";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(deviceSize(context).width * 0.01),
      margin: EdgeInsets.symmetric(
        horizontal: deviceSize(context).width * 0.01,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: widget.dropDownAroundColor),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: Center(
          child: DropdownButton(
            value: _value,
            isExpanded: widget.myisExpanded,
            iconDisabledColor: widget.iconColor,
            iconEnabledColor: widget.iconColor,
            dropdownColor: widget.dropDownColor,
            hint: Text(
              hintTxt,
              textScaleFactor: 0.7,
              style: TextStyle(color: Colors.grey),
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
                        width: widget.dropDownWidth,
                        child: Text(
                          "${e.countryName}",
                          textScaleFactor: 0.7,
                          style: TextStyle(color: widget.txtColor),
                        ),
                      ),
                      value: e.countryName,
                    );
                  }).toList()
                : null,
          ),
        ),
      ),
    );
  }
}

class MyPopTxt extends StatelessWidget {
  final String myTxt;

  const MyPopTxt({
    Key key,
    this.myTxt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceSize(context).width * 0.8,
      padding: EdgeInsets.all(deviceSize(context).width * 0.02),
      margin: EdgeInsets.symmetric(
        horizontal: deviceSize(context).width * 0.01,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: SizedBox(
        width: deviceSize(context).width * 0.19,
        child: Text(
          myTxt,
          textScaleFactor: 0.8,
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
