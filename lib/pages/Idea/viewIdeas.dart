import 'package:flutter/material.dart';
import 'package:onion/const/color.dart';
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
  initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
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
                        "Industry: IT Tech Management",
                        style: TextStyle(
                          color: middlePurple,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("Headline: Tec Gadget Rentals",
                          style: TextStyle(color: Colors.black)),
                      SizedBox(height: 10),
                      Text("Idea Description:"),
                      Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book"),
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
                    text: ' Total Stages 2',
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
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text("Stage 1", textAlign: TextAlign.center),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text("25-08-2020", textAlign: TextAlign.center),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text("25-08-2021", textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text("Stage 2", textAlign: TextAlign.center),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text("25-08-2020", textAlign: TextAlign.center),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text("25-08-2021", textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text("Stage 2", textAlign: TextAlign.center),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text("25-08-2020", textAlign: TextAlign.center),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text("25-08-2021", textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
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
                    5,
                    (index) => Row(
                      children: [
                        SizedBox(
                          width: 85,
                          height: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset("assets/images/mobile.jpg"),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
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
