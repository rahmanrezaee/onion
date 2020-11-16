import 'package:flutter/material.dart';
import 'package:onion/models/SetupIdea.dart';
import 'package:onion/pages/Idea/postIdea.dart';
import 'package:onion/widgets/DropdownWidget/DropDownFormField.dart';
import 'package:onion/widgets/IdeaWiget/LocationWidget.dart';
import 'package:onion/widgets/MyLittleAppbar.dart';

class SetupIdea extends StatefulWidget {
  static final routeName = "setupIdea";
  @override
  _SetupIdeaState createState() => _SetupIdeaState();
}

class _SetupIdeaState extends State<SetupIdea> {
  final _formKey = new GlobalKey<FormState>();
  SetupIdeaModel formIdea = new SetupIdeaModel();

  List<String> list = new List<String>();
  List<TextEditingController> _controllers = [];

  int addinput = 1;

  void addField() {
    setState(() {
      this.list.add("");
      this._controllers.add(new TextEditingController());
    });
  }

  @override
  void initState() {
    addField();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: MyLittleAppbar(myTitle: "Setup Idea"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Build Your Profile to Post your Idea",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
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
                            value: formIdea.category != null
                                ? formIdea.category
                                : "none",
                            onSaved: (value) {
                              setState(() {
                                formIdea.category = value;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                formIdea.category = value;
                              });
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
                                      return "Your Yeaer is empty";
                                    if (value.length != 4)
                                      return "Your Year is invalid";
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
                                      return "Your Month is empty";
                                    if (value.length > 2)
                                      return "Your Month is invalid";
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
                              if (value.isEmpty)
                                return "Your Team Size is empty";
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
                          Column(
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: list.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return LocationWidget(
                                      text: list[index],
                                      controller: _controllers[index],
                                      locationRemove: () {
                                        print(list.toString());
                                        setState(() {
                                          _controllers.removeAt(index);
                                          list.removeAt(index);
                                        });
                                      },
                                    );
                                  }),
                              FlatButton(
                                onPressed: () => addField(),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text("Add More"),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                              color: Colors.purple,
                            ),
                            validator: (value) {
                              if (value.isEmpty)
                                return "Your About Your Business is empty";
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
                            keyboardType: TextInputType.url,
                            style: TextStyle(
                              color: Colors.purple,
                            ),
                            validator: (value) {
                              if (value.isEmpty) return "Your WebSite is empty";
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
                              onPressed: addIdeaSetup,
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
        ),
      ),
    );
  }

  void addIdeaSetup() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Navigator.pushNamed(context, PostIdea.routeName);
    }
  }
}
