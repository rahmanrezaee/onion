import 'package:flutter/material.dart';
import 'package:onion/pages/Idea/MyIdeaDetailes.dart';
import 'package:onion/pages/Idea/MyIdeaId.dart';
import './pages/Settings.dart';
import './statemanagment/dropDownItem/MyFlagState.dart';
//Pages
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
import './pages/RequestedIdeaPage.dart';
import './pages/AnalyticsOne.dart';
import './pages/CustomDrawerPage.dart';
import './pages/franchises/requestFranchisesUser.dart';
import './pages/franchises/viewFranchisesUser.dart';
///////////////////////////////////////////
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:provider/provider.dart';
import './pages/Idea/MyIdeaId.dart';
import './statemanagment/DrawerScaffold.dart';
import './pages/MyMessagePage.dart';
import './pages/NotificationsList.dart';
import './pages/ProjectChat.dart';
import './statemanagment/dropDownItem/MyFlagState.dart';
import './pages/Home.dart';
import './statemanagment/dropDownItem/AnalyticsProvider.dart';
import './statemanagment/dropDownItem/CategoryProvider.dart';
import './statemanagment/dropDownItem/IndustryProvider.dart';
import './const/color.dart';
import './pages/AnalyticsOne.dart';
import './pages/CustomDrawerPage.dart';
import './pages/Analysis.dart';
import './test.dart';
import './pages/request.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ChangeNotifierProvider(create: (_) => MyFlagState()),
      ChangeNotifierProvider(create: (_) => IndustryProvider()),
      ChangeNotifierProvider(create: (_) => AnalyticsProvider()),
      ChangeNotifierProvider(create: (_) => DrawerScaffold()),
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
        home: Consumer<Auth>(
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
                      future: Provider.of<Auth>(context, listen: false)
                          .tryAutoLogin(),
                      builder: (ctx, authResultSnapshot) =>
                          authResultSnapshot.connectionState ==
                                  ConnectionState.waiting
                              ? Scaffold(
                                  body: Center(child: Text("Loading...")),
                                )
                              : Login()),
              SignUp.routeName: (context) => SignUp(),
              CustomDrawerPage.routeName: (context) => CustomDrawerPage(),
              AnalyticsOne.routeName: (context) => AnalyticsOne(),
              Analysis.routerName: (context) => Analysis(),
              RequestedIdeaPage.routeName: (context) => RequestedIdeaPage(),
              ForgetPassword.routeName: (context) => ForgetPassword(),
              SetupIdea.routeName: (context) => SetupIdea(),
              PostIdea.routeName: (context) => PostIdea(),
              ChangePassword.routeName: (context) => ChangePassword(
                    ModalRoute.of(context).settings.arguments,
                  ),
              FandQ.routeName: (context) => FandQ(),
              Services.routeName: (context) => Services(),
              Settings.routeName: (context) => Settings(),
              RequestFranchisesUser.routeName: (context) =>
                  RequestFranchisesUser(),
              ViewFranchisesUser.routeName: (context) => ViewFranchisesUser(),
              MyIdeaId.routeName: (context) => MyIdeaId(),
              MyIdeaDetails.routeName: (context) => MyIdeaDetails(),
            },
          ),
        ),
      ),
    );
  }
}
