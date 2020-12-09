import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_place/google_place.dart';
import 'package:onion/models/SetupIdea.dart';
import 'package:onion/pages/Idea/postIdea.dart';
import 'package:onion/services/ideasServices.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/statemanagment/idea/ideasProviders.dart';
import 'package:onion/validation/setupIdeaValidation.dart';
import 'package:onion/widgets/DropdownWidget/DropDownFormField.dart';
import 'package:onion/widgets/IdeaWiget/LocationWidget.dart';
import 'package:onion/widgets/MyLittleAppbar.dart';
import 'package:provider/provider.dart';

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

  TextEditingController yearController = TextEditingController();
  String token;
  @override
  void initState() {
    token = Provider.of<Auth>(context, listen: false).token;
    print(
        "setub idea ${Provider.of<Auth>(context, listen: false).currentUser.setupIdea}");
    if (Provider.of<Auth>(context, listen: false).currentUser.setupIdea ==
        true) {
      Navigator.of(context).pushNamed(PostIdea.routeName);
    }
    addField();
    super.initState();
  }

  bool _autoValidate = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  IdeasProvider ideasProvider;
  @override
  Widget build(BuildContext context) {
    final validationService = Provider.of<SetupIdeaValidation>(context);
    ideasProvider = Provider.of<IdeasProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
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
            // autovalidate: _autoValidate,
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
                                : "Industry",
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
                              {"display": 'Industry', "value": 'Industry'},
                              {"display": 'Technalogy', "value": 'Technalogy'},
                              {"display": 'Learning', "value": 'Learning'},
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(
                                        2), // for mobile
                                  ],
                                  keyboardType: TextInputType.number,
                                  controller: yearController,
                                  style: TextStyle(
                                    color: Colors.purple,
                                  ),
                                  // validator: (value) {
                                  //   if (value.isEmpty)
                                  //     return "Your Yeaer is empty";
                                  //   if (value.length > 0)
                                  //     return "Your Year is invalid";
                                  //   return null;
                                  // },
                                  onSaved: (value) {
                                    formIdea.experienceYear = value;
                                  },
                                  onChanged: (value) {
                                    validationService.changeYear(value);
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Year",
                                    errorText: validationService.year.error,
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
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(
                                        2), // for mobile
                                  ],
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    color: Colors.purple,
                                  ),
                                  onChanged: (value) {
                                    validationService.changeMonth(value);
                                  },
                                  validator: (value) {
                                    if (value.isEmpty)
                                      return "Your Month is empty";
                                    if (value.length > 2)
                                      return "Your Month is invalid";
                                  },
                                  onSaved: (value) {
                                    formIdea.experienceMonth = value;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Month",
                                    errorText: validationService.month.error,
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
                            inputFormatters: [
                              new LengthLimitingTextInputFormatter(
                                  5), // for mobile
                            ],
                            onSaved: (value) {
                              formIdea.teamSize = int.parse(value);
                            },
                            onChanged: (value) {
                              validationService.changeTeamSize(value);
                            },
                            decoration: InputDecoration(
                              hintText: "Team Size",
                              errorText: validationService.teamSize.error,
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
                          // ListSuggestion(),
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
                            onChanged: (value) {
                              validationService.changeAbout(value);
                            },
                            onSaved: (value) {
                              // user.occupation = value;
                              formIdea.aboutBusinnes = value;
                            },
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: "About Your Business",
                              errorText: validationService.about.error,
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
                              formIdea.website = value;
                            },
                            inputFormatters: [
                              new LengthLimitingTextInputFormatter(
                                  25), // for mobile
                            ],
                            onChanged: (value) =>
                                validationService.changeWebsite(value),
                            decoration: InputDecoration(
                              hintText: "WebSite",
                              errorText: validationService.website.error,
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
                              onPressed: () {
                                addIdeaSetup(context);
                              },
                              child: loading == false
                                  ? Text(
                                      "Add Your Idea Setup",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  : SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator(),
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

  bool loading = false;
  void addIdeaSetup(context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _controllers.forEach((TextEditingController controller) {
        formIdea.location.add("${controller.text}");
      });
      print(
          "//////////////////////////////////////////////////////////////////////////////////////////");
      print(formIdea.sendMap());
      print(
          "//////////////////////////////////////////////////////////////////////////////////////////");
      setState(() {
        loading = true;
      });
      ideasProvider.setupIdea(formIdea.sendMap(), token).then((bool status) {
        if (status == true) {
          setState(() {
            loading = false;
          });
          Navigator.pushNamed(
            context,
            PostIdea.routeName,
            // arguments: {
            //   "category": formIdea.category,
            //   "experienceYear": formIdea.experienceYear,
            //   "experienceMonth": formIdea.experienceMonth,
            //   "teamSize": formIdea.teamSize.toString(),
            //   "location": formIdea.location.toString(),
            //   "aboutYourBusiness": formIdea.aboutBusinnes,
            //   "website": formIdea.website,
            // },
          );
        } else {
          setState(() {
            loading = false;
          });
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Something went wrong!! Please try again."),
            backgroundColor: Colors.red,
          ));
        }
      }).catchError((e) {
        setState(() {
          loading = false;
        });
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Something went wrong!! Please try again."),
          backgroundColor: Colors.red,
        ));
      });
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}

class ListLocation extends StatefulWidget {
  @override
  _ListLocationState createState() => _ListLocationState();
}

class _ListLocationState extends State<ListLocation> {
  GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];

  @override
  void initState() {
    String apiKey = "AIzaSyANhuhlGahkeWvVIdJvjDu7gfTfMkoTbWk";
    googlePlace = GooglePlace(apiKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(right: 20, left: 20, top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: "Search",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black54,
                      width: 2.0,
                    ),
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    autoCompleteSearch(value);
                  } else {
                    if (predictions.length > 0 && mounted) {
                      setState(() {
                        predictions = [];
                      });
                    }
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: predictions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          Icons.pin_drop,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(predictions[index].description),
                      onTap: () {
                        debugPrint(predictions[index].placeId);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(
                              placeId: predictions[index].placeId,
                              googlePlace: googlePlace,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Image.asset("assets/powered_by_google.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions;
      });
    }
  }
}

class DetailsPage extends StatefulWidget {
  final String placeId;
  final GooglePlace googlePlace;

  DetailsPage({Key key, this.placeId, this.googlePlace}) : super(key: key);

  @override
  _DetailsPageState createState() =>
      _DetailsPageState(this.placeId, this.googlePlace);
}

class _DetailsPageState extends State<DetailsPage> {
  final String placeId;
  final GooglePlace googlePlace;

  _DetailsPageState(this.placeId, this.googlePlace);

  DetailsResult detailsResult;
  List<Uint8List> images = [];

  @override
  void initState() {
    getDetils(this.placeId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        backgroundColor: Colors.blueAccent,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          getDetils(this.placeId);
        },
        child: Icon(Icons.refresh),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(right: 20, left: 20, top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 250,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.memory(
                            images[index],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child: Text(
                          "Details",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      detailsResult != null && detailsResult.types != null
                          ? Container(
                              margin: EdgeInsets.only(left: 15, top: 10),
                              height: 50,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: detailsResult.types.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Chip(
                                      label: Text(
                                        detailsResult.types[index],
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: Colors.blueAccent,
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container(),
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.location_on),
                          ),
                          title: Text(
                            detailsResult != null &&
                                    detailsResult.formattedAddress != null
                                ? 'Address: ${detailsResult.formattedAddress}'
                                : "Address: null",
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.location_searching),
                          ),
                          title: Text(
                            detailsResult != null &&
                                    detailsResult.geometry != null &&
                                    detailsResult.geometry.location != null
                                ? 'Geometry: ${detailsResult.geometry.location.lat.toString()},${detailsResult.geometry.location.lng.toString()}'
                                : "Geometry: null",
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.timelapse),
                          ),
                          title: Text(
                            detailsResult != null &&
                                    detailsResult.utcOffset != null
                                ? 'UTC offset: ${detailsResult.utcOffset.toString()} min'
                                : "UTC offset: null",
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.rate_review),
                          ),
                          title: Text(
                            detailsResult != null &&
                                    detailsResult.rating != null
                                ? 'Rating: ${detailsResult.rating.toString()}'
                                : "Rating: null",
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.attach_money),
                          ),
                          title: Text(
                            detailsResult != null &&
                                    detailsResult.priceLevel != null
                                ? 'Price level: ${detailsResult.priceLevel.toString()}'
                                : "Price level: null",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 10),
                child: Image.asset("assets/powered_by_google.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getDetils(String placeId) async {
    var result = await this.googlePlace.details.get(placeId);
    if (result != null && result.result != null && mounted) {
      setState(() {
        detailsResult = result.result;
        images = [];
      });

      if (result.result.photos != null) {
        for (var photo in result.result.photos) {
          getPhoto(photo.photoReference);
        }
      }
    }
  }

  void getPhoto(String photoReference) async {
    var result = await this.googlePlace.photos.get(photoReference, null, 400);
    if (result != null && mounted) {
      setState(() {
        images.add(result);
      });
    }
  }
}
