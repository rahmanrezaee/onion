import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onion/models/SetupIdea.dart';
import 'package:onion/pages/Idea/postIdea.dart';
import 'package:onion/services/ideasServices.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/validation/setupIdeaValidation.dart';
import 'package:onion/widgets/DropdownWidget/DropDownFormField.dart';
import 'package:onion/widgets/IdeaWiget/LocationWidget.dart';
import 'package:provider/provider.dart';

class SetupIdeaWidget extends StatefulWidget {
  @override
  _SetupIdeaWidgetState createState() => _SetupIdeaWidgetState();
}

class _SetupIdeaWidgetState extends State<SetupIdeaWidget> {
  bool _autoValidate = false;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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



  @override
  void initState() {
    
    addField();
    super.initState();
  }

  @override
  Widget build( context) {

      final validationService = Provider.of<SetupIdeaValidation>(context);
   String token = Provider.of<Auth>(context, listen: false).token;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: SingleChildScrollView(
        child: Form(
          // autovalidate: _autoValidate,
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(0),
            child: Column(
              children: [
                // Row(
                //   children: [
                //     Expanded(
                //         child: Text(
                //       "Build Your Profile to Post your Idea",
                //       style:
                //           TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                //     )),
                //     InkWell(
                //       child: Icon(Icons.info),
                //     )
                //   ],
                // ),
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
                            if (value.isEmpty) return "Your Team Size is empty";
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
                              addIdeaSetup(context,token);
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
    );
  }

  bool loading = false;
  void addIdeaSetup(context,token) {
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
      // IdeasServices().setupIdea(formIdea.sendMap(), token).then((bool status) {
      //   if (status == true) {
      //     setState(() {
      //       loading = false;
      //     });
      //     Navigator.pushNamed(
      //       context,
      //       PostIdea.routeName,
      //       // arguments: {
      //       //   "category": formIdea.category,
      //       //   "experienceYear": formIdea.experienceYear,
      //       //   "experienceMonth": formIdea.experienceMonth,
      //       //   "teamSize": formIdea.teamSize.toString(),
      //       //   "location": formIdea.location.toString(),
      //       //   "aboutYourBusiness": formIdea.aboutBusinnes,
      //       //   "website": formIdea.website,
      //       // },
      //     );
      //   } else {
      //     _scaffoldKey.currentState.showSnackBar(SnackBar(
      //       content: Text("Somthing went wrong!! Please try again."),
      //       backgroundColor: Colors.red,
      //     ));
      //   }
     
    } else {
      setState(() {
        _autoValidate = true;
      });
    } // }).catchError((e) {
      //   loading = false;
      //   _scaffoldKey.currentState.showSnackBar(SnackBar(
      //     content: Text("Somthing went wrong!! Please try again."),
      //     backgroundColor: Colors.red,
      //   ));
      // });
  }

  
}
