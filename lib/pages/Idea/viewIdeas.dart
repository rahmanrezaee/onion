import 'package:flutter/material.dart';
import 'package:onion/const/color.dart';
import 'package:onion/models/Idea.dart';
import 'package:onion/utilities/linkChecker.dart';
import 'package:onion/widgets/AnalysisWidget/MyAlert.dart';
import 'package:onion/widgets/FiveRating.dart';
import 'package:video_player/video_player.dart';

class ViewIdeas extends StatefulWidget {
  static String routeName = "ViewIdeas";

  @override
  _ViewIdeasState createState() => _ViewIdeasState();
}

class _ViewIdeasState extends State<ViewIdeas> {
  VideoPlayerController _controller;
  bool _isPlaying = false;
  initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'http://www.sample-videos.com/video/mp4/720/big_buck_bunny_720p_20mb.mp4',
    )
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SetupIdeaModel idea = ModalRoute.of(context).settings.arguments;
    print("this is documents: ${idea.documents}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: middlePurple,
        title: Text("View Ideas"),
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
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 20),
            Text(
              "New Idea: Needs Investor & Service",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Industry: ${idea.category}",
                        style: TextStyle(
                          color: middlePurple,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("Headline: ${idea.ideaHeadline}",
                          style: TextStyle(color: Colors.black)),
                      SizedBox(height: 10),
                      Text("Idea Description:"),
                      Text("${idea.ideaText}"),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Post: 28-08-2020",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(5)),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset("assets/images/new.png"),
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 36),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Timelines: ',
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                    text: ' Total Stages ${idea.timeline['details'].length}',
                    style: TextStyle(color: deepGrey, fontSize: 30),
                  )
                ],
              ),
              textScaleFactor: 0.5,
            ),
            SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(children: [
                Container(
                  color: firstPurple,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Stage Name",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Starting Date",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "End Date",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                ...(idea.timeline['details'] as List).map((e) {
                  int index = (idea.timeline['details'] as List).indexOf(e);
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text("Stage ${index + 1}",
                              textAlign: TextAlign.center),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text("${e['start']}",
                              textAlign: TextAlign.center),
                        ),
                        Expanded(
                          flex: 2,
                          child:
                              Text("${e['end']}", textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ]),
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 15),
            Text("Project Images",
                style: TextStyle(fontSize: 16, color: Colors.black)),
            Container(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ...List.generate(
                    idea.documents.length,
                    (index) {
                      return isUriImage(idea.documents[index]["uriPath"])
                          ? Row(
                              children: [
                                SizedBox(
                                  width: 85,
                                  height: 80,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                        idea.documents[index]["uriPath"]),
                                  ),
                                ),
                                SizedBox(width: 10),
                              ],
                            )
                          : Container();
                    },
                  ).toList(),
                ],
              ),
            ),
            SizedBox(height: 15),
            Text("Project Descriptive Video"),
            SizedBox(height: 10),
            _controller.value.initialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    color: Colors.grey,
                  ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total No. of People: "),
                Text("8 People"),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyFiveRating(rateVal: 4.3),
                Text(
                  "Review Now",
                  style: TextStyle(
                    color: middlePurple,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: OutlineButton(
                borderSide: BorderSide(width: 2, color: Colors.grey),
                onPressed: () {},
                child: Text("Show Interest"),
              ),
            ),
            // SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: OutlineButton(
                borderSide: BorderSide(width: 2, color: Colors.grey),
                onPressed: () {},
                child: Text("Share in Investment"),
              ),
            ),
            // SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                color: middlePurple,
                onPressed: () {},
                child: Text(
                  "Bid For The Idea",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // RaisedButton(
            //   shape: RoundedRectangleBorder(
            //     border
            //     borderRadius: BorderRadius.all(Radius.circular(5)),
            //   ),
            //   onPressed: (){},
            //   child: Text("Show Interest"),
            // ),
          ]),
        ),
      ),
    );
  }
}
