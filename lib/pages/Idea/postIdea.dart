import 'package:flutter/material.dart';
import 'package:onion/widgets/DropdownWidget/DropDownFormField.dart';
import 'package:onion/widgets/MyLittleAppbar.dart';

class PostIdea extends StatefulWidget {
  static final routeName = "/postIdea";

  @override
  _PostIdeaState createState() => _PostIdeaState();
}

class _PostIdeaState extends State<PostIdea> {
  List<Map> image = [
    {"id": 1, "image": "assets/images/document.jpg"},
    {"id": 2, "image": "assets/images/document.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: MyLittleAppbar(myTitle: "Add new Idea"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(
                    "Build Your Profile to Post your Idea",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )),
                  InkWell(
                    child: Icon(Icons.info),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Card(
                // margin: EdgeInsets.all(10),
                elevation: 10,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Radio(
                            value: 0,
                            groupValue: 1,
                            onChanged: (va) {},
                          ),
                          new Text(
                            'New Idea',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          new Radio(
                            value: 1,
                            groupValue: 1,
                            onChanged: (va) {},
                          ),
                          new Text(
                            'Implement Idea',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropDownFormField(
                        value: "none",
                        onSaved: (value) {
                          // setState(() {
                          //   user.interst = value;
                          // });
                        },
                        dataSource: [
                          {"display": 'Industry', "value": 'none'},
                          {"display": 'Technalogy', "value": 'tach'},
                          {"display": 'Learing', "value": 'learing'},
                        ],
                        textField: 'display',
                        valueField: 'value',
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Industry Experience",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: Colors.purple,
                              ),
                              validator: (value) {
                                if (value.isEmpty)
                                  return "Your Occupation is empty";
                              },
                              onSaved: (value) {
                                // user.occupation = value;
                              },
                              decoration: InputDecoration(
                                hintText: "Year",
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black87,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.purple,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: Colors.purple,
                              ),
                              validator: (value) {
                                if (value.isEmpty)
                                  return "Your Occupation is empty";
                              },
                              onSaved: (value) {
                                // user.occupation = value;
                              },
                              decoration: InputDecoration(
                                hintText: "Month",
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black87,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.purple,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: Colors.purple,
                        ),
                        validator: (value) {
                          if (value.isEmpty) return "Your Occupation is empty";
                        },
                        onSaved: (value) {
                          // user.occupation = value;
                        },
                        decoration: InputDecoration(
                          hintText: "Team Size",
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 10,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black87,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: Colors.purple,
                        ),
                        validator: (value) {
                          if (value.isEmpty) return "Your Occupation is empty";
                        },
                        onSaved: (value) {
                          // user.occupation = value;
                        },
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "About Your Business",
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black87,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            'TimeLine :',
                            style: new TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                          new Radio(
                            value: 0,
                            groupValue: 1,
                            onChanged: (va) {},
                          ),
                          new Text(
                            'Stage',
                            style: new TextStyle(fontSize: 13),
                          ),
                          new Radio(
                            value: 1,
                            groupValue: 1,
                            onChanged: (va) {},
                          ),
                          new Text(
                            'Date',
                            style: new TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: Colors.purple,
                              ),
                              validator: (value) {
                                if (value.isEmpty)
                                  return "Your Occupation is empty";
                              },
                              onSaved: (value) {
                                // user.occupation = value;
                              },
                              decoration: InputDecoration(
                                hintText: "WebSite",
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black87,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.purple,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          RaisedButton(
                            padding: EdgeInsets.all(13),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {},
                            child: Text("Upload",
                                style: TextStyle(color: Colors.white)),
                          )
                        ],
                      ),
                      //  Container(
                      //   padding: EdgeInsets.all(5),
                      //   alignment: Alignment.topLeft,
                      //   child: Text(
                      //     "Document",
                      //     style: TextStyle(
                      //         fontWeight: FontWeight.bold, fontSize: 14),
                      //   ),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 80,
                        child: ListView.builder(
                          itemCount: image.length + 1,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return image.length > index
                                ? Card(
                                    child: Container(
                                        height: 50,
                                        child:
                                            Image.asset(image[index]['image'])),
                                  )
                                : FlatButton(
                                    onPressed: () {},
                                    child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50))),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        )),
                                  );
                          },
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: Colors.purple,
                              ),
                              validator: (value) {
                                if (value.isEmpty)
                                  return "Your Occupation is empty";
                              },
                              onSaved: (value) {
                                // user.occupation = value;
                              },
                              decoration: InputDecoration(
                                hintText: "Upload Video",
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black87,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.purple,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          RaisedButton(
                            padding: EdgeInsets.all(13),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {},
                            child: Text("Upload",
                                style: TextStyle(color: Colors.white)),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Industry Experience",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: Colors.purple,
                        ),
                        validator: (value) {
                          if (value.isEmpty) return "Your Occupation is empty";
                        },
                        onSaved: (value) {
                          // user.occupation = value;
                        },
                        decoration: InputDecoration(
                          hintText: "Team Size",
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 10,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black87,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: Colors.purple,
                        ),
                        validator: (value) {
                          if (value.isEmpty) return "Your Occupation is empty";
                        },
                        onSaved: (value) {
                          // user.occupation = value;
                        },
                        decoration: InputDecoration(
                          hintText: "Team Size",
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 10,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black87,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: Colors.purple,
                              ),
                              validator: (value) {
                                if (value.isEmpty)
                                  return "Your Occupation is empty";
                              },
                              onSaved: (value) {
                                // user.occupation = value;
                              },
                              decoration: InputDecoration(
                                hintText: "Upload Video",
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black87,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.purple,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          RaisedButton(
                            padding: EdgeInsets.all(13),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {},
                            child: Text("Upload",
                                style: TextStyle(color: Colors.white)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: RaisedButton(
                          onPressed: () {},
                          child: Text(
                            "Add Your Idea Setup",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          color: Theme.of(context).primaryColor,
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
