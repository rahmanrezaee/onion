import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/widgets/MRaiseButton.dart';

class UploadBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: deviceSize(context).width * 0.6,
          height: deviceSize(context).height * 0.06,
          child: TextField(
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
        ),
        SizedBox(width: deviceSize(context).width * 0.01),
        MRaiseButton(
          isIcon: false,
          mTxtBtn: "Upload",
          mFunc: _uploadFunc,
          mWidth: deviceSize(context).width * 0.3,
          mHeight: deviceSize(context).height * 0.06,
        ),
      ],
    );
  }

  _uploadFunc() {}
}
