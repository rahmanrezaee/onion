import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../const/Size.dart';
import '../../const/color.dart';
import '../../const/values.dart';

class MyChatItems extends StatelessWidget {
  final bool isMe;
  final String message;
  final String date;
  final String hour;

  const MyChatItems({
    Key key,
    @required this.isMe,
    this.message,
    this.date,
    this.hour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isMe ? TextDirection.rtl : TextDirection.ltr,
      child: Column(
        children: [
          SizedBox(height: deviceSize(context).height * 0.04),
          date.isNotEmpty ? Text("$date") : SizedBox.shrink(),
          date.isNotEmpty
              ? SizedBox(height: deviceSize(context).height * 0.02)
              : SizedBox.shrink(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: deviceSize(context).height * 0.08,
                width: deviceSize(context).height * 0.08,
                child: CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/images/empty_profile.jpg"),
                ),
              ),
              SizedBox(width: deviceSize(context).width * 0.02),
              Container(
                decoration: BoxDecoration(
                  color: isMe ? greyBlue : grey,
                  borderRadius: BorderRadius.only(
                    topRight: isMe ? Radius.circular(0) : Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    topLeft: !isMe ? Radius.circular(0) : Radius.circular(15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: deviceSize(context).width * 0.03,
                        right: deviceSize(context).width * 0.03,
                        top: deviceSize(context).height * 0.03,
                        bottom: deviceSize(context).width * 0.02,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: deviceSize(context).height * 0.01,
                          maxHeight: deviceSize(context).height,
                          minWidth: deviceSize(context).width * 0.02,
                          maxWidth: deviceSize(context).width * 0.7,
                        ),
                        child: AutoSizeText(
                          message == null ? loremIpsum : message,
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.1,
                          maxLines: 10,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: deviceSize(context).width * 0.01,
                        right: deviceSize(context).width * 0.02,
                        bottom: deviceSize(context).width * 0.02,
                      ),
                      child: Text(
                        "$hour",
                        textAlign: TextAlign.end,
                        textDirection: TextDirection.ltr,
                        textScaleFactor: 0.9,
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
