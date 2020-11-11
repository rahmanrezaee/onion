import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onion/statemanagment/dropDownItem/AnalyticsProvider.dart';
import 'package:onion/statemanagment/dropDownItem/IndustryProvider.dart';
import 'package:onion/statemanagment/dropDownItem/MyFlagState.dart';
import 'package:provider/provider.dart';

import '../../statemanagment/dropDownItem/CategoryProvider.dart';
import '../../const/Size.dart';
import '../../const/color.dart';

class MySmallDropdown extends StatefulWidget {
  final List<CategoryModel> myDropDownList;
  final Color dropDownAroundColor;
  final Color txtColor;
  final Color dropDownColor;
  final Color iconColor;
  final bool myisExpanded;
  final String futureType;

  const MySmallDropdown({
    Key key,
    @required this.myDropDownList,
    @required this.dropDownAroundColor,
    @required this.myisExpanded,
    this.txtColor,
    this.dropDownColor,
    this.iconColor,
    this.futureType,
  });

  @override
  _MySmallDropdownState createState() => _MySmallDropdownState();
}

class _MySmallDropdownState extends State<MySmallDropdown> {
  String _value;
  Future<void> myFuture;
  String name;
  AnalyticsProvider analyticsProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Mahdi Object ${widget.myDropDownList}");
  }

  @override
  Widget build(BuildContext context) {
    analyticsProvider = Provider.of<AnalyticsProvider>(context, listen: false);
    if(widget.myDropDownList.isNotEmpty){
      _value = widget.myDropDownList[0].name;
    }

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
            onChanged: (value) {
              print("mahdi: onChange $value");
              if (widget.futureType == "category") {
                Provider.of<IndustryProvider>(
                  context,
                  listen: false,
                ).fetchItems(name: value);
              } else if (widget.futureType == "industry") {
                analyticsProvider.fetchItems(name: value);
              }
              setState(() {
                _value = value;
              });
            },
            isDense: true,
            items: widget.myDropDownList.isNotEmpty
                ? widget.myDropDownList.map((e) {
                    return DropdownMenuItem(
                      child: SizedBox(
                        width: deviceSize(context).width * 0.19,
                        child: Text(
                          "${e.name}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
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
