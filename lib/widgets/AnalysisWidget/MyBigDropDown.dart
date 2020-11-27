import 'package:flutter/material.dart';
import 'package:onion/statemanagment/MyDropDownState.dart';
import 'package:onion/statemanagment/dropDownItem/CategoryProvider.dart';
import 'package:onion/widgets/Home/MyGoogleMap.dart';
import 'package:provider/provider.dart';

import '../../const/Size.dart';
import '../../const/color.dart';

class MyBigDropDown extends StatefulWidget {
  const MyBigDropDown({
    Key key,
  }) : super(key: key);

  @override
  _MyBigDropDownState createState() => _MyBigDropDownState();
}

class _MyBigDropDownState extends State<MyBigDropDown> {
  String _value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("Mahdi: ${widget.myDropDownList}");
    // widget.myDropDownList.map((e) => print("Mahdi: $e"));
    return Padding(
      padding: EdgeInsets.only(
        top: deviceSize(context).height * 0.03,
        left: deviceSize(context).width * 0.03,
        right: deviceSize(context).width * 0.03,
      ),
      child: Consumer<MyDropDownState>(
        builder: (BuildContext context, val, Widget child) {
          print("Mahdi Executed Bool ${val.myBigDropSelected}");
          if (val.tempItem != null) {
            _value = val.tempItem;
          }
          return DropdownButtonHideUnderline(
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
                  if (value != "Country") {
                    val.selectSingle(name: value);
                  }
                  setState(() {
                    _value = value;
                  });
                },
                isDense: true,
                items: val.items.isNotEmpty
                    ? val.items.map((e) {
                        return DropdownMenuItem(
                          child: SizedBox(
                            width: deviceSize(context).width * 0.8,
                            child: Text(
                              "${e.countryName}",
                              textScaleFactor: 0.8,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          value: e.countryName,
                        );
                      }).toList()
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}
