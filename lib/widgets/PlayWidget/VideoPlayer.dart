import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:screen/screen.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  VideoPlayerWidget({Key key, @required this.clipsUrl}) : super(key: key);

  final String clipsUrl;

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController _controller;

  var _disposed = false;
  var _isFullScreen = false;
  var _isEndOfClip = false;
  var _progress = 0.0;
  var _showingDialog = false;
  Timer _timerVisibleControl;
  double _controlAlpha = 1.0;

  var _playing = false;
  bool get _isPlaying {
    return _playing;
  }

  set _isPlaying(bool value) {
    _playing = value;
    _timerVisibleControl?.cancel();
    if (value) {
      _timerVisibleControl = Timer(Duration(seconds: 2), () {
        if (_disposed) return;
        setState(() {
          _controlAlpha = 0.0;
        });
      });
    } else {
      _timerVisibleControl = Timer(Duration(milliseconds: 200), () {
        if (_disposed) return;
        setState(() {
          _controlAlpha = 1.0;
        });
      });
    }
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

  @override
  void initState() {
    // Screen.keepOn(true);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    _initializeAndPlay();
    super.initState();
  }

  @override
  void dispose() {
    _disposed = true;
    _timerVisibleControl?.cancel();
    // Screen.keepOn(false);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    _exitFullScreen();
    _controller?.pause(); // mute instantly
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  void _toggleFullscreen() async {
    if (_isFullScreen) {
      _exitFullScreen();
    } else {
      _enterFullScreen();
    }
  }

  void _enterFullScreen() async {
    debugPrint("enterFullScreen");
    await SystemChrome.setEnabledSystemUIOverlays([]);
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    if (_disposed) return;
    setState(() {
      _isFullScreen = true;
    });
  }

  void _exitFullScreen() async {
    debugPrint("exitFullScreen");
    await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    if (_disposed) return;
    setState(() {
      _isFullScreen = false;
    });
  }

  var controller;
  void _initializeAndPlay() async {
    print("_initializeAndPlay ---------> ");

    controller = VideoPlayerController.network(widget.clipsUrl);

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

  var _updateProgressInterval = 0.0;
  Duration _duration;
  Duration _position;

  void _onControllerUpdated() async {
    if (_disposed) return;
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
      if (_disposed) return;
      setState(() {
        _progress = position.inMilliseconds.ceilToDouble() /
            duration.inMilliseconds.ceilToDouble();
      });
    }

    // handle clip end
    if (_isPlaying != playing || _isEndOfClip != isEndOfClip) {
      _isPlaying = playing;
      _isEndOfClip = isEndOfClip;
      debugPrint(
          "updated -----> isPlaying=$playing / isEndOfClip=$isEndOfClip");
      if (isEndOfClip && !playing) {
        debugPrint(
            "========================== End of Clip / Handle NEXT ========================== ");

        _initializeAndPlay();
      }
    }
  }

  Future<bool> _showPlayedAllDialog() async {
    return showDialog<bool>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(child: Text("Played all videos.")),
            actions: <Widget>[
              FlatButton(
                child: Text("Close"),
                onPressed: () => Navigator.pop(context, true),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        child: Center(child: _playView(context)),
        decoration: BoxDecoration(color: Colors.black),
      ),
    ]);
  }

  void _onTapCard() {
    _initializeAndPlay();
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

  // Widget _listView() {
  //   return ListView.builder(
  //     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //     itemCount: _clips.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       return InkWell(
  //         borderRadius: BorderRadius.all(Radius.circular(6)),
  //         splashColor: Colors.blue[100],
  //         onTap: () {
  //           _onTapCard(index);
  //         },
  //         child: _buildCard(index),
  //       );
  //     },
  //   ).build(context);
  // }

  Widget _controlView(BuildContext context) {
    return Column(
      children: <Widget>[
        _topUI(),
        Expanded(
          child: _centerUI(),
        ),
        _bottomUI()
      ],
    );
  }

  Widget _centerUI() {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          onPressed: () async {
            _initializeAndPlay();
          },
          child: Icon(
            Icons.fast_rewind,
            size: 36.0,
            color: Colors.white,
          ),
        ),
        FlatButton(
          onPressed: () async {
            if (_isPlaying) {
              _controller?.pause();
              _isPlaying = false;
            } else {
              final controller = _controller;
              if (controller != null) {
                final pos = _position?.inSeconds ?? 0;
                final dur = _duration?.inSeconds ?? 0;
                final isEnd = pos == dur;
                if (isEnd) {
                  _initializeAndPlay();
                } else {
                  controller.play();
                }
              }
            }
            setState(() {});
          },
          child: Icon(
            _isPlaying ? Icons.pause : Icons.play_arrow,
            size: 56.0,
            color: Colors.white,
          ),
        ),
        FlatButton(
          onPressed: () async {
            // final index = _playingIndex + 1;
            // if (index < _clips.length - 1) {
            _initializeAndPlay();
            // }
          },
          child: Icon(
            Icons.fast_forward,
            size: 36.0,
            color: Colors.white,
          ),
        ),
      ],
    ));
  }

  String convertTwo(int value) {
    return value < 10 ? "0$value" : "$value";
  }

  Widget _topUI() {
    final noMute = (_controller?.value?.volume ?? 0) > 0;
    final duration = _duration?.inSeconds ?? 0;
    final head = _position?.inSeconds ?? 0;
    final remained = max(0, duration - head);
    final min = convertTwo(remained ~/ 60.0);
    final sec = convertTwo(remained % 60);
    return Row(
      children: <Widget>[
        InkWell(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 4.0,
                      color: Color.fromARGB(50, 0, 0, 0)),
                ]),
                child: Icon(
                  noMute ? Icons.volume_up : Icons.volume_off,
                  color: Colors.white,
                )),
          ),
          onTap: () {
            if (noMute) {
              _controller?.setVolume(0);
            } else {
              _controller?.setVolume(1.0);
            }
            setState(() {});
          },
        ),
        Expanded(
          child: Container(),
        ),
        Text(
          "$min:$sec",
          style: TextStyle(
            color: Colors.white,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(0.0, 1.0),
                blurRadius: 4.0,
                color: Color.fromARGB(150, 0, 0, 0),
              ),
            ],
          ),
        ),
        SizedBox(width: 10)
      ],
    );
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
        IconButton(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          color: Colors.yellow,
          icon: Icon(
            Icons.fullscreen,
            color: Colors.white,
          ),
          onPressed: _toggleFullscreen,
        ),
      ],
    );
  }

  Widget _buildCard(int index) {
    // final clip = _clips[index];
    // final playing = 0;
    String runtime;
    // if (clip.runningTime > 60) {
    //   runtime = "${clip.runningTime ~/ 60}분 ${clip.runningTime % 60}초";
    // } else {
    //   runtime = "${clip.runningTime % 60}초";
    // }
    return Card(
      child: Container(
        padding: EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Padding(
            //   padding: EdgeInsets.only(right: 8),
            //   child:  Image.network(clip.thumbPath(), width: 70, height: 50, fit: BoxFit.fill)
            //     ),
            Expanded(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("clip.title",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Padding(
                      child: Text("$runtime",
                          style: TextStyle(color: Colors.grey[500])),
                      padding: EdgeInsets.only(top: 3),
                    )
                  ]),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: _isPlaying
                  ? Icon(Icons.play_arrow)
                  : Icon(
                      Icons.play_arrow,
                      color: Colors.grey.shade300,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}