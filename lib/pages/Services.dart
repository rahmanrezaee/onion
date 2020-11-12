import 'package:carousel_slider/carousel_slider.dart';
import "package:flutter/material.dart";
import 'package:lottie/lottie.dart';
import 'package:onion/const/color.dart';
import 'package:onion/services/ServicesPage.dart';
import 'package:onion/utilities/CustomScrollBehavior.dart';
import 'package:onion/widgets/MyAppBar.dart';
import 'package:progressive_image/progressive_image.dart';

class Services extends StatefulWidget {
  static String routeName = "Services";

  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  int _current = 0;
  //DemoImages
  List<String> sliderImages;
  @override
  void initState() {
    ServicesHttp().getSliders().then((images) {
      setState(() {
        sliderImages = images;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Services",
        openDrawer: () {
          // print("ali azad");
          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
          //   return CustomDrawerPage(page: Services());
          // }));
        },
      ),
      body: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            //Appbar container for making border radius in bottomLeft and bottomRight
            width: MediaQuery.of(context).size.width,
            height: 25,
            decoration: BoxDecoration(
              color: middlePurple,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),
          ),
          SizedBox(height: 20),
          //Image Slider start
          sliderImages == null
              ? Padding(
                  padding: EdgeInsets.all(8), child: LinearProgressIndicator())
              : CarouselSlider(
                  options: CarouselOptions(
                      viewportFraction: .9,
                      height: 150.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                  items: sliderImages.map((imageLink) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // image: DecorationImage(
                              // image: NetworkImage(imageLink), fit: BoxFit.cover,
                              // ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FadeInImage.assetNetwork(
                                placeholder: "assets/images/placeholder.gif",
                                image: imageLink,
                                fit: BoxFit.cover,
                                fadeOutDuration: Duration(milliseconds: 10),
                                fadeInDuration: Duration(milliseconds: 300),
                              ),
                            ));
                      },
                    );
                  }).toList(),
                ),
          SizedBox(height: 10),
          // Making custome Indicator
          sliderImages == null
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...sliderImages.map((element) {
                      int index = sliderImages.indexOf(element);
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        width: 25,
                        height: 3,
                        decoration: BoxDecoration(
                          color: _current == index
                              ? Color(0xffc193cc)
                              : Color(0xffe0e6eb),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    }).toList(),
                  ],
                ),
          //Slider End
          Padding(
            padding: const EdgeInsets.only(
                          top: 20, bottom: 10, left: 10, right: 20),
            child: Text("Our Services",
                                  style: TextStyle(fontSize: 20)),
          ),
          FutureBuilder(
            future: ServicesHttp().getServicesList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data;
                return Column(
                  children: [
                    ...data.map((e)=>Column(
                      children: [
                        //Our Services//////////////////////////////////////////////////
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 10, right: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex: 1,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                          e["image"],
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(e["title"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                  color: Colors.black)),
                                          Text(
                                              e["text"],
                                              style: TextStyle(color: Colors.grey)),
                                        ]),
                                  ),
                                ]),
                                Padding(
                                  padding: EdgeInsets.only(right: 20, top: 10),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text("Post an Idea Now",
                                        style: TextStyle(
                                            decoration: TextDecoration.underline,
                                            color: middlePurple)),
                                  ),
                                ),
                              ]),
                        ),
                        //The horizontal List part//////////////////////////////////////////////////////////////
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Trending Ideas",
                                  style: TextStyle(fontSize: 20)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 90,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  ListItem(
                                    //I made list item dynammic you can find it in this page
                                    title: "1.5G Technology",
                                    image:
                                        "https://helpx.adobe.com/content/dam/help/en/stock/how-to/visual-reverse-image-search-v2_297x176.jpg",
                                  ),
                                  ListItem(
                                    title: "1.5G Technology",
                                    image:
                                        "https://helpx.adobe.com/content/dam/help/en/stock/how-to/visual-reverse-image-search-v2_297x176.jpg",
                                  ),
                                  ListItem(
                                    title: "1.5G Technology",
                                    image:
                                        "https://helpx.adobe.com/content/dam/help/en/stock/how-to/visual-reverse-image-search-v2_297x176.jpg",
                                  ),
                                  ListItem(
                                    title: "1.5G Technology",
                                    image:
                                        "https://helpx.adobe.com/content/dam/help/en/stock/how-to/visual-reverse-image-search-v2_297x176.jpg",
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10, top: 10),
                              child: Divider(),
                            )
                          ]),
                        ),
                      ],
                    ),),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("something went wrong! Please try again.");
              } else {
                return Padding(
                    padding: EdgeInsets.all(8),
                    child: LinearProgressIndicator());
              }
            },
          ),

          //Second list

          // Padding(
          //   padding: EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 20),
          //   child:
          //       Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //     SizedBox(height: 10),
          //     Row(children: [
          //       Expanded(
          //         flex: 1,
          //         child: ClipRRect(
          //             borderRadius: BorderRadius.circular(5),
          //             child: Image.network(
          //                 "https://izminc.org/uploads/3/4/1/2/34128895/11-weiss-pg-rgb_orig.jpg")),
          //       ),
          //       SizedBox(width: 10),
          //       Expanded(
          //         flex: 3,
          //         child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text("Like and Idea? Bid and be a part of it!",
          //                   style: TextStyle(
          //                       fontWeight: FontWeight.w500, fontSize: 13)),
          //               Text(
          //                   "Lorem ipsum dolor sit amit, Lorem ipsum dolor sit amit",
          //                   style: TextStyle(color: Colors.grey)),
          //             ]),
          //       ),
          //     ]),
          //     Padding(
          //       padding: EdgeInsets.only(right: 20, top: 10),
          //       child: Align(
          //         alignment: Alignment.centerRight,
          //         child: Text("Bid Now",
          //             style: TextStyle(
          //                 decoration: TextDecoration.underline,
          //                 color: middlePurple)),
          //       ),
          //     ),
          //   ]),
          // ),
          // //The Horizontal List
          // Padding(
          //   padding: EdgeInsets.only(left: 10),
          //   child: Column(children: [
          //     Align(
          //       alignment: Alignment.centerLeft,
          //       child: Text("Trending Ideas", style: TextStyle(fontSize: 20)),
          //     ),
          //     SizedBox(
          //       height: 10,
          //     ),
          //     Container(
          //       height: 90,
          //       child: ListView(
          //         scrollDirection: Axis.horizontal,
          //         children: [
          //           ListItem(
          //             title: "1.5G Technology",
          //             image:
          //                 "https://helpx.adobe.com/content/dam/help/en/stock/how-to/visual-reverse-image-search-v2_297x176.jpg",
          //           ),
          //           ListItem(
          //             title: "1.5G Technology",
          //             image:
          //                 "https://helpx.adobe.com/content/dam/help/en/stock/how-to/visual-reverse-image-search-v2_297x176.jpg",
          //           ),
          //           ListItem(
          //             title: "1.5G Technology",
          //             image:
          //                 "https://helpx.adobe.com/content/dam/help/en/stock/how-to/visual-reverse-image-search-v2_297x176.jpg",
          //           ),
          //           ListItem(
          //             title: "1.5G Technology",
          //             image:
          //                 "https://helpx.adobe.com/content/dam/help/en/stock/how-to/visual-reverse-image-search-v2_297x176.jpg",
          //           ),
          //         ],
          //       ),
          //     ),
          //     Padding(
          //       padding: EdgeInsets.only(right: 10, top: 10),
          //       child: Divider(),
          //     )
          // ]),
          // ),
        ])),
      ),
    );
  }
}

//Horizontal list item
class ListItem extends StatelessWidget {
  final title;
  final image;
  ListItem({this.title, this.image});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 10),
        child: Stack(children: [
          Container(
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: middlePurple,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              width: 110,
              child: FittedBox(
                  child: Text(title, style: TextStyle(color: Colors.white))),
            ),
          ),
        ]));
  }
}
