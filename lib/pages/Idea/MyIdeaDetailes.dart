import 'package:flutter/material.dart';
import 'package:onion/const/color.dart';
import 'package:onion/pages/CustomDrawerPage.dart';
import 'package:onion/pages/Idea/MyIdeaId.dart';
import 'package:onion/services/ideasServices.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/widgets/IdeaWiget/popupMenu.dart' as mypopup;
import 'package:onion/widgets/AnalysisWidget/MyAlert.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import '../../models/Idea.dart';
//
import 'package:video_player/video_player.dart';

class MyIdeaDetails extends StatefulWidget {
  static String routeName = "MyIdeaDetail";

  @override
  _MyIdeaDetailsState createState() => _MyIdeaDetailsState();
}

class _MyIdeaDetailsState extends State<MyIdeaDetails> {
  VideoPlayerController _controller;
  //Video player controller
  final double playerWidth = 640.0;
  final double playerHeight = 360.0;
  bool _isPlaying = false;
  String token;
  initState() {
    token = Provider.of<Auth>(context).token;
    //Video player initialize
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      // closedCaptionFile: _loadCaptions(),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SetupIdeaModel idea = ModalRoute.of(context).settings.arguments;
    print("his is the document: ${idea.documents}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: middlePurple,
        title: Text("My Idea Details"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(MyIdeaId.routeName);
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
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Posted On",
                                style: TextStyle(color: deepGrey)),
                            // InkWell(
                            //   onTap: () {},
                            //   child: Icon(Icons.more_vert, color: deepGrey),
                            // ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  mypopup.PopupMenuButton<int>(
                                    elevation: 20,
                                    padding: EdgeInsets.all(10),
                                    onSelected: (value) {},
                                    offset: Offset(50, 50),
                                    itemBuilder: (context) => [
                                      mypopup.PopupMenuItem(
                                        value: 1,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            // border:
                                            //     Border.all(color: Colors.grey[200], width: 2),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text("Edit",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      mypopup.PopupMenuItem(
                                        value: 2,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                            // color: ,
                                            border: Border.all(
                                                color: Colors.grey[200],
                                                width: 2),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text("View Bids"),
                                            ],
                                          ),
                                        ),
                                      ),
                                      mypopup.PopupMenuItem(
                                        value: 2,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          decoration: BoxDecoration(
                                            // color: ,
                                            border: Border.all(
                                                color: Colors.grey[200],
                                                width: 2),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                  "View Interseted Investment"),
                                            ],
                                          ),
                                        ),
                                      ),
                                      mypopup.PopupMenuItem(
                                        value: 2,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                            // color: ,
                                            border: Border.all(
                                                color: Colors.grey[200],
                                                width: 2),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text("Find Investor"),
                                            ],
                                          ),
                                        ),
                                      ),
                                      mypopup.PopupMenuItem(
                                        value: 2,
                                        onClick: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                    title:
                                                        Text("Are you sure?"),
                                                    actions: [
                                                      FlatButton(
                                                        child: Text("Yes"),
                                                        onPressed: () {
                                                          IdeasServices()
                                                              .deleteIdea(
                                                            idea.id,
                                                            token,
                                                          );
                                                        },
                                                      ),
                                                      FlatButton(
                                                        child: Text("Cancel"),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ]);
                                              });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          decoration: BoxDecoration(
                                            // color: ,
                                            border: Border.all(
                                                color: Colors.grey[200],
                                                width: 2),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text("Delete"),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Text(
                                  //   "Post On",
                                  //   style: TextStyle(
                                  //     color: Colors.grey,
                                  //     fontSize: 12,
                                  //   ),
                                  // )
                                ],
                              ),
                            )
                          ],
                        ),
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
                          SizedBox(
                            width: double.infinity,
                            height: 120,
                            child: GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   _videoController.pause();
                                //   _isPlaying = false;
                                //   print("ALi Azad");
                                // });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                // child: new VlcPlayer(
                                //   options: [],
                                //   aspectRatio: 16 / 9,
                                //   url: urlToStreamVideo,
                                //   controller: _videoController,
                                //   placeholder: Center(
                                //       child: CircularProgressIndicator()),
                                // ),
                                child: AspectRatio(
                                  aspectRatio: _controller.value.aspectRatio,
                                  child: VideoPlayer(_controller),
                                ),
                              ),
                            ),
                          ),
                          _isPlaying != false
                              ? Container()
                              : Positioned(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.play_circle_outline,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        // _videoController.play();
                                        _isPlaying = true;
                                      });
                                    },
                                  ),
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
