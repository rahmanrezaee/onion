import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/const/color.dart';
import 'package:onion/statemanagment/dropDownItem/CategoryProvider.dart';
import 'package:onion/widgets/AnalysisWidget/MySmallDropdown.dart';
import 'package:provider/provider.dart';

Future<void> showMyDialog({@required BuildContext context}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.only(
          bottom: deviceSize(context).height * 0.03,
        ),
        titlePadding: EdgeInsets.zero,
        content: SingleChildScrollView(
          child: Consumer<CategoryProvider>(
            builder: (BuildContext context, value, Widget child) {
              return ListBody(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        color: middlePurple,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: deviceSize(context).height * 0.02,
                      right: deviceSize(context).width * 0.03,
                      left: deviceSize(context).width * 0.03,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Let us know what all analytics you are intrested in?',
                          textScaleFactor: 1,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: deviceSize(context).height * 0.03),
                        MySmallDropdown(
                          iconColor: Colors.black,
                          myisExpanded: true,
                          myDropDownList: value.items,
                          dropDownAroundColor: Colors.grey,
                          txtColor: Colors.grey,
                          dropDownColor: Colors.white,
                        ),
                        SizedBox(height: deviceSize(context).height * 0.01),
                        MySmallDropdown(
                          iconColor: Colors.black,
                          myisExpanded: true,
                          myDropDownList: value.items,
                          dropDownAroundColor: Colors.grey,
                          txtColor: Colors.grey,
                          dropDownColor: Colors.white,
                        ),
                        SizedBox(height: deviceSize(context).height * 0.01),
                        MySmallDropdown(
                          iconColor: Colors.black,
                          myisExpanded: true,
                          myDropDownList: value.items,
                          dropDownAroundColor: Colors.grey,
                          txtColor: Colors.grey,
                          dropDownColor: Colors.white,
                        ),
                        SizedBox(height: deviceSize(context).height * 0.01),
                        MySmallDropdown(
                          iconColor: Colors.black,
                          myisExpanded: true,
                          myDropDownList: value.items,
                          dropDownAroundColor: Colors.grey,
                          txtColor: Colors.grey,
                          dropDownColor: Colors.white,
                        ),
                        SizedBox(height: deviceSize(context).height * 0.01),
                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            color: middlePurple,
                            textColor: Colors.white,
                            elevation: 0,
                            child: Text("Save"),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: middlePurple),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            color: Colors.white,
                            elevation: 0,
                            textColor: middlePurple,
                            child: Text("Manage Analytics"),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: middlePurple),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        // actions: <Widget>[
        //   TextButton(
        //     child: Text('Approve'),
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //   ),
        // ],
      );
    },
  );
}
