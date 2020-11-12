import 'package:flutter/material.dart';
import 'package:onion/pages/Idea/MyIdeaId.dart';
import 'package:onion/pages/authentication/ComplateProfile.dart';
import 'package:onion/pages/Settings.dart';
import 'package:onion/statemanagment/dropDownItem/MyFlagState.dart';

import 'package:onion/pages/Home.dart';
import 'package:onion/pages/HomeAfterLogin.dart';
import 'package:onion/pages/Idea/postIdea.dart';
import 'package:onion/pages/F&Q.dart';
import 'package:onion/pages/Services.dart';
import 'package:onion/pages/Idea/setupIdea.dart';
import 'package:onion/pages/RequestedIdeaPage.dart';
import 'package:onion/pages/authentication/ChangePassword.dart';
import 'package:onion/pages/authentication/ForgetPassword.dart';
import 'package:onion/pages/authentication/Login.dart';
import 'package:onion/pages/authentication/signup.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:provider/provider.dart';

import './pages/MyMessagePage.dart';
import './pages/NotificationsList.dart';
import './pages/ProjectChat.dart';
import './statemanagment/dropDownItem/MyFlagState.dart';
import './pages/Home.dart';
import './pages/HomeAfterLogin.dart';
import './pages/Idea/postIdea.dart';
import './pages/F&Q.dart';
import './pages/Services.dart';
import './pages/Idea/setupIdea.dart';
import './pages/RequestedIdeaPage.dart';
import './pages/authentication/ChangePassword.dart';
import './pages/authentication/ForgetPassword.dart';
import './pages/authentication/Login.dart';
import './pages/authentication/signup.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import './statemanagment/dropDownItem/AnalyticsProvider.dart';
import './statemanagment/dropDownItem/CategoryProvider.dart';
import './statemanagment/dropDownItem/IndustryProvider.dart';
import './pages/RequestedIdeaPage.dart';
import './pages/AnalyticsOne.dart';
import './pages/CustomDrawerPage.dart';
import './const/color.dart';
import './pages/Analysis.dart';
import './test.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ChangeNotifierProvider(create: (_) => MyFlagState()),
      ChangeNotifierProvider(create: (_) => IndustryProvider()),
      ChangeNotifierProvider(create: (_) => AnalyticsProvider()),
      ChangeNotifierProvider(create: (_) => Auth()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (ctx, auth, _) => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF7B3C8A),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          }),
        ),
        home: CustomDrawerPage(),
        routes: {
          Login.routeName: (context) => auth.token != null
              ? CustomDrawerPage()
              : FutureBuilder(
                  future:
                      Provider.of<Auth>(context, listen: false).tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? Scaffold(
                              body: Center(child: Text("Loading...")),
                            )
                          : Login(),
                ),
          MyIdeaId.routeName: (context) => MyIdeaId(),
          SignUp.routeName: (context) => auth.token != null
              ? CustomDrawerPage()
              : FutureBuilder(
                  future:
                      Provider.of<Auth>(context, listen: false).tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? Scaffold(
                              body: Center(child: Text("Loading...")),
                            )
                          : SignUp(),
                ),
          ComplateProfile.routeName: (context) => auth.token != null
              ? CustomDrawerPage()
              : FutureBuilder(
                  future:
                      Provider.of<Auth>(context, listen: false).tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? Scaffold(
                              body: Center(child: Text("Loading...")),
                            )
                          : ComplateProfile(ModalRoute.of(context).settings.arguments,),
                ),
          CustomDrawerPage.routeName: (context) => CustomDrawerPage(),
          AnalyticsOne.routeName: (context) => AnalyticsOne(),
          Analysis.routerName: (context) => Analysis(),
          RequestedIdeaPage.routeName: (context) => RequestedIdeaPage(),
          ForgetPassword.routeName: (context) => auth.token != null
              ? CustomDrawerPage()
              : FutureBuilder(
                  future:
                      Provider.of<Auth>(context, listen: false).tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? Scaffold(
                              body: Center(child: Text("Loading...")),
                            )
                          : ForgetPassword(),
                ),
          ChangePassword.routeName: (context) => auth.token != null
              ? CustomDrawerPage()
              : FutureBuilder(
                  future:
                      Provider.of<Auth>(context, listen: false).tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? Scaffold(
                              body: Center(child: Text("Loading...")),
                            )
                          : ChangePassword(
                              ModalRoute.of(context).settings.arguments,
                            ),
                ),
          SetupIdea.routeName: (context) => SetupIdea(),
          PostIdea.routeName: (context) => PostIdea(),
          ProjectChat.routeName: (context) => ProjectChat(),
          MyMessagePage.routeName: (context) => MyMessagePage(),
          NotificationsList.routeName: (context) => NotificationsList(),
          PostIdea.routeName: (context) => PostIdea(),
          FandQ.routeName: (context) => FandQ(),
          Services.routeName: (context) => Services(),
        },
      ),
    );
  }
}
