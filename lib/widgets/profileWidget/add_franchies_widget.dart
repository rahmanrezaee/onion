import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/const/color.dart';
import 'package:onion/models/FranchiesModelProfile.dart';
import 'package:onion/pages/Idea/postIdea.dart';
import 'package:onion/utilities/disabledFocusNode.dart';
import 'package:onion/widgets/DropdownWidget/DropDownFormField.dart';
import 'package:onion/widgets/IdeaWiget/LocationWidget.dart';

class AddFranchiesWidget extends StatefulWidget {
  @override
  _AddFranchiesWidgetState createState() => _AddFranchiesWidgetState();
}

class _AddFranchiesWidgetState extends State<AddFranchiesWidget> {
  bool _autoValidate = false;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = new GlobalKey<FormState>();

  FranchiesProfileModel formIdea = new FranchiesProfileModel();

  List<String> list = new List<String>();

  List<TextEditingController> _controllers = [];

  int addinput = 1;

  bool loading = false;
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
  Widget build(BuildContext context) {
    // final validationService = Provider.of<SetupFranchiesValidation>(context);
    //  String token = Provider.of<Auth>(context, listen: false).token;
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
                Padding(
                  padding: const EdgeInsets.symmetric( horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add a New Franchies",
                        textScaleFactor: 1.1,
                        style: TextStyle(color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.add_circle,
                          color: firstPurple,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
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
                        DropDownFormField(
                          value: formIdea.service != null
                              ? formIdea.service
                              : "Type Of Service",
                          onSaved: (value) {
                            setState(() {
                              formIdea.service = value;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              formIdea.service = value;
                            });
                          },
                          dataSource: [
                            {
                              "display": 'Type Of Service',
                              "value": 'Type Of Service'
                            },
                            {"display": 'Technalogy', "value": 'Technalogy'},
                            {"display": 'Learning', "value": 'Learning'},
                          ],
                          textField: 'display',
                          valueField: 'value',
                        ),
                        SizedBox(height: 10),
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
                            // validationService.changeAbout(value);
                          },
                          onSaved: (value) {
                            // user.occupation = value;
                            formIdea.aboutBusinnes = value;
                          },
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: "Summary Of Services",
                            // errorText: validationService.about.error,
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
                            // validationService.changeTeamSize(value);
                          },
                          decoration: InputDecoration(
                            hintText: "Group/Team Size",
                            // errorText: validationService.teamSize.error,
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
                            // validationService.changeYear(value);
                          },
                          decoration: InputDecoration(
                            hintText: "Year Of Experience",
                            // errorText: validationService.year.error,
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
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Project Done",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // ListSuggestion(),
                        DropDownFormField(
                          value: formIdea.service != null
                              ? formIdea.service
                              : "Type Of Service",
                          onSaved: (value) {
                            setState(() {
                              formIdea.service = value;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              formIdea.service = value;
                            });
                          },
                          dataSource: [
                            {
                              "display": 'Type Of Service',
                              "value": 'Type Of Service'
                            },
                            {"display": 'Technalogy', "value": 'Technalogy'},
                            {"display": 'Learning', "value": 'Learning'},
                          ],
                          textField: 'display',
                          valueField: 'value',
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.url,
                          style: TextStyle(
                            color: Colors.purple,
                          ),
                          validator: (value) {
                            if (value.isEmpty)
                              return "Your Project Name is empty";
                          },
                          onSaved: (value) {
                            // user.occupation = value;
                            formIdea.website = value;
                          },
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(
                                25), // for mobile
                          ],
                          onChanged: (value) {},
                          // validationService.changeWebsite(value),
                          decoration: InputDecoration(
                            hintText: "Project Name",
                            // errorText: validationService.website.error,
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
                              return "Project Job Summary empty";
                          },
                          onChanged: (value) {
                            // validationService.changeAbout(value);
                          },
                          onSaved: (value) {
                            // user.occupation = value;
                            formIdea.aboutBusinnes = value;
                          },
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: "Project Job Summary",
                            // errorText: validationService.about.error,
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                enableInteractiveSelection: false,
                                // focusNode: new AlwaysDisabledFocusNode(),
                                keyboardType: TextInputType.url,
                                style: TextStyle(
                                  color: Colors.purple,
                                ),
                                // onChanged: (value) {
                                //   validationService.changeWhitePaper(value);
                                // },
                                // validator: (value) {
                                //   if (value.isEmpty)
                                //     return "Your Upload White Paper is empty";
                                // },
                                // onSaved: (value) {
                                //   // user.occupation = value;
                                // },
                                decoration: InputDecoration(
                                  hintText: "Upload Video",
                                  // errorText:
                                  // validationService.whitePaper.error,
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
                              onPressed: () {
                                // loadWhitePaper();
                              },
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
                            onPressed: () {
                              // addIdeaSetup(context,token);
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

  void addIdeaSetup(context, token) {
    // if (_formKey.currentState.validate()) {
    //   _formKey.currentState.save();
    //   _controllers.forEach((TextEditingController controller) {
    //     formIdea.location.add("${controller.text}");
    //   });
    //   print(
    //       "//////////////////////////////////////////////////////////////////////////////////////////");
    //   print(formIdea.sendMap());
    //   print(
    //       "//////////////////////////////////////////////////////////////////////////////////////////");
    //   setState(() {
    //     loading = true;
    //   });
    //   IdeasServices().setupIdea(formIdea.sendMap(), token).then((bool status) {
    //     if (status == true) {
    //       setState(() {
    //         loading = false;
    //       });
    //       Navigator.pushNamed(
    //         context,
    //         PostIdea.routeName,
    //         // arguments: {
    //         //   "category": formIdea.category,
    //         //   "experienceYear": formIdea.experienceYear,
    //         //   "experienceMonth": formIdea.experienceMonth,
    //         //   "teamSize": formIdea.teamSize.toString(),
    //         //   "location": formIdea.location.toString(),
    //         //   "aboutYourBusiness": formIdea.aboutBusinnes,
    //         //   "website": formIdea.website,
    //         // },
    //       );
    //     } else {
    //       _scaffoldKey.currentState.showSnackBar(SnackBar(
    //         content: Text("Somthing went wrong!! Please try again."),
    //         backgroundColor: Colors.red,
    //       ));
    //     }
    //   }).catchError((e) {
    //     loading = false;
    //     _scaffoldKey.currentState.showSnackBar(SnackBar(
    //       content: Text("Somthing went wrong!! Please try again."),
    //       backgroundColor: Colors.red,
    //     ));
    //   });
    // } else {
    //   setState(() {
    //     _autoValidate = true;
    //   });
    // }
  }
}
