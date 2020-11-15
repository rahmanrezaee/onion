import 'dart:ui';

import 'package:flutter/material.dart';

import '../../const/Size.dart';
import '../../const/color.dart';
import '../../const/values.dart';
import '../../widgets/FiveRating.dart';
import '../../widgets/MRaiseButton.dart';
import '../../widgets/MyInvesting/AgreementTxt.dart';
import '../../widgets/MyInvesting/MyInvestAs.dart';
import '../../widgets/MyInvesting/MyListImage.dart';
import '../../widgets/MyInvesting/ProfileWidget.dart';
import '../../widgets/MyInvesting/UploadBtn.dart';
import '../../widgets/MyLittleAppbar.dart';

class SendInvRequest extends StatefulWidget {
  static const routeName = "send_inv_request";

  @override
  _SendInvRequestState createState() => _SendInvRequestState();
}

class _SendInvRequestState extends State<SendInvRequest> {
  int selectedRadio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: MyLittleAppbar(myTitle: "Send Investing Request"),
      ),
      body: SingleChildScrollView(
        child: Card(
          margin: EdgeInsets.symmetric(
            vertical: deviceSize(context).height * 0.02,
            horizontal: deviceSize(context).width * 0.02,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: deviceSize(context).height * 0.02,
              horizontal: deviceSize(context).width * 0.02,
            ),
            child: Column(
              children: [
                ProfileWidget(),
                SizedBox(height: deviceSize(context).height * 0.01),
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: selectedRadio,
                      activeColor: middlePurple,
                      onChanged: (val) {
                        setState(() {
                          selectedRadio = val;
                        });
                      },
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color:
                                selectedRadio == 1 ? middlePurple : Colors.grey,
                            style: BorderStyle.solid,
                            width: 1.5,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isDense: true,
                            isExpanded: true,
                            items: <String>['A', 'B', 'C', 'D']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: selectedRadio,
                      activeColor: middlePurple,
                      onChanged: (val) {
                        setState(() {
                          selectedRadio = val;
                        });
                      },
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color:
                                selectedRadio == 2 ? middlePurple : Colors.grey,
                            style: BorderStyle.solid,
                            width: 1.5,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isDense: true,
                            isExpanded: true,
                            items: <String>['A', 'B', 'C', 'D']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: deviceSize(context).width * 0.1,
                    maxWidth: deviceSize(context).width * 0.9,
                    minHeight: deviceSize(context).height * 0.01,
                    maxHeight: deviceSize(context).height,
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: "About Business: ",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        height: 1.3,
                      ),
                      children: [
                        TextSpan(
                          text: lormIpsum,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            height: 1.3,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(height: deviceSize(context).height * 0.05),
                Row(
                  children: [
                    Text(
                      "Rated: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    MyFiveRating(rateVal: 4.5),
                  ],
                ),
                Divider(height: deviceSize(context).height * 0.05),
                MyInvestAs(),
                SizedBox(height: deviceSize(context).height * 0.01),
                TextField(
                  maxLines: 6,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(5.0),
                      ),
                    ),
                    contentPadding: EdgeInsets.all(
                      deviceSize(context).height * 0.01,
                    ),
                    hintText: "Message",
                  ),
                ),
                SizedBox(height: deviceSize(context).height * 0.01),
                UploadBtn(),
                SizedBox(height: deviceSize(context).height * 0.02),
                ListImage(),
                AgreementTxt(),
                MRaiseButton(
                  isIcon: false,
                  mWidth: double.infinity,
                  mHeight: deviceSize(context).height * 0.05,
                  mFunc: _sendFunc,
                  mTxtBtn: "Send",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _sendFunc() {}
}
