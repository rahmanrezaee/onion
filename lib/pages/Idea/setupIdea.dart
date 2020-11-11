import 'package:flutter/material.dart';
import 'package:onion/pages/Idea/postIdea.dart';
import 'package:onion/widgets/DropdownWidget/DropDownFormField.dart';

class SetupIdea extends StatefulWidget {
  static final routeName = "setupIdea";
  @override
  _SetupIdeaState createState() => _SetupIdeaState();
}

class _SetupIdeaState extends State<SetupIdea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                        decoration: InputDecoration(
                          hintText: "Location",
                          suffixIcon: Icon(Icons.location_on),
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
                      FlatButton(
                        onPressed: null,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text("Add More"),
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
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: RaisedButton(
                          onPressed: () => Navigator.pushNamed(context, PostIdea.routeName),
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
