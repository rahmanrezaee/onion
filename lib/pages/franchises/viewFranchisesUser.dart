import 'package:flutter/material.dart';
import 'package:onion/const/color.dart';
import 'package:onion/pages/CustomDrawerPage.dart';
import 'package:onion/widgets/AnalysisWidget/MyAlert.dart';

class ViewFranchisesUser extends StatelessWidget {
  static String routeName = "ViewFranchisesUser";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: middlePurple,
        title: Text("Franchise Name"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed(CustomDrawerPage.routeName);
          },
        ),
        actions: [
          IconButton(
            icon: MyAlertIcon(num: 3),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Franchise: <Franchise Name>",
                    style: TextStyle(color: firstPurple, fontSize: 18),
                  ),
                  InkWell(
                    onTap: () {},
                    child:
                        Icon(Icons.info_outline, size: 30, color: firstPurple),
                  ),
                ],
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 8.0,
                    right: 8.0,
                    bottom: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Industry: ", style: TextStyle(fontSize: 15)),
                          Text(
                            "<IndustryName>",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Brand",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black87)),
                            Text("Brand Name",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black87)),
                          ]),
                      Divider(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Location",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black87)),
                            Text("Place/Location",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black87)),
                          ]),
                      Divider(),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: deepGrey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            color: Colors.transparent,
                            child: Text("Message",
                                style: TextStyle(color: deepGrey)),
                            onPressed: () {},
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            color: middlePurple,
                            child: Text(
                              "View Profile",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Requirement Details:",
                        style: TextStyle(fontSize: 22, color: deepBlue),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Automate th eprocess of sending emails with some features based on business requirements. You can have a list of email customized addresses. Automate the process of sendign emails with customized featrues base on business..",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Upload Documents",
                        style: TextStyle(fontSize: 22, color: deepBlue),
                      ),
                      SizedBox(height: 5),
                      Wrap(
                        spacing: 20,
                        children: List.generate(
                          6,
                          (index) {
                            return InkWell(
                              onTap: () {
                                print("Will show this documents");
                              },
                              child: Icon(Icons.upload_file,
                                  size: 50, color: deepGrey),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Upload Video",
                        style: TextStyle(fontSize: 22, color: deepBlue),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          color: lightGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.slow_motion_video,
                            size: 80, color: deepBlue),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: RaisedButton(
                            color: middlePurple,
                            onPressed: () {},
                            child: Text("Request",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}