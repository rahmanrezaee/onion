import 'dart:math';

import 'package:flutter/material.dart';
import 'package:onion/const/color.dart';
import 'package:onion/services/SimpleHttp.dart';
import 'package:shimmer/shimmer.dart';

//This is term and conditions Dialog
//it opens when click in the term and condition menu in the drawer
class TandCDialog extends StatelessWidget {
  TandCDialog({
    Key key,
  }) : super(key: key);

  ScrollController _controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          //Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: middlePurple,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4), topLeft: Radius.circular(4)),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(flex: 1, child: Text("")),
                    Expanded(
                      flex: 4,
                      child: Text(
                        "Terms & Conditions",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ]),
            ),
          ),
          //Content(Body)
          FutureBuilder(
            future: SimpleHttp().getTandC(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var content = snapshot.data["body"];
                return Expanded(
                  child: Scrollbar(
                    isAlwaysShown: true,
                    radius: Radius.circular(4),
                    controller: _controller,
                    child: ListView(controller: _controller, children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(content),
                      ),
                    ]),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text(
                    "Something went wrong will getting Terms and Conditions!! Please try again later.");
              } else {
                //Loading Shimmers
                return Expanded(
                    child: Shimmer.fromColors(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(children: [
                      ...List.generate(
                          100,
                          (index) => Column(
                                children: [
                                  Container(
                                    width: double.infinity -
                                        Random().nextInt(50 - 0),
                                    height: 5,
                                    color: Color(0xFFd8d8d8),
                                  ),
                                  SizedBox(height: 5),
                                ],
                              )),
                    ]),
                  ),
                  baseColor: Color(0xFFd8d8d8),
                  highlightColor: Colors.white,
                ));
              }
            },
          ),
          //Footer(OK Button)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                elevation: 0,
                child: Text("OK", style: TextStyle(color: Colors.white)),
                color: middlePurple,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
