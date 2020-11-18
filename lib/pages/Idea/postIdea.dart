import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:onion/const/color.dart';
import 'package:onion/models/Idea.dart';
import 'package:onion/pages/Home.dart';
import 'package:onion/pages/Idea/setupIdea.dart';
import 'package:onion/widgets/Checkbox/GlowCheckbox.dart';
import 'package:onion/widgets/DropdownWidget/DropDownFormField.dart';
import 'package:onion/widgets/IdeaWiget/LocationWidget.dart';
import 'package:onion/widgets/MyLittleAppbar.dart';

class PostIdea extends StatefulWidget {
  static final routeName = "/postIdea";

  @override
  _PostIdeaState createState() => _PostIdeaState();
}

class _PostIdeaState extends State<PostIdea> {
  List<Map> image = [];
  List<String> list = new List<String>();
  List<TextEditingController> _controllers = [];

  int addinput = 1;

  void addField() {
    setState(() {
      this.list.add("");
      this._controllers.add(new TextEditingController());
    });
  }

  SetupIdeaModel postForm = new SetupIdeaModel();
  @override
  void initState() {
    addField();
    super.initState();
  }

  bool checkboxSelectedNeedSerive = true;
  bool checkboxSelectedNeedInvestor = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: MyLittleAppbar(myTitle: "Add new Idea"),
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
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Radio(
                                activeColor: Theme.of(context).primaryColor,
                                value: postForm.typeIdea == null
                                    ? 0
                                    : postForm.typeIdea == "new"
                                        ? 1
                                        : 0,
                                groupValue: 1,
                                onChanged: (va) {
                                  print(va);
                                  setState(() {
                                    postForm.typeIdea = "new";
                                  });
                                },
                              ),
                              new Text(
                                'New Idea',
                                style: new TextStyle(fontSize: 16.0),
                              ),
                              new Radio(
                                activeColor: Theme.of(context).primaryColor,
                                value: postForm.typeIdea == null
                                    ? 1
                                    : postForm.typeIdea == "imp"
                                        ? 1
                                        : 0,
                                groupValue: 1,
                                onChanged: (va) {
                                  setState(() {
                                    postForm.typeIdea = "imp";
                                  });
                                },
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
                            value: postForm.category != null
                                ? postForm.category
                                : "none",
                            onSaved: (value) {
                              setState(() {
                                postForm.category = value;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                postForm.category = value;
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
                             crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
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
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                'TimeLine :',
                                style: new TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              new Radio(
                                activeColor: Theme.of(context).primaryColor,
                                value: postForm.timeline == null
                                    ? 0
                                    : postForm.timeline == "stage"
                                        ? 1
                                        : 0,
                                groupValue: 1,
                                onChanged: (va) {
                                  print(va);
                                  setState(() {
                                    postForm.timeline = "stage";
                                  });
                                },
                              ),
                              new Text(
                                'Stage',
                                style: new TextStyle(fontSize: 13),
                              ),
                              new Radio(
                                activeColor: Theme.of(context).primaryColor,
                                value: postForm.timeline == null
                                    ? 1
                                    : postForm.timeline == "date"
                                        ? 1
                                        : 0,
                                groupValue: 1,
                                onChanged: (va) {
                                  setState(() {
                                    postForm.timeline = "date";
                                  });
                                },
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
                             crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.url,
                                  style: TextStyle(
                                    color: Colors.purple,
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty)
                                      return "Your WebSite is empty";
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
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  color: Theme.of(context).primaryColor,
                                  child: Text("Upload",
                                      style: TextStyle(color: Colors.white)),
                                ),
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
                                    ? Stack(
                                        children: [
                                          Positioned(
                                            bottom: 0,
                                            top: 0,
                                            left: 0,
                                            right: 0,
                                            child: Card(
                                              child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  child: image[index]["type"] ==
                                                              "jpg" ||
                                                          image[index]
                                                                  ["type"] ==
                                                              "jpeg" ||
                                                          image[index]
                                                                  ["type"] ==
                                                              "png"
                                                      ? Image.file(File(
                                                          image[index]['path']))
                                                      : Icon(
                                                          Icons.file_present)),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: IconButton(
                                                icon: Icon(Icons.delete,
                                                    color: Colors.white),
                                                onPressed: () {
                                                  setState(() {
                                                    image.removeAt(index);
                                                  });
                                                }),
                                          )
                                        ],
                                      )
                                    : FlatButton(
                                        onPressed: loadAssets,
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
                                                color: Theme.of(context)
                                                    .primaryColor,
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
                             crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.url,
                                  style: TextStyle(
                                    color: Colors.purple,
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty)
                                      return "Your Upload Video is empty";
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
                              "Target Audience",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
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
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: Colors.purple,
                            ),
                            validator: (value) {
                              if (value.isEmpty)
                                return "Your No of estimated people is empty";
                            },
                            onSaved: (value) {
                              // user.occupation = value;
                            },
                            decoration: InputDecoration(
                              hintText: "No of estimated people",
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.url,
                                  style: TextStyle(
                                    color: Colors.purple,
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty)
                                      return "Your Upload White Paper is empty";
                                  },
                                  onSaved: (value) {
                                    // user.occupation = value;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Upload White Paper",
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
                          Row(
                            children: [
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    text:
                                        'In order to Recieve bids and investor request. you need to upload white Paper',
                                    style: TextStyle(color: Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(text: ''),
                                    ],
                                  ),
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
                                child: Row(
                                  children: [
                                    GlowCheckbox(
                                      color: Theme.of(context).primaryColor,
                                      value: checkboxSelectedNeedInvestor,
                                      enable: true,
                                      onChange: (bool value) {
                                        print(value);
                                        setState(() {
                                          checkboxSelectedNeedInvestor =
                                              !checkboxSelectedNeedInvestor;
                                        });
                                      },
                                    ),
                                    SizedBox(width: 5),
                                    Text("Need Serive Provider"),
                                    SizedBox(width: 5),
                                    GlowCheckbox(
                                      color: Theme.of(context).primaryColor,
                                      value: checkboxSelectedNeedSerive,
                                      enable: true,
                                      onChange: (bool value) {
                                        print(value);
                                        setState(() {
                                          checkboxSelectedNeedSerive =
                                              !checkboxSelectedNeedSerive;
                                        });
                                      },
                                    ),
                                    SizedBox(width: 5),
                                    Text("Need Investor"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: RaisedButton(
                              onPressed: addPostIdeaSetup,
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

  Future<void> loadAssets() async {
    // FilePickerResult result = await FilePicker.platform.pickFiles();

    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      // allowedExtensions: ['jpg', 'pdf', 'docs', 'png'],
    );

    if (result != null) {
      List<PlatformFile> file = result.files;

      file.forEach((element) {
        setState(() {
          image.add({
            "name": element.name,
            "path": element.path,
            "type": element.extension,
          });
        });
      });
    } else {
      // User canceled the picker
    }
    // try {
    //   if (gallaryimages.length < 5) {
    //     File imagesPick = await ImagePicker.pickImage(
    //       source: ImageSource.gallery,
    //     );

    //     imagesPick = await UtilClass().cropImage(imagesPick, context);
    //     if (imagesPick != null) {
    //       setState(() {
    //         if (gallaryimages.length >= 4) {
    //           _addImageToGallary = false;
    //         }
    //         // gallaryimages.add(imagesPick);
    //       });
    //     }

    //     setState(() {
    //       _isUploadingImage = true;
    //     });

    //     // int indexFile = gallaryimages.length;

    //     PropertyProvider()
    //         .uploadImage(imagesPick, (int a, int b) {})
    //         .then((data) {
    //       if (data != null) {
    //         ImageProperty image = data;
    //         setState(() {
    //           _isUploadingImage = false;
    //           property.gallary.add(image);
    //           indexLoadingImage = null;
    //         });
    //       }
    //     });
    //   }
    // } on Exception catch (e) {
    //   error = e.toString();
    // }
  }

  final _formKey = new GlobalKey<FormState>();
  void addPostIdeaSetup() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Navigator.pushNamed(context, "/");
    }
  }
}
