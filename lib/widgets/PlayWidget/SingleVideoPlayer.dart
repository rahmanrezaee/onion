import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onion/const/color.dart';
import 'package:video_player/video_player.dart';

class SingleVideoPlayer extends StatefulWidget {
  SingleVideoPlayer({Key key, @required this.clipsUrl}) : super(key: key);

  final String clipsUrl;
  @override
  _SingleVideoPlayerState createState() => _SingleVideoPlayerState();
}

class _SingleVideoPlayerState extends State<SingleVideoPlayer> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.clipsUrl);
    //_controller = VideoPlayerController.asset("videos/sample_video.mp4");
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);

    _duration = null;
    _position = null;
    _controller.addListener(_onControllerUpdated);
    _controller.play();
    setState(() {});
    super.initState();
  }

  void _onControllerUpdated() async {
    // blocking too many updation
    // important !!
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_updateProgressInterval > now) {
      return;
    }
    _updateProgressInterval = now + 500.0;

    final controller = _controller;
    if (controller == null) return;
    if (!controller.value.initialized) return;
    if (_duration == null) {
      _duration = _controller.value.duration;
    }
    var duration = _duration;
    if (duration == null) return;

    var position = await controller.position;
    _position = position;
    final playing = controller.value.isPlaying;
    final isEndOfClip = position.inMilliseconds > 0 &&
        position.inSeconds + 1 >= duration.inSeconds;
    if (playing) {
      // handle progress indicator

      setState(() {
        _progress = position.inMilliseconds.ceilToDouble() /
            duration.inMilliseconds.ceilToDouble();
      });
    }

    // handle clip end
    if (_isPlaying != playing) {
      _isPlaying = playing;
      debugPrint(
          "updated -----> isPlaying=$playing / isEndOfClip=$isEndOfClip");
      if (isEndOfClip && !playing) {
        debugPrint(
            "========================== End of Clip / Handle NEXT ========================== ");
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(children: <Widget>[
              GestureDetector(
                child: VideoPlayer(_controller),
                onTap: _onTapVideo,
              ),
              _controlAlpha > 0
                  ? AnimatedOpacity(
                      opacity: _controlAlpha,
                      duration: Duration(milliseconds: 250),
                      child: _controlView(context),
                    )
                  : Container(),
            ]);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  var _progress = 0.0;
  bool _isPlaying = true;
  var _updateProgressInterval = 0.0;
  Duration _duration;
  Duration _position;

  void _initializeAndPlay(url) async {
    print("_initializeAndPlay ---------> $url");

    final controller = VideoPlayerController.network(url);

    final old = _controller;
    _controller = controller;
    if (old != null) {
      old.removeListener(_onControllerUpdated);
      old.pause();
      debugPrint("---- old contoller paused.");
    }

    debugPrint("---- controller changed.");
    setState(() {});

    controller
      ..initialize().then((_) {
        debugPrint("---- controller initialized");
        old?.dispose();

        _duration = null;
        _position = null;
        controller.addListener(_onControllerUpdated);
        controller.play();
        setState(() {});
      });
  }

  Widget _centerUI() {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          onPressed: () async {
            if (_isPlaying) {
              _controller?.pause();
              _isPlaying = false;
            } else {
              _controller?.play();
              _isPlaying = true;
            }
            setState(() {});
          },
          child: Icon(
            _isPlaying ? Icons.pause : Icons.play_arrow,
            size: 56.0,
            color: Colors.white,
          ),
        ),
        // FlatButton(
        //   onPressed: () async {},
        //   child: Icon(
        //     Icons.fast_forward,
        //     size: 36.0,
        //     color: Colors.white,
        //   ),
        // ),
      ],
    ));
  }

  Widget _playView(BuildContext context) {
    final controller = _controller;
    if (controller != null && controller.value.initialized) {
      return AspectRatio(
        //aspectRatio: controller.value.aspectRatio,
        aspectRatio: 16.0 / 9.0,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              child: VideoPlayer(controller),
              onTap: _onTapVideo,
            ),
            _controlAlpha > 0
                ? AnimatedOpacity(
                    opacity: _controlAlpha,
                    duration: Duration(milliseconds: 250),
                    child: _controlView(context),
                  )
                : Container(),
          ],
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: 16.0 / 9.0,
        child: Center(
            child: Text(
          "Preparing ...",
          style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 18.0),
        )),
      );
    }
  }

  Widget _bottomUI() {
    return Row(
      children: <Widget>[
        SizedBox(width: 20),
        Expanded(
          child: Slider(
            value: max(0, min(_progress * 100, 100)),
            min: 0,
            max: 100,
            onChanged: (value) {
              setState(() {
                _progress = value * 0.01;
              });
            },
            onChangeStart: (value) {
              debugPrint("-- onChangeStart $value");
              _controller?.pause();
            },
            onChangeEnd: (value) {
              debugPrint("-- onChangeEnd $value");
              final duration = _controller?.value?.duration;
              if (duration != null) {
                var newValue = max(0, min(value, 99)) * 0.01;
                var millis = (duration.inMilliseconds * newValue).toInt();
                _controller?.seekTo(Duration(milliseconds: millis));
                _controller?.play();
              }
            },
          ),
        ),
        // IconButton(
        //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        //   color: Colors.yellow,
        //   icon: Icon(
        //     Icons.fullscreen,
        //     color: Colors.white,
        //   ),
        //   onPressed:   _toggleFullscreen,
        // ),
      ],
    );
  }

  var _disposed = false;
  var _isFullScreen = false;

  Widget _controlView(context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _centerUI(),
        ),
        _bottomUI()
      ],
    );
    return Container(
      height: 100,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              });
            },
            child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                size: 80,
                color: deepBlue),
          ),
          Row(
            children: <Widget>[
              SizedBox(width: 20),
              Expanded(
                child: Slider(
                  value: max(0, min(_progress * 100, 100)),
                  min: 0,
                  max: 100,
                  onChanged: (value) {
                    setState(() {
                      _progress = value * 0.01;
                    });
                  },
                  onChangeStart: (value) {
                    debugPrint("-- onChangeStart $value");
                    _controller?.pause();
                  },
                  onChangeEnd: (value) {
                    debugPrint("-- onChangeEnd $value");
                    final duration = _controller?.value?.duration;
                    if (duration != null) {
                      var newValue = max(0, min(value, 99)) * 0.01;
                      var millis = (duration.inMilliseconds * newValue).toInt();
                      _controller?.seekTo(Duration(milliseconds: millis));
                      _controller?.play();
                    }
                  },
                ),
              ),
              // IconButton(
              //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              //   color: Colors.yellow,
              //   icon: Icon(
              //     Icons.fullscreen,
              //     color: Colors.white,
              //   ),
              //   onPressed: _toggleFullscreen,
              // ),
            ],
          )
        ],
      ),
    );
  }

  // void _toggleFullscreen() async {
  //   if (_isFullScreen) {
  //     _exitFullScreen();
  //   } else {
  //     _enterFullScreen();
  //   }
  // }
  Timer _timerVisibleControl;
  double _controlAlpha = 1.0;

  var _playing = false;

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
