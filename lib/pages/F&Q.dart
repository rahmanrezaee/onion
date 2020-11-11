import 'package:flutter/material.dart';
import 'package:onion/pages/CustomDrawerPage.dart';

class FandQ extends StatelessWidget {
  static String routeName = "FandQ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ"),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(CustomDrawerPage.routeName);
            }),
      ),
      body: ListView(
        children: [
          SizedBox(height: 15),
          CustomizeExpansion(
            title: Text("Lorem Ipsum has been the industry's standard dummy",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff555555),
                )),
            content: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in"),
            openedIcon: Icon(Icons.remove, color: Color(0xFF555555)),
          ),
          CustomizeExpansion(
            openedIcon: Icon(Icons.remove, color: Color(0xFF555555)),
          ),
          CustomizeExpansion(
            openedIcon: Icon(Icons.remove, color: Color(0xFF555555)),
          ),
          CustomizeExpansion(
            openedIcon: Icon(Icons.remove, color: Color(0xFF555555)),
          ),
        ],
      ),
    );
  }
}

//CustomizeExpansion
class CustomizeExpansion extends StatefulWidget {
  final Icon icon;
  final Icon openedIcon;
  final Widget title;
  final Widget content;
  CustomizeExpansion({
    this.icon,
    this.openedIcon,
    this.title,
    this.content,
    Key key,
  }) : super(key: key);

  @override
  _CustomizeExpansionState createState() => _CustomizeExpansionState();
}

class _CustomizeExpansionState extends State<CustomizeExpansion> {
  //We change icon when Expansion opened and closed
  Icon expansionIcon;
  @override
  void initState() {
    expansionIcon = widget.icon;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Here we delete the default expansion divider
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Column(
      children: [
        Theme(
          data: theme,
          child: ExpansionTile(
            onExpansionChanged: (bool open) {
              //Chaning Icon
              if (open == true) {
                print("opened");
                setState(() {
                  expansionIcon = widget.openedIcon;
                });
              } else {
                setState(() {
                  expansionIcon = widget.icon;
                });
                print("closed");
              }
            },
            //Delete the end icon
            trailing: Icon(Icons.add, color: Colors.white),
            //Set leading icon
            //Title
            title: Row(
              children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFd8d8d8),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: expansionIcon == null
                    ? Icon(Icons.add, color: Color(0xFF555555))
                    : expansionIcon,
              ),
              SizedBox(width: 15),
              Expanded(child:widget.title == null
                  ? Text("Lorem Ipsum has been the industry's standard dummy",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff555555),
                      ))
                  : widget.title)
            ]),
            //Paddings
            tilePadding: EdgeInsets.symmetric(horizontal: 10),
            childrenPadding: EdgeInsets.symmetric(horizontal: 50),
            //Content
            children: [
              widget.content == null
                  ? Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in")
                  : widget.content,
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
