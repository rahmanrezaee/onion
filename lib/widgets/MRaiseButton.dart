import 'package:flutter/material.dart';
import 'package:onion/const/color.dart';

class MRaiseButton extends StatefulWidget {
  final Function mFunc;
  final String mTxtBtn;
  final double mHeight;
  final double mWidth;
  final bool isIcon;

  const MRaiseButton({
    Key key,
    this.mFunc,
    this.mTxtBtn,
    this.mHeight,
    this.mWidth,
    this.isIcon,
  }) : super(key: key);

  @override
  _MRaiseButtonState createState() => _MRaiseButtonState();
}

class _MRaiseButtonState extends State<MRaiseButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.mFunc(context),
// onTap: () {
//   print("Mahdi");
// },
      child: Container(
        width: widget.mWidth,
        height: widget.mHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[firstPurple, thirdPurple],
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: widget.isIcon
              ? MainAxisAlignment.spaceEvenly
              : MainAxisAlignment.center,
          children: [
            Text(
              widget.mTxtBtn,
              style: TextStyle(color: Colors.white.withOpacity(0.7)),
            ),
            widget.isIcon
                ? Icon(
                    Icons.date_range,
                    color: Colors.white.withOpacity(0.7),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
