import 'package:flutter/material.dart';
import 'package:onion/const/color.dart';
import 'package:onion/widgets/IdeaWiget/popupMenu.dart' as mypopup;
import 'package:onion/widgets/AnalysisWidget/MyAlert.dart';
import 'package:provider/provider.dart';
import 'package:onion/widgets/PlayWidget/VideoPlayer.dart';
// import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import '../../models/Idea.dart';

class Bid extends StatefulWidget {
  static String routeName = "Bid";
  // Bid( ModalRoute.of(context).settings.arguments, arguments);

  @override
  _BidState createState() => _BidState();
}

class _BidState extends State<Bid> {
  // String token;
  initState() {
    super.initState();
    // token = Provider.of<Auth>(context).token;
  }

  @override
  Widget build(BuildContext context) {
    SetupIdeaModel idea = ModalRoute.of(context).settings.arguments;
    print("his is the document: ${idea.documents}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: middlePurple,
        title: Text("Bid"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
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
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Investor"),
                    Text("Posted On"),
                  ],
                ),
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("New Idea"),
                              Text("Need Service Proivder"),
                              Text("Need Inovator"),
                            ]),
                        Divider(),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Industry: ", style: TextStyle(fontSize: 15)),
                            Text(
                              "${idea.category}",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Headline: ", style: TextStyle(fontSize: 15)),
                            Text(
                              "${idea.ideaHeadline}",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        Divider(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                              text: 'Idea: ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "${idea.ideaText}",
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                )
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Documents",
                            style: TextStyle(color: deepBlue, fontSize: 14),
                          ),
                        ),
                        SizedBox(height: 10),
                        Wrap(
                            children:
                                List.generate(idea.documents.length, (index) {
                          return Icon(Icons.upload_file,
                              size: 50, color: deepGrey);
                        })),
                        Divider(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Video",
                            style: TextStyle(color: deepBlue, fontSize: 14),
                          ),
                        ),
                        SizedBox(height: 10),
                        Stack(alignment: Alignment.center, children: [
                          VideoPlayerWidget(
                            clipsUrl:
                                "https://www.sample-videos.com/video123/mp4/240/big_buck_bunny_240p_30mb.mp4",
                          ),
                        ]),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Target Audience ",
                                style: TextStyle(color: deepGrey)),
                            Row(children: [
                              Icon(Icons.location_on, color: middlePurple),
                              Text(
                                "${idea.location}",
                                // style: TextStyle(),
                              ),
                            ]),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("No of estimated people",
                                style: TextStyle(color: deepGrey)),
                            Text(
                              "${idea.estimatedPeople}",
                              // style: TextStyle(),
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: middlePurple,
                    child: Text("View White Paper",
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {},
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
