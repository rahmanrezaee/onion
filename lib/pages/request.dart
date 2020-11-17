import 'package:flutter/material.dart';
import 'package:onion/const/color.dart';
import 'package:onion/widgets/AnalysisWidget/MyAlert.dart';
import 'package:onion/widgets/FiveRating.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
import 'CustomDrawerPage.dart';

class RequestPage extends StatelessWidget {
  static const routeName = "request";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: middlePurple,
        title: Text("Request"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed(CustomDrawerPage.routeName);
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
                            Text("Intersted in: "),
                            Icon(Icons.radio_button_checked,
                                color: middlePurple),
                            Text(" Shares"),
                          ]),
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
                          Divider(),
                          Container(
                            width: double.infinity,
                            child: Wrap(
                              spacing: 5,
                              runSpacing: 5,
                              children: [
                                Text("Contracts"),
                                SizedBox(width: 10),
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              color: middlePurple,
                              child: Text(
                                "Pending",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {},
                            ),
                          )
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
