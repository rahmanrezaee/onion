import 'package:flutter/material.dart';
import 'package:onion/const/color.dart';
import 'package:onion/widgets/MyLittleAppbar.dart';

class InnovatorsIdeas extends StatefulWidget {
  @override
  _InnovatorsIdeasState createState() => _InnovatorsIdeasState();
}

class _InnovatorsIdeasState extends State<InnovatorsIdeas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight + 5),
        child: Column(
          children: [
            MyLittleAppbar(myTitle: "Innovators Ideas"),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("<User> Ideas"),
                  IconButton(
                    icon: Icon(Icons.info_outline),
                    onPressed: () {
                      print("You clicked in the info man!");
                    },
                  ),
                ],
              ),
              InnovatorsIdeaItem(),
              SizedBox(height: 5),
              InnovatorsIdeaItem(),
              SizedBox(height: 5),
              InnovatorsIdeaItem(),
              SizedBox(height: 5),
              InnovatorsIdeaItem(),
            ],
          ),
        ),
      ),
    );
  }
}

class InnovatorsIdeaItem extends StatelessWidget {
  const InnovatorsIdeaItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Industry: <IndustryName>",
                    style: TextStyle(color: middlePurple, fontSize: 15)),
                // Text("Implemented")
                CustomPaint(
                  size: Size(100.0,
                      50.0), //You can Replace this with your desired WIDTH and HEIGHT
                  painter: IdeaTypeShape(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text("Implemented",
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Headline"), Text("Topic Name")],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Location"), Text("Place/Location")],
            ),
            Divider(),
            SizedBox(height: 10),
            Text("Idea Details",
                style: TextStyle(color: deepBlue, fontSize: 15)),
            Text(
                "lorem ipsum doloe sit amit, lorem ipsum doloe sit amit, lorem ipsum doloe sit amit, lorem ipsum doloe sit amit, lorem ipsum doloe sit amit, lorem ipsum doloe sit amit, lorem ipsum doloe sit amit, lorem ipsum doloe sit amit, lorem ipsum doloe sit amit, lorem ipsum doloe sit amit, lorem ipsum doloe sit amit, lorem ipsum doloe sit amit, "),
            SizedBox(height: 4),
            Text(
              "Read More",
              style: TextStyle(
                  color: middlePurple, decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Bids: 220"),
                Text("Total Investors Request: 220"),
              ],
            ),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.bottomRight,
              child: Text("Post: 20-08-2020, 20:56"),
            )
          ],
        ),
      ),
    );
  }
}

class IdeaTypeShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color(0xFF3c465f)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path_0 = Path();
    path_0.moveTo(0, size.height);
    path_0.lineTo(size.width * 0.10, size.height * 0.50);
    path_0.lineTo(0, 0);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width * 0.90, size.height * 0.50);
    path_0.lineTo(size.width, size.height);

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
