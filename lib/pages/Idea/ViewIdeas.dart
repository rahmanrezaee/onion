import 'dart:math';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/const/color.dart';
import 'package:onion/const/values.dart';
import 'package:onion/widgets/MyLittleAppbar.dart';

class BadgeDecoration extends Decoration {
  final Color badgeColor;
  final double badgeSize;
  final TextSpan textSpan;

  const BadgeDecoration({
    @required this.badgeColor,
    @required this.badgeSize,
    @required this.textSpan,
  });

  @override
  BoxPainter createBoxPainter([onChanged]) =>
      _BadgePainter(badgeColor, badgeSize, textSpan);
}

class _BadgePainter extends BoxPainter {
  static const double BASELINE_SHIFT = 1;
  static const double CORNER_RADIUS = 4;
  final Color badgeColor;
  final double badgeSize;
  final TextSpan textSpan;

  _BadgePainter(this.badgeColor, this.badgeSize, this.textSpan);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    canvas.save();
    canvas.translate(
        offset.dx + configuration.size.width - badgeSize, offset.dy);
    canvas.drawPath(buildBadgePath(), getBadgePaint());
    // draw text
    final hyp = sqrt(badgeSize * badgeSize + badgeSize * badgeSize);
    final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    textPainter.layout(minWidth: hyp, maxWidth: hyp);
    final halfHeight = textPainter.size.height / 2;
    final v = sqrt(halfHeight * halfHeight + halfHeight * halfHeight) +
        BASELINE_SHIFT;
    canvas.translate(v, -v);
    canvas.rotate(0.785398); // 45 degrees
    textPainter.paint(canvas, Offset.zero);
    canvas.restore();
  }

  Paint getBadgePaint() => Paint()
    ..isAntiAlias = true
    ..color = badgeColor;

  Path buildBadgePath() => Path.combine(
      PathOperation.difference,
      Path()
        ..addRRect(RRect.fromLTRBAndCorners(0, 0, badgeSize, badgeSize,
            topRight: Radius.circular(CORNER_RADIUS))),
      Path()
        ..lineTo(0, badgeSize)
        ..lineTo(badgeSize, badgeSize)
        ..close());
}

class ViewIdeas extends StatelessWidget {
  static const routeName = "view_ideas";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: MyLittleAppbar(
          hasDrawer: false,
          myTitle: "View Ideas",
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: deviceSize(context).height * 0.04,
          horizontal: deviceSize(context).width * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Idea: Needs Investor & Service",
              textScaleFactor: 1.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Industry: IT Tech Management",
                  textScaleFactor: 1.1,
                  style: TextStyle(color: firstPurple),
                ),
                Container(
                  height: deviceSize(context).height * 0.06,
                  width: deviceSize(context).height * 0.06,
                  foregroundDecoration: BadgeDecoration(
                    badgeColor: middlePurple,
                    badgeSize: deviceSize(context).height * 0.06,
                    textSpan: TextSpan(
                      text: 'New',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: deviceSize(context).height * 0.017,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "Headline: Tech Gadget Rentals",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: deviceSize(context).height * 0.01),
            Text(
              "Idea Description:",
              style: TextStyle(color: Colors.black),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: deviceSize(context).width * 0.38,
                maxWidth: deviceSize(context).width * 0.9,
                minHeight: deviceSize(context).height * 0.2,
                maxHeight: deviceSize(context).height * 0.5,
              ),
              child: AutoSizeText(
                loremIpsum,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: deviceSize(context).height * 0.02),
            SizedBox(
              width: deviceSize(context).width,
              child: Text(
                "Post: 28-08-2020",
                textAlign: TextAlign.end,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 50,
            ),
            Row(
              children: [
                Text(
                  "Timelines:   ",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  "Total Stages 2",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            Table(
              children: [],
            )
          ],
        ),
      ),
    );
  }
}
