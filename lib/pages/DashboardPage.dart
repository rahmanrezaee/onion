import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';
import 'package:onion/const/color.dart';
import 'package:onion/statemanagment/SaveAnalysis.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:onion/widgets/MyAppBarContainer.dart';
import 'package:onion/widgets/MyLittleAppbar.dart';
import 'package:onion/widgets/temp_popup.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  Function openDrawer;

  DashboardPage({Key key, this.openDrawer});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final myController = TextEditingController();
  GlobalKey<FormState> _formKey;

  _formSub(BuildContext context) async {
    print("Mahdi: ${myController.text}");
    if (!_formKey.currentState.validate()) {
      return;
    }

    print("Mahdi:After ${myController.text}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _formKey = null;
    myController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String token = Provider.of<Auth>(context, listen: false).token;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: MyLittleAppbar(
          myTitle: "Dashboard",
          openDrawer: widget.openDrawer,
          hasDrawer: true,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: deviceSize(context).width * 0.02,
          vertical: deviceSize(context).height * 0.06,
        ),
        child: Column(
          children: [
            Divider(color: Colors.grey),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Saved Analysis",
                    textScaleFactor: 1.1,
                    style: TextStyle(color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      tempShowMyDialog(context: context);
                    },
                    child: Icon(
                      Icons.add_circle,
                      color: firstPurple,
                      size: deviceSize(context).height * 0.055,
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: Provider.of<SaveAnalProvider>(
                context,
                listen: false,
              ).getAnalysis(token: token),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blueAccent,
                    ),
                  );
                } else {
                  if (snapshot.error != null) {
                    return MyEmptyText(myTxt: "Error...  ");
                  } else {
                    return Consumer<SaveAnalProvider>(
                      builder: (consContext, consValue, child) {
                        print("Mahdi: analList ${consValue.items}");
                        if (consValue.items.isEmpty) {
                          return SizedBox.shrink();
                        }
                        return SizedBox(
                          height: deviceSize(context).height * 0.4,
                          child: Scrollbar(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: consValue.items.length,
                              itemBuilder: (listContext, index) {
                                return MyCardItem(
                                  id: consValue.items[index].id,
                                  analysis: consValue.items[index].title,
                                  category: consValue.items[index].category,
                                  industry: consValue.items[index].industry,
                                  region: consValue.items[index].region,
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
              },
            ),
            Divider(color: Colors.grey),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Search Users by Social",
                    textScaleFactor: 1.1,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Card(
                margin: EdgeInsets.symmetric(
                  vertical: deviceSize(context).height * 0.005,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: deviceSize(context).height * 0.03,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MySocialIcon(
                            myImg: "assets/images/facebook.png",
                          ),
                          MySocialIcon(
                            myImg: "assets/images/linkedin.png",
                          ),
                          MySocialIcon(
                            myImg: "assets/images/google_plus.png",
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: deviceSize(context).width * 0.05,
                        ),
                        child: TextFormField(
                          controller: myController,
                          textInputAction: TextInputAction.search,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val.isEmpty) {
                              return "خالی است";
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) {
                            return _formSub(context);
                          },
                          decoration: InputDecoration(
                            hintText: "Search Name",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 8.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: deviceSize(context).height * 0.01),
                      MyBtn(
                        txt: "Search Connections",
                        btnWidth: deviceSize(context).width * 0.6,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            MyBtn(
              txt: "Add a Franchise",
              btnWidth: deviceSize(context).width,
            ),
            MyBtn(
              txt: "Post and Idea",
              btnWidth: deviceSize(context).width,
            ),
            InkWell(
              child: Container(
                width: deviceSize(context).width,
                height: deviceSize(context).height * 0.05,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [firstPurple, thirdPurple],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Find User",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyBtn extends StatelessWidget {
  final String txt;
  final double btnWidth;

  const MyBtn({
    Key key,
    this.txt,
    this.btnWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: btnWidth,
      child: RaisedButton(
        elevation: 0,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: firstPurple),
        ),
        child: Text(
          "$txt",
          style: TextStyle(color: firstPurple),
        ),
        onPressed: () {},
      ),
    );
  }
}

class MySocialIcon extends StatelessWidget {
  final String myImg;

  const MySocialIcon({
    Key key,
    this.myImg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: deviceSize(context).height * 0.03,
          right: deviceSize(context).width * 0.04,
        ),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image.asset(myImg, fit: BoxFit.contain),
        ),
      ),
    );
  }
}

class MyCardItem extends StatelessWidget {
  final String category;
  final String region;
  final String industry;
  final String analysis;
  final String id;

  const MyCardItem({
    Key key,
    this.category,
    this.region,
    this.industry,
    this.analysis,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: deviceSize(context).height * 0.005,
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () async {
                Widget okButton = FlatButton(
                  child: Text("OK"),
                  onPressed: () async {
                    String token =
                        Provider.of<Auth>(context, listen: false).token;
                    Provider.of<SaveAnalProvider>(context, listen: false)
                        .deleteAnalysis(token: token, id: id);

                    Navigator.pop(context);
                  },
                );

                Widget cancelButton = FlatButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );

                // set up the AlertDialog
                AlertDialog alert = AlertDialog(
                  title: Text("Delete"),
                  content: Text("Do you want to delete this Analysis?"),
                  actions: [
                    cancelButton,
                    okButton,
                  ],
                );

                // show the dialog
                return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              },
              child: Icon(
                Icons.delete_outline,
                color: Colors.redAccent,
                size: 20,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: deviceSize(context).height * 0.025,
              horizontal: deviceSize(context).width * 0.01,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MyColRow(title: "Category", myTxt: category),
                MyColRow(title: "Region", myTxt: region),
                MyColRow(title: "Industry", myTxt: industry),
                MyColRow(title: "Analysis", myTxt: analysis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyColRow extends StatelessWidget {
  final String title;
  final String myTxt;

  const MyColRow({
    Key key,
    this.title,
    this.myTxt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: deviceSize(context).width * 0.18,
            maxWidth: deviceSize(context).width * 0.25,
          ),
          child: Text(
            "$title",
            textScaleFactor: 0.9,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: deviceSize(context).height * 0.01),
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: deviceSize(context).width * 0.18,
            maxWidth: deviceSize(context).width * 0.25,
          ),
          child: Text(
            "$myTxt",
            textScaleFactor: 0.9,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
