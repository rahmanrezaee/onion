import 'package:flutter/material.dart';
import 'package:onion/const/color.dart';
import 'package:onion/pages/CustomDrawerPage.dart';
import 'package:onion/pages/Idea/MyIdeaId.dart';
import 'package:onion/widgets/AnalysisWidget/MyAlert.dart';
// import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class MyIdeaDetails extends StatefulWidget {
  static String routeName = "MyIdeaDetail";

  @override
  _MyIdeaDetailsState createState() => _MyIdeaDetailsState();
}

class _MyIdeaDetailsState extends State<MyIdeaDetails> {
  final String urlToStreamVideo =
      'https://r2---sn-4g5ednee.googlevideo.com/videoplayback?expire=1605463581&ei=vRmxX7DfAcKbgAePpoXICA&ip=37.221.178.103&id=o-AHc-Un2QpnxIK_yr5ahI2qLgHl1jtN748zoYpC1Fx3Dg&itag=18&source=youtube&requiressl=yes&vprv=1&mime=video%2Fmp4&ns=8xYGWk6pA7ySGtJGCqzIbQoF&gir=yes&clen=14052630&ratebypass=yes&dur=213.646&lmt=1604178388266477&fvip=2&c=WEB&txp=6210222&n=O3rg87s6HFzvVIzxy&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cns%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRgIhAIQeJRA5WKm9CBo-8f005v97prRzBO9vgWgXPFrbgzwDAiEA1FgnJ0c6t2DFPl2bUINAK7_wUTXy2q2uK5mgkSL8rbg%3D&rm=sn-huxaqvv-ubqe7l,sn-nv4sl7l&req_id=3eb1e345c455a3ee&redirect_counter=2&cms_redirect=yes&ipbypass=yes&mh=As&mip=103.119.24.113&mm=29&mn=sn-4g5ednee&ms=rdu&mt=1605441888&mv=m&mvi=2&pl=24&lsparams=ipbypass,mh,mip,mm,mn,ms,mv,mvi,pl&lsig=AG3C_xAwRgIhAJfCrypp6O3zAYnK5560-x8bFbhVMx4TaggU5Bgr42zAAiEAhH8tLbW2Xr6qtsD5Lm1b1OMFKSTCMMMbdk6O777bIP4%3D';

  // VlcPlayerController _videoController;

  final double playerWidth = 640.0;

  final double playerHeight = 360.0;
  bool _isPlaying = false;
  initState() {
    // _videoController = new VlcPlayerController(
    //     // Start playing as soon as the video is loaded.
    //     onInit: () {
    //   // _videoController.play();
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                            InkWell(
                              onTap: () {},
                              child: Icon(Icons.more_vert, color: deepGrey),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Industry: ", style: TextStyle(fontSize: 15)),
                            Text(
                              "<IndustryName>",
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
                              "<Headline>",
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
                                  text:
                                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
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
                            children: List.generate(8, (index) {
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
                                setState(() {
                                  // _videoController.pause();
                                  _isPlaying = false;
                                  print("ALi Azad");
                                });
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
                                "Delhi, Punjab",
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
                              "8 People",
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
