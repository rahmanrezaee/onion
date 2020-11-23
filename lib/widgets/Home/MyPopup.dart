import 'package:onion/pages/Analysis.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:onion/widgets/AnalysisWidget/MyBigDropDown.dart';
import '../../const/Size.dart';
import '../../const/color.dart';
import '../../statemanagment/dropDownItem/AnalyticsProvider.dart';
import '../../statemanagment/dropDownItem/CategoryProvider.dart';
import '../../statemanagment/dropDownItem/IndustryProvider.dart';
import '../AnalysisWidget/MySmallDropdown.dart';

import '../MyAppBarContainer.dart';

Future<void> showMyDialog({@required BuildContext context}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.only(
          bottom: deviceSize(context).height * 0.03,
        ),
        titlePadding: EdgeInsets.zero,
        content: DialogContent(),
      );
    },
  );
}

class DialogContent extends StatefulWidget {
  const DialogContent({
    Key key,
  }) : super(key: key);

  @override
  _DialogContentState createState() => _DialogContentState();
}

class _DialogContentState extends State<DialogContent> {
  Future<void> fetchCategory;
  List<CategoryModel> countryList = [
    CategoryModel(
      name: "USA",
      parent: "Hello",
      createdAt: "1398/9/9",
      id: "1",
    ),
    CategoryModel(
      name: "Iraq",
      parent: "Hello",
      createdAt: "1398/9/9",
      id: "2",
    ),
    CategoryModel(
      name: "Iran",
      parent: "Hello",
      createdAt: "1398/9/9",
      id: "3",
    ),
    CategoryModel(
      name: "Afghanistan",
      parent: "Hello",
      createdAt: "1398/9/9",
      id: "4",
    ),
  ];
  bool isCatLoading = true;
  bool isAnaLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchCategory = Provider.of<CategoryProvider>(
      context,
      listen: false,
    ).fetchItems(context).then((value) {
      isCatLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.cancel_outlined,
                color: middlePurple,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: deviceSize(context).height * 0.02,
              right: deviceSize(context).width * 0.03,
              left: deviceSize(context).width * 0.03,
            ),
            child: Column(
              children: [
                Text(
                  'Let us know what all analytics you are intrested in?',
                  textScaleFactor: 1,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: deviceSize(context).height * 0.03),
                Consumer<CategoryProvider>(
                  builder: (
                    BuildContext consContext,
                    value,
                    Widget child,
                  ) {
                    if (value.items.isEmpty) {
                      print("Mahdia IF ");
                      return MyEmptyText(
                        myTxt: value.isLoading ? "loading..." : "Empty",
                      );
                    } else {
                      print("Mahdia Else ");
                      // return Text("Mahdi");
                      return MySmallDropdown(
                        iconColor: Colors.black,
                        myisExpanded: true,
                        myDropDownList: value.items,
                        dropDownAroundColor: Colors.grey,
                        txtColor: Colors.grey,
                        dropDownColor: Colors.white,
                        futureType: "category",
                        firstVal: value.items[0].name,
                      );
                    }
                  },
                ),
                SizedBox(height: deviceSize(context).height * 0.03),
                Consumer<IndustryProvider>(
                  builder: (
                    BuildContext consContext,
                    value,
                    Widget child,
                  ) {
                    if (value.items.isEmpty) {
                      print("Mahdia IF ");
                      return MyEmptyText(
                        myTxt: value.isLoading ? "loading..." : "Empty",
                      );
                    } else {
                      print("Mahdia Else ");
                      // return Text("Mahdi");
                      return MySmallDropdown(
                        iconColor: Colors.black,
                        myisExpanded: true,
                        myDropDownList: value.items,
                        dropDownAroundColor: Colors.grey,
                        txtColor: Colors.grey,
                        dropDownColor: Colors.white,
                        firstVal: value.items[0].name,
                        futureType: "industry",
                      );
                    }
                  },
                ),
                SizedBox(height: deviceSize(context).height * 0.03),
                Consumer<AnalyticsProvider>(
                  builder: (
                    BuildContext consContext,
                    value,
                    Widget child,
                  ) {
                    if (value.items.isEmpty) {
                      return MyPopTxt(
                        myTxt: value.isLoading ? "loading..." : "Empty",
                      );
                    } else {
                      print("Mahdia Else ");
                      // return Text("Mahdi");
                      return MySmallDropdown(
                        iconColor: Colors.black,
                        myisExpanded: true,
                        myDropDownList: value.items,
                        dropDownAroundColor: Colors.grey,
                        txtColor: Colors.grey,
                        dropDownColor: Colors.white,
                        firstVal: value.items[0].name,
                        futureType: "analytics",
                      );
                    }
                  },
                ),
                SizedBox(height: deviceSize(context).height * 0.03),
                MySmallDropdown(
                  iconColor: Colors.black,
                  myisExpanded: true,
                  myDropDownList: countryList,
                  dropDownAroundColor: Colors.grey,
                  txtColor: Colors.grey,
                  dropDownColor: Colors.white,
                  firstVal: countryList[0].name,
                  futureType: "country",
                ),
                SizedBox(height: deviceSize(context).height * 0.01),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: middlePurple,
                    textColor: Colors.white,
                    elevation: 0,
                    child: Text("Save"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: middlePurple),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigator.pushNamed(context, Analysis.routeName);
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.white,
                    elevation: 0,
                    textColor: middlePurple,
                    child: Text("Manage Analytics"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: middlePurple),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyPopTxt extends StatelessWidget {
  final String myTxt;

  const MyPopTxt({
    Key key,
    this.myTxt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceSize(context).width * 0.8,
      padding: EdgeInsets.all(deviceSize(context).width * 0.02),
      margin: EdgeInsets.symmetric(
        horizontal: deviceSize(context).width * 0.01,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: SizedBox(
        width: deviceSize(context).width * 0.19,
        child: Text(
          myTxt,
          textScaleFactor: 0.8,
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}

// E:\Project\Flutter\Sobhan\NewRepositoryLast\mobile-app\android\app\src\debug\AndroidManifest.xml:24:9-31:50 Warning:
// [   +3 ms]      activity#com.google.firebase.auth.internal.FederatedSignInActivity@android:launchMode was tagged at
// AndroidManifest.xml:24 to replace other declarations but no other declaration present
// [   +6 ms] Note: Some input files use unchecked or unsafe operations.
// [   +4 ms] Note: Recompile with -Xlint:unchecked for details.
// [        ] Note: Some input files use or override a deprecated API.
// [        ] Note: Recompile with -Xlint:deprecation for details.
// [        ] WARNING: Compatible side by side NDK version was not found. Default is 21.0.6113669.
// [        ] Compatible side by side NDK version was not found. Default is 21.0.6113669.
// [+3299 ms] Unable to strip the following libraries, packaging them as they are: libflutter.so.
// [  +99 ms] Deprecated Gradle features were used in this build, making it incompatible with Gradle 7.0.
// [   +1 ms] Use '--warning-mode all' to show the individual deprecation warnings.
// [        ] See https://docs.gradle.org/6.1.1/userguide/command_line_interface.html#sec:command_line_warnings
// [        ] BUILD SUCCESSFUL in 3m 4s
// [        ] 354 actionable tasks: 314 executed, 40 up-to-date
// [ +424 ms] Running Gradle task 'assembleDebug'... (completed in 186.1s, longer than expected)
// [ +128 ms] calculateSha: LocalDirectory:
// 'E:\Project\Flutter\Sobhan\NewRepositoryLast\mobile-app\build\app\outputs\flutter-apk'/app.apk
// E: queries (line=25)
// E: intent (line=26)
// E: action (line=27)
// [  +15 ms] I/flutter (16716): null
// [ +242 ms] W/ConnectionTracker(16716): Exception thrown while unbinding
// [   +3 ms] W/ConnectionTracker(16716): java.lang.IllegalArgumentException: Service not registered: lq@bcff89e
// [  +11 ms] W/ConnectionTracker(16716):  at android.app.LoadedApk.forgetServiceDispatcher(LoadedApk.java:1490)
// [  +10 ms] W/ConnectionTracker(16716):  at android.app.ContextImpl.unbindService(ContextImpl.java:1655)
// [   +1 ms] W/ConnectionTracker(16716):  at android.content.ContextWrapper.unbindService(ContextWrapper.java:716)
// [   +6 ms] W/ConnectionTracker(16716):  at
