import 'package:flutter/material.dart';
import 'package:onion/statemanagment/MyDropDownState.dart';
import 'package:onion/statemanagment/dropDownItem/AnalyticsProvider.dart';
import 'package:onion/statemanagment/dropDownItem/BigDropDownPro.dart';
import 'package:onion/statemanagment/dropDownItem/CategoryProvider.dart';
import 'package:onion/widgets/Home/MyGoogleMap.dart';
import 'package:provider/provider.dart';

import '../../const/Size.dart';
import '../../const/color.dart';

class MyBigDropDown extends StatefulWidget {
  final List<CountryDensityModel> myDropDownAnal;
  final Color iconEnabledColor;
  final Color txtColor;
  final String firstVal;

  const MyBigDropDown({
    Key key,
    this.myDropDownAnal,
    this.iconEnabledColor = Colors.white,
    this.txtColor = Colors.white,
    this.firstVal,
  }) : super(key: key);

  @override
  _MyBigDropDownState createState() => _MyBigDropDownState();
}

class _MyBigDropDownState extends State<MyBigDropDown> {
  String _value;
  AnalyticsProvider analysisProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.firstVal != null) {
      _value = widget.firstVal;
    }
  }

  @override
  Widget build(BuildContext context) {
    // print("Mahdi: ${widget.myDropDownList}");
    // widget.myDropDownList.map((e) => print("Mahdi: $e"));
    analysisProvider = Provider.of<AnalyticsProvider>(context, listen: false);

    return Padding(
      padding: EdgeInsets.only(
        top: deviceSize(context).height * 0.03,
        left: deviceSize(context).width * 0.03,
        right: deviceSize(context).width * 0.03,
      ),
      child: Consumer<AnalyticsProvider>(
        builder: (conCtx, conVal, conChild) {
          print("Clicked 1");
          if (conVal.myBigDropSelected) {
            _value = conVal.singleCountry;
            print("Clicked 2 ${conVal.myBigDropSelected}");
          }
          return DropdownButtonHideUnderline(
            child: Center(
              child: DropdownButton(
                value: _value,
                isExpanded: true,
                iconDisabledColor: widget.iconEnabledColor,
                iconEnabledColor: widget.iconEnabledColor,
                dropdownColor: middlePurple,
                hint: Text(
                  "Country",
                  style: TextStyle(color: widget.txtColor),
                ),
                onChanged: (value) async {
                  setState(() {
                    _value = value;
                  });
                  if (value != "Country") {
                    analysisProvider.selectSingle(name: value);
                  }
                },
                isDense: true,
                items: widget.myDropDownAnal.isNotEmpty
                    ? widget.myDropDownAnal.map((e) {
                        return DropdownMenuItem(
                          child: SizedBox(
                            width: deviceSize(context).width * 0.8,
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
          );
        },
      ),
    );
  }
}
