import 'package:carousel_slider/carousel_slider.dart';
import "package:flutter/material.dart";
import 'package:onion/const/color.dart';
import 'package:onion/pages/CustomDrawerPage.dart';
import 'package:onion/utilities/CustomScrollBehavior.dart';
import 'package:onion/widgets/MyAppBar.dart';

class Services extends StatefulWidget {
  static String routeName = "Services";

  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  int _current = 0;
  //DemoImages
  final List<String> sliderImages = [
    'https://images.unsplash.com/photo-1586882829491-b81178aa622e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586871608370-4adee64d1794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2862&q=80',
    'https://images.unsplash.com/photo-1586901533048-0e856dff2c0d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Services", openDrawer: (){
        // print("ali azad");
        // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        //   return CustomDrawerPage(page: Services());
        // }));
      },),
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
          CarouselSlider(
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
                      image: DecorationImage(
                          image: NetworkImage(imageLink), fit: BoxFit.cover),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          // Making custome Indicator
          Row(
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
          //Our Services//////////////////////////////////////////////////
          Padding(
            //
            padding: EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Our Services", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Row(children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        "https://helpx.adobe.com/content/dam/help/en/stock/how-to/visual-reverse-image-search-v2_297x176.jpg",
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Your Ideas! Our Believe!",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Colors.black)),
                        Text(
                            "Lorem ipsum dolor sit amit, Lorem ipsum dolor sit amit",
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
                child: Text("Trending Ideas", style: TextStyle(fontSize: 20)),
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

          //Second list

          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 10),
              Row(children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                          "https://izminc.org/uploads/3/4/1/2/34128895/11-weiss-pg-rgb_orig.jpg")),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Like and Idea? Bid and be a part of it!",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 13)),
                        Text(
                            "Lorem ipsum dolor sit amit, Lorem ipsum dolor sit amit",
                            style: TextStyle(color: Colors.grey)),
                      ]),
                ),
              ]),
              Padding(
                padding: EdgeInsets.only(right: 20, top: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("Bid Now",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: middlePurple)),
                ),
              ),
            ]),
          ),
          //The Horizontal List
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Column(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Trending Ideas", style: TextStyle(fontSize: 20)),
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
