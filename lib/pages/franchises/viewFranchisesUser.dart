import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onion/const/color.dart';
import 'package:onion/models/FranchiesModel.dart';
import 'package:onion/pages/CustomDrawerPage.dart';
import 'package:onion/widgets/AnalysisWidget/MyAlert.dart';
import 'package:onion/widgets/PlayWidget/BasicVideoPlayer.dart';
import 'package:onion/widgets/PlayWidget/VideoPlayer.dart';
import 'package:video_player/video_player.dart';

class ViewFranchisesUser extends StatefulWidget {
  static String routeName = "ViewFranchisesUser";
  FranchiesModel franchiesModel;
  ViewFranchisesUser(this.franchiesModel);

  @override
  _ViewFranchisesUserState createState() => _ViewFranchisesUserState();
}

class _ViewFranchisesUserState extends State<ViewFranchisesUser> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
        widget.franchiesModel.uploadVideo[0]["uriPath"]);
    //_controller = VideoPlayerController.asset("videos/sample_video.mp4");
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: middlePurple,
        title: Text("Franchise Name"),
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
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Franchise: <Franchise Name>",
                    style: TextStyle(color: firstPurple, fontSize: 18),
                  ),
                  InkWell(
                    onTap: () {},
                    child:
                        Icon(Icons.info_outline, size: 30, color: firstPurple),
                  ),
                ],
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 8.0,
                    right: 8.0,
                    bottom: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Industry: ", style: TextStyle(fontSize: 15)),
                          Text(
                            "<${widget.franchiesModel.industry}>",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Brand",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black87)),
                            Text("${widget.franchiesModel.brandName}",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black87)),
                          ]),
                      Divider(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Location",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black87)),
                            Text("${widget.franchiesModel.location.toString()}",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black87)),
                          ]),
                      Divider(),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: deepGrey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            color: Colors.transparent,
                            child: Text("Message",
                                style: TextStyle(color: deepGrey)),
                            onPressed: () {},
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            color: middlePurple,
                            child: Text(
                              "View Profile",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Requirement Details:",
                        style: TextStyle(fontSize: 22, color: deepBlue),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${widget.franchiesModel.requirments}",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Upload Documents",
                        style: TextStyle(fontSize: 22, color: deepBlue),
                      ),
                      SizedBox(height: 5),
                      Container(
                        height: 80,
                        child: ListView.builder(
                          itemCount:
                              widget.franchiesModel.uploadDocuments.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Container(
                                  height: 50,
                                  width: 50,
                                  child: widget.franchiesModel.uploadDocuments[index]
                                                  ["type"] ==
                                              "jpg" ||
                                          widget.franchiesModel.uploadDocuments[index]
                                                  ["type"] ==
                                              "jpeg" ||
                                          widget.franchiesModel
                                                      .uploadDocuments[index]
                                                  ["type"] ==
                                              "png"
                                      ? Image.file(File(widget.franchiesModel
                                          .uploadDocuments[index]['path']))
                                      : Icon(Icons.file_present)),
                            );
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 150,
                        child: FutureBuilder(
                          future: _initializeVideoPlayerFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    child: VideoPlayer(_controller),
                                    onTap: _onTapVideo,
                                  ),
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: _controlAlpha > 0
                                          ? AnimatedOpacity(
                                              opacity: _controlAlpha,
                                              duration:  Duration(milliseconds: 250),
                                              child: _controlView(context),
                                            )
                                          : Container(),
                                    ),
                                  ),
                                ],
                              );
                              // Center(
                              //   child: AspectRatio(
                              //     aspectRatio: _controller.value.aspectRatio,
                              //     child: VideoPlayer(_controller),
                              //   ),
                              // );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // ListView.builder(
                      //   itemBuilder: (BuildContext context, int index) {
                      //     return InkWell(
                      //       onTap: () {
                      //         print("Will show this documents");
                      //       },
                      //       child: Icon(Icons.upload_file,
                      //           size: 50, color: deepGrey),
                      //     );
                      //   },
                      // ),

                      //  Container(
                      //     height: 200,

                      //                           child: VideoPlayerWidget(clips: [
                      //       VideoClip(
                      //           "For Bigger Fun",
                      //           "ForBiggerFun.mp4",
                      //           "images/ForBiggerFun.jpg",
                      //           0,
                      //           "https://webfume-onionai.s3.amazonaws.com/guest/public/video/605992-VID_1591354981174.mp4"),
                      //     ]),
                      //   ),

                      SizedBox(height: 20),
                      Text(
                        "Upload Video",
                        style: TextStyle(fontSize: 22, color: deepBlue),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          color: lightGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.slow_motion_video,
                            size: 80, color: deepBlue),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: RaisedButton(
                            color: middlePurple,
                            onPressed: () {},
                            child: Text("Request",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _controlView(context) {
    return IconButton(
      onPressed: () {
        setState(() {
          if (_controller.value.isPlaying) {
            _controller.pause();
          } else {
            _controller.play();
          }
        });
      },
      icon: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          size: 80, color: deepBlue),
    );
  }

  Timer _timerVisibleControl;
  double _controlAlpha = 1.0;

  var _playing = false;
  bool get _isPlaying {
    return _playing;
  }

  void _onTapVideo() {
    debugPrint("_onTapVideo $_controlAlpha");
    setState(() {
      _controlAlpha = _controlAlpha > 0 ? 0 : 1;
    });
    _timerVisibleControl?.cancel();
    _timerVisibleControl = Timer(Duration(seconds: 2), () {
      if (_isPlaying) {
        setState(() {
          _controlAlpha = 0.0;
        });
      }
    });
  }
}
