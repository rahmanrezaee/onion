import 'package:flutter/material.dart';

class CardRating extends StatefulWidget {
  @override
  _CardRatingState createState() => _CardRatingState();
}

class _CardRatingState extends State<CardRating> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Container(
        // padding: ,
        child: Row(
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: CircleAvatar(
                backgroundImage:
                    AssetImage('assets/images/empty_profile.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
