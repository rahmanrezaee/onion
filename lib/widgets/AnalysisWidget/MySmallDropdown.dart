import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../statemanagment/dropDownItem/CategoryProvider.dart';
import '../../const/Size.dart';
import '../../const/color.dart';
import '../../statemanagment/dropDownItem/AnalyticsProvider.dart';
import '../../statemanagment/dropDownItem/IndustryProvider.dart';
import '../../statemanagment/dropDownItem/MyFlagState.dart';

class MySmallDropdown extends StatefulWidget {
  final List<CategoryModel> myDropDownList;
  final Color dropDownAroundColor;
  final Color txtColor;
  final Color dropDownColor;
  final Color iconColor;
  final bool myisExpanded;
  final String futureType;
  String firstVal;

  MySmallDropdown({
    Key key,
    @required this.myDropDownList,
    @required this.dropDownAroundColor,
    @required this.myisExpanded,
    this.txtColor,
    this.dropDownColor,
    this.iconColor,
    this.futureType,
    this.firstVal,
  });

  @override
  _MySmallDropdownState createState() => _MySmallDropdownState();
}

class _MySmallDropdownState extends State<MySmallDropdown> {
  String _value;
  Future<void> myFuture;
  String name;
  AnalyticsProvider analyticsProvider;
  IndustryProvider industryProvider;
  CategoryProvider categoryProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("Mahdi Object ${widget.myDropDownList}");
    // // _value = widget.firstVal;
    if (widget.futureType == "category") {
      _value = widget.firstVal;
    } else if (widget.futureType == "industry") {
      _value = widget.firstVal;
    } else if (widget.futureType == "analytics") {
      _value = widget.firstVal;
    }
  }

  @override
  Widget build(BuildContext context) {
    analyticsProvider = Provider.of<AnalyticsProvider>(context, listen: false);
    categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    industryProvider = Provider.of<IndustryProvider>(
      context,
      listen: false,
    );

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
              _value = value;

              if (widget.futureType == "category") {
                // industryProvider.clearDate();
                // categoryProvider.updateIndustryItem(value, context);
                print("Mahdi II $value");
                industryProvider.clearDate();
                industryProvider.fetchItems(name: value, context: context);
                // industryProvider.fetchItems(
                //   name: _value,
                //   context: context,
                // );
                // analyticsProvider.clearDate();
                // analyticsProvider.fetchItems(
                //   name: _value,
                //   context: context,
                // );
              } else if (widget.futureType == "industry") {
                // widget.firstVal = value;
                // analyticsProvider.clearDate();
                // analyticsProvider.fetchItems(
                //   name: _value,
                //   context: context,
                // );
                analyticsProvider.clearDate();
                analyticsProvider.fetchItems(name: value, context: context);
              }
              setState(() {
                _value = value;
              });
            },
            isDense: true,
            items: widget.myDropDownList.isNotEmpty
                ? widget.myDropDownList.map((e) {
                    print("Mahdi: ${e.id}");
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
