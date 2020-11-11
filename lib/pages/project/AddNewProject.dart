import 'package:flutter/material.dart';
import 'package:onion/widgets/DropdownWidget/DropDownFormField.dart';

class AddNewProject extends StatefulWidget {
  @override
  _AddNewProjectState createState() => _AddNewProjectState();
}

class _AddNewProjectState extends State<AddNewProject> {
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
                          {"display": 'Idea', "value": 'none'},
                          {"display": 'Technalogy', "value": 'tach'},
                          {"display": 'Learing', "value": 'learing'},
                        ],
                        textField: 'display',
                        valueField: 'value',
                      ),
                      SizedBox(height: 10),
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
                          hintText: "Project Name",
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
                          hintText: "Service Provider Name",
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
                                hintText: "Search Investor",
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
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(child: Text("Business Developer Dirctor")),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Invite",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(child: Text("Business Developer Dirctor")),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Invite",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(child: Text("Business Developer Dirctor")),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Invite",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                decoration: BoxDecoration(
                  // color: ,
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "View Contract",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                decoration: BoxDecoration(
                  // color: ,
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "View NDA",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                decoration: BoxDecoration(
                  // color: ,
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "View Documents/Video",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                decoration: BoxDecoration(
                  // color: ,
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Project Chat",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.topLeft,
                child: Text(
                  "Project Description",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
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
              Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.topLeft,
                child: Text(
                  "TimeLine",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              DropDownFormField(
                value: "none",
                onSaved: (value) {
                  // setState(() {
                  //   user.interst = value;
                  // });
                },
                dataSource: [
                  {"display": 'Select Total Stages', "value": 'none'},
                  {"display": 'Technalogy', "value": 'tach'},
                  {"display": 'Learing', "value": 'learing'},
                ],
                textField: 'display',
                valueField: 'value',
              ),
              SizedBox(height: 10),
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
                  hintText: "Enter Name of Stage 1",
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
                  hintText: "Enter Start Date of Stage 1",
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
                  hintText: "Enter End Date of Stage 1",
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
              ), SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: RaisedButton(
                  onPressed: () {},
                  child: Text(
                    "Save",
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
      ),
    );
  }
}
