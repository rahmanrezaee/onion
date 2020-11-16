import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/widgets/MRaiseButton.dart';

class ProfileWidget extends StatelessWidget {
  _functionBtn() {
    print("Mahdi");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: deviceSize(context).height * 0.1,
          width: deviceSize(context).height * 0.1,
          child: CircleAvatar(
            backgroundImage: AssetImage(
              'assets/images/empty_profile.jpg',
            ),
          ),
        ),
        SizedBox(width: deviceSize(context).width * 0.02),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "James Camron",
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: deviceSize(context).height * 0.02),
            Text(
              "Industry",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        Spacer(),
        Column(
          children: [
            MRaiseButton(
              isIcon: false,
              mFunc: _functionBtn,
              mTxtBtn: "View Profile",
              mWidth: deviceSize(context).width * 0.28,
              mHeight: deviceSize(context).height * 0.05,
            ),
            SizedBox(height: deviceSize(context).height * 0.007),
            SizedBox(
              width: deviceSize(context).width * 0.28,
              height: deviceSize(context).height * 0.05,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.8),
                  ),
                ),
                color: Colors.white,
                elevation: 0,
                textColor: Colors.grey,
                child: Text("Message"),
                onPressed: () {},
              ),
            )
          ],
        ),
      ],
    );
  }
}
