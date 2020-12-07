import 'package:flutter/material.dart';
import 'package:onion/statemanagment/RatingProvider.dart';
import 'package:onion/widgets/rating/dialogRating.dart';
import 'package:provider/provider.dart';

class RatingPage extends StatefulWidget {
  static final routeName = "/ratingPage";
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  @override
  Widget build(context) {
    var ratingProvider = Provider.of<RatingProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Rounded Alert Box"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () => showDialog(
              context: context,
              builder: (context) {
                return DialogRating(
                    initialRating: 2,
                    review: "",
                    submit: (rate, review) {
                      ratingProvider.addRating(ownerId: "2131asdqw", type: "investory", typeId: "32eqwsda", text: review, value: rate);
                    });
              }),
          child: Text(
            "Open Alert Box",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
