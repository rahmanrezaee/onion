import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:onion/const/color.dart';
import 'package:onion/widgets/AnalysisWidget/MyAlert.dart';
import 'package:onion/widgets/Checkbox/GlowCheckbox.dart';
import 'package:onion/widgets/FiveRating.dart';
import 'package:onion/widgets/PlayWidget/VideoPlayer.dart';
import 'package:onion/widgets/T&C_widget.dart';
import 'package:video_player/video_player.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'CustomDrawerPage.dart';

class MyBiddedIdeaPage extends StatefulWidget {
  static const routeName = "MyBiddedIdea";

  @override
  _MyBiddedIdeaPageState createState() => _MyBiddedIdeaPageState();
}

class _MyBiddedIdeaPageState extends State<MyBiddedIdeaPage> {
  bool checkboxSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: middlePurple,
        title: Text("Bid On Idea"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            // Navigator.of(context)
            //     .pushReplacementNamed(CustomDrawerPage.routeName);
          },
        ),
        actions: [
          IconButton(
            icon: MyAlertIcon(num: 3),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("New Idea",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: deepBlue)),
              Card(
                elevation: 4,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Rated"),
                        SizedBox(width: 10),
                        MyFiveRating(rateVal: 5),
                        // Text("Posted On"),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 0.5, color: deepGrey),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Industry",
                                  style: TextStyle(color: deepGrey)),
                              Text("Lorem ipsum", style: TextStyle()),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Idea Headline",
                                  style: TextStyle(color: deepGrey)),
                              Text("Lorem Ipsum Dummy", style: TextStyle()),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Industry Interested",
                                  style: TextStyle(color: deepGrey)),
                              Text("Lorem ipsum", style: TextStyle()),
                            ],
                          ),
                          Divider(),
                          SizedBox(height: 5),
                          RichText(
                            text: TextSpan(
                              text: 'Idea: ',
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    style: TextStyle(
                                        color: deepGrey,
                                        fontWeight: FontWeight.normal),
                                    text:
                                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage("https://i.pravatar.cc/300"),
                                ),
                                SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("jamesh H. Matt",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text("industry",
                                        style: TextStyle(color: deepGrey)),
                                    Row(children: [
                                      Text("Rated: ",
                                          style: TextStyle(color: deepGrey)),
                                      MyFiveRating(rateVal: 4.5),
                                    ])
                                  ],
                                ),
                              ]),
                              Row(children: [
                                InkWell(
                                  child: Icon(Icons.info_outline,
                                      color: middlePurple),
                                  onTap: () {},
                                ),
                                InkWell(
                                  child: Icon(Icons.more_vert, color: deepGrey),
                                  onTap: () {},
                                ),
                              ])
                            ],
                          ),
                          Divider(),
                          Row(children: [
                            Text("Implemented in: "),
                            Icon(Icons.radio_button_checked,
                                color: middlePurple),
                            Text(" Shares"),
                          ]),
                          Divider(),
                          RichText(
                            text: TextSpan(
                              text:
                                  'What you think and how you want to be part of this idea: ',
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    style: TextStyle(
                                        color: deepGrey,
                                        fontWeight: FontWeight.normal),
                                    text:
                                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type"),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              "Projects Done",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: deepBlue,
                              ),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text:
                                  'Share your previews work which you want this innovator to look at: ',
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    style: TextStyle(
                                        color: deepGrey,
                                        fontWeight: FontWeight.normal),
                                    text:
                                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type"),
                              ],
                            ),
                          ),
                          Divider(),
                          Text("Documents"),
                          SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            child: Wrap(
                              spacing: 5,
                              runSpacing: 5,
                              children: [
                                Container(
                                  width: 50,
                                  child: Image.asset(
                                    "assets/images/contract.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  child: Image.asset(
                                    "assets/images/contract.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          VideoPlayerWidget(
                            clipsUrl:
                                "https://www.sample-videos.com/video123/mp4/240/big_buck_bunny_240p_30mb.mp4",
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Date", style: TextStyle(color: deepGrey)),
                              Row(children: [
                                Icon(Icons.location_on, color: middlePurple),
                                Text(
                                  "07-04-2020",
                                  // style: TextStyle(),
                                ),
                              ]),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("References",
                                  style: TextStyle(color: deepGrey)),
                              Text(
                                "Lorem ipsum dummy",
                                // style: TextStyle(),
                              ),
                            ],
                          ),
                          Divider(),
                          RichText(
                            text: TextSpan(
                              text: 'Message: ',
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    style: TextStyle(
                                        color: deepGrey,
                                        fontWeight: FontWeight.normal),
                                    text:
                                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type"),
                              ],
                            ),
                          ),
                          // Divider(),
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     GlowCheckbox(
                          //       color: Theme.of(context).primaryColor,
                          //       value: checkboxSelected,
                          //       enable: true,
                          //       onChange: (bool value) {
                          //         setState(() {
                          //           checkboxSelected = !checkboxSelected;
                          //         });
                          //       },
                          //     ),
                          //     SizedBox(
                          //       width: 10,
                          //     ),
                          // Expanded(
                          // child: Text(
                          //   "By Cheacking the box you agree to out terms and services",
                          // ),
                          // child: RichText(
                          //   text: TextSpan(
                          //     text: 'Agree to ',
                          //     style: TextStyle(color: Colors.black),
                          //     children: <TextSpan>[
                          //       TextSpan(
                          //         text: 'Term and Condition',
                          //         style: TextStyle(
                          //             color: middlePurple,
                          //             decoration:
                          //                 TextDecoration.underline),
                          //         recognizer: TapGestureRecognizer()
                          //           ..onTap = () {
                          //             showDialog(
                          //               context: context,
                          //               builder: (context) {
                          //                 return TandCDialog();
                          //               },
                          //             );
                          //           },
                          //       ),
                          //       TextSpan(
                          //           text:
                          //               ' and contract while Requesting this Franchise!'),
                          //     ],
                          //   ),
                          // ),
                          // )
                          // ],
                          // ),
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
