import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onion/statemanagment/MyDropDownState.dart';
import 'package:provider/provider.dart';

import '../../statemanagment/dropDownItem/CategoryProvider.dart';
import '../../const/Size.dart';
import '../../const/color.dart';
import '../../statemanagment/dropDownItem/AnalyticsProvider.dart';
import '../../statemanagment/dropDownItem/IndustryProvider.dart';
import '../../statemanagment/dropDownItem/MyFlagState.dart';

class MySmallDropdown extends StatefulWidget {
  final List<CategoryModel> myDropDownList;

  final List<AnalyticsModel> myDropDownAnal;
  final Color dropDownAroundColor;
  final Color txtColor;
  final Color dropDownColor;
  final Color iconColor;
  final bool myisExpanded;
  final String futureType;
  String firstVal;
  final Color hintColor;
  final double dropDownWidth;

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
    this.myDropDownAnal,
    this.dropDownWidth,
    this.hintColor = Colors.white,
  });

  @override
  _MySmallDropdownState createState() => _MySmallDropdownState();
}

class _MySmallDropdownState extends State<MySmallDropdown> {
  String _value;
  Future<void> myFuture;
  String name;
  String hintTxt = "country";
  AnalyticsProvider analyticsProvider;
  IndustryProvider industryProvider;
  CategoryProvider categoryProvider;
  bool isOpened = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("Mahdi Object ${widget.myDropDownList}");
    if (widget.futureType == "category") {
      hintTxt = "Category";
    } else if (widget.futureType == "industry") {
      hintTxt = "Industry";
    } else if (widget.futureType == "analytics") {
      hintTxt = "Analytics";
    }
  }

  @override
  Widget build(BuildContext context) {
    categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    industryProvider = Provider.of<IndustryProvider>(context, listen: false);
    analyticsProvider = Provider.of<AnalyticsProvider>(context, listen: false);
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
              style: TextStyle(color: widget.hintColor),
            ),
            onChanged: (value) async {
              setState(() {
                _value = value;
              });
              if (widget.futureType == "category") {
                // Provider.of<MyDropDownState>(context, listen: false)
                //     .setCategorySelected(true);
                industryProvider.clearDate();
                analyticsProvider.clearCountryData();
                await industryProvider.fetchItems(
                  name: value,
                  context: context,
                );
                categoryProvider.setCatName(value);
              } else if (widget.futureType == "industry") {
                // Provider.of<MyDropDownState>(context, listen: false)
                //     .setIndustrySelected(true);
                analyticsProvider.clearCountryData();
                await analyticsProvider.fetchItems(
                  name: value,
                  context: context,
                );
              } else if (widget.futureType == "analytics") {
                // Provider.of<MyDropDownState>(context, listen: false)
                //     .setAnalyticsSelected();
                // analyticsProvider.clearCountryData();
                // analyticsProvider.setCountryItems(title: value);
                analyticsProvider.setAnalysisId(analysisName: value);
                analyticsProvider.clearCountryData();
                analyticsProvider.setBigDropSelected(false);
                await Future.delayed(
                  Duration(seconds: 1),
                  () => analyticsProvider.setCountryItems(title: value),
                );
              }
            },
            isDense: true,
            items: widget.futureType != "analytics"
                ? widget.myDropDownList.isNotEmpty
                    ? widget.myDropDownList.map((e) {
                        print("Mahdi: ${e.id}");
                        print("Mahdi: ${e.name}");
                        return DropdownMenuItem(
                          child: SizedBox(
                            width: widget.dropDownWidth,
                            child: Text(
                              "${e.name}",
                              textScaleFactor: 0.7,
                              style: TextStyle(color: widget.txtColor),
                            ),
                          ),
                          value: e.name,
                        );
                      }).toList()
                    : null
                : widget.myDropDownAnal.isNotEmpty
                    ? widget.myDropDownAnal.map((e) {
                        print("Mahdi: ${e.id}");
                        print("Mahdi: ${e.title}");
                        return DropdownMenuItem(
                          child: SizedBox(
                            width: widget.dropDownWidth,
                            child: Text(
                              "${e.title}",
                              textScaleFactor: 0.7,
                              style: TextStyle(color: widget.txtColor),
                            ),
                          ),
                          value: e.title,
                        );
                      }).toList()
                    : null,
          ),
        ),
      ),
    );
  }
}
