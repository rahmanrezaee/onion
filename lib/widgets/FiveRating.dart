import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../const/Size.dart';
import '../const/color.dart';

class MyFiveRating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Rating Bar");
    // return RatingBar(
    //   initialRating: 4.5,
    //   minRating: 1,
    //   itemSize: deviceSize(context).width * 0.05,
    //   direction: Axis.horizontal,
    //   allowHalfRating: true,
    //   itemCount: 5,
    //   itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
    //   // itemBuilder: (context, _) => Icon(
    //   //   Icons.star,
    //   //   color: middlePurple,
    //   // ),
    //   onRatingUpdate: (rating) {
    //     print(rating);
    //   },
    //   ratingWidget: RatingWidget(
    //     full: Icon(
    //       Icons.star,
    //       color: middlePurple,
    //     ),
    //     half: null,
    //     empty: null,
    //   ),
    // );
  }
}
