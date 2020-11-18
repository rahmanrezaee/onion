import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onion/widgets/MRaiseButton.dart';
import 'package:onion/widgets/MyAppBar.dart';

import './NotificationsList.dart';
import '../const/color.dart';
import '../const/Size.dart';
import '../widgets/MyLittleAppbar.dart';

class MyMessagePage extends StatefulWidget {
  static const routeName = "my_message";
  Function openDrawer;

  MyMessagePage({Key key, this.openDrawer});

  @override
  _MyMessagePageState createState() => _MyMessagePageState();
}

class _MyMessagePageState extends State<MyMessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "My Message", openDrawer: widget.openDrawer),
      body: Column(
        children: [
          MyTextFieldMessage(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: deviceSize(context).width * 0.03,
                vertical: deviceSize(context).height * 0.01,
              ),
              children: [
                MyCardItem(myImageType: "circle", clickType: "message"),
                MyCardItem(myImageType: "circle", clickType: "message"),
                MyCardItem(myImageType: "circle", clickType: "message"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyTextFieldMessage extends StatefulWidget {
  @override
  _MyTextFieldMessageState createState() => _MyTextFieldMessageState();
}

class _MyTextFieldMessageState extends State<MyTextFieldMessage> {
  DateTime selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: middlePurple,
            accentColor: middlePurple,
            colorScheme: ColorScheme.light(primary: middlePurple),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
        // builder: (BuildContext context, Widget child) {
        //   return Theme(
        //     data: ThemeData.dark().copyWith(
        //       colorScheme: ColorScheme.dark(
        //         onPrimary: Colors.white,
        //         surface: middlePurple,
        //         onSurface: Colors.black,
        //         background: Colors.black,
        //         onSecondary: Colors.black,
        //       ),
        //       dialogBackgroundColor: Colors.white,
        //     ),
        //     child: child,
        //   );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  void submitForm() {
    print("Clicked");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: deviceSize(context).height * 0.02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: deviceSize(context).width * 0.5,
            height: deviceSize(context).height * 0.06,
            child: TextFormField(
              onFieldSubmitted: (_) => submitForm,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: grey),
                ),
                contentPadding: EdgeInsets.only(
                  top: deviceSize(context).height * 0.01,
                  left: deviceSize(context).width * 0.02,
                ),
                fillColor: grey,
                hintText: "Search Users |",
                filled: true,
              ),
            ),
          ),
          MRaiseButton(
            mFunc: _selectDate,
            mTxtBtn: selectedDate == null
                ? "Choose Date"
                : DateFormat("yyy-M-dd").format(selectedDate),
            isIcon: true,
            mWidth: deviceSize(context).width * 0.4,
            mHeight: deviceSize(context).height * 0.06,
          ),
        ],
      ),
    );
  }
}
