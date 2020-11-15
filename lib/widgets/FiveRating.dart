import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../const/Size.dart';
import '../const/color.dart';

class MyFiveRating extends StatelessWidget {
  final double rateVal;

  const MyFiveRating({Key key, this.rateVal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      initialRating: rateVal,
      minRating: 1,
      itemSize: deviceSize(context).width * 0.05,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
      //If itemBuilder gets error check this issue: https://github.com/sarbagyastha/flutter_rating_bar/issues/44
      // itemBuilder: (context, _) => Icon(
      //   Icons.star,
      //   color: middlePurple,
      // ),
      onRatingUpdate: (rating) {
        print(rating);
      },
      ratingWidget: RatingWidget(
        full: Icon(
          Icons.star,
          color: middlePurple,
        ),
        empty: Icon(
          Icons.star_border,
          color: middlePurple,
        ),
        half: Icon(
          Icons.star_half,
          color: middlePurple,
        ),
      ),
    );
  }
}
