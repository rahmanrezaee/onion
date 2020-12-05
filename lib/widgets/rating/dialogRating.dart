import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DialogRating extends StatefulWidget {
  double initialRating = 1;
  String review = "";
  bool showReviewTexfield ;
  Function submit;

  DialogRating(
      {this.initialRating, this.showReviewTexfield = true, this.review, this.submit});

  @override
  _DialogRatingState createState() => _DialogRatingState();
}

class _DialogRatingState extends State<DialogRating> {
  TextEditingController reviewController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    reviewController.text = widget.review == null ? "" : widget.review;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.only(top: 10.0),
      // backgroundColor:  Colors.grey[200],
      content: Container(
        width: 300.0,
        // color: Colors.grey[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Rate",
                  style: TextStyle(fontSize: 24.0),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RatingBar.builder(
                    initialRating: widget.initialRating,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 25.0,
                    itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Theme.of(context).primaryColor,
                      size: 5,
                    ),
                    onRatingUpdate: (rating) => setState(() {
                      widget.initialRating = rating;
                    }),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Divider(
              color: Colors.grey,
              height: 4.0,
            ),
            Visibility(
              visible: widget.showReviewTexfield,
              child: Container(
                color: Colors.grey[200],
                child: Padding(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: TextFormField(
                    controller: this.reviewController,
                    decoration: InputDecoration(
                      hintText: "Add Review",
                      border: InputBorder.none,
                    ),
                    maxLines: 3,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                widget.submit(this.widget.initialRating, reviewController.text);
              },
              child: Container(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                      bottomRight: Radius.circular(32.0)),
                ),
                child: Text(
                  "Add Rating",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
