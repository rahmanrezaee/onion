import 'package:flutter/material.dart';
import 'package:onion/widgets/MRaiseButton.dart';

import './NotificationsList.dart';
import '../const/color.dart';
import '../const/Size.dart';
import '../widgets/MyLittleAppbar.dart';

class MyMessagePage extends StatelessWidget {
  static const routeName = "my_message";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: MyLittleAppbar(myTitle: "My Message"),
      ),
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
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
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
            mTxtBtn: "Choose Date",
            isIcon: true,
            mWidth: deviceSize(context).width * 0.4,
            mHeight: deviceSize(context).height * 0.06,
          ),
        ],
      ),
    );
  }
}
