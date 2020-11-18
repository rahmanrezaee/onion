import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onion/pages/Idea/MyIdeaDetailes.dart';
import 'package:onion/pages/franchises/RequestOnFranchise.dart';
import 'package:onion/validation/postIdea.dart';
import 'package:onion/validation/signup_validation.dart';
import 'package:onion/pages/franchises/requestFranchisesUser.dart';
import 'package:onion/pages/franchises/viewFranchisesUser.dart';
import 'package:provider/provider.dart';

import './pages/franchises/RequestOnFranchise.dart';
import './pages/Home.dart';
import './pages/Idea/postIdea.dart';
import './pages/Idea/MyIdeaId.dart';
import './pages/authentication/ComplateProfile.dart';
import './pages/Settings.dart';
import './statemanagment/dropDownItem/MyFlagState.dart';
import './pages/F&Q.dart';
import './pages/Services.dart';
import './pages/Idea/setupIdea.dart';
import './pages/RequestedIdeaPage.dart';
import './pages/authentication/ChangePassword.dart';
import './pages/authentication/ForgetPassword.dart';
import './pages/authentication/Login.dart';
import './pages/authentication/signup.dart';
import './statemanagment/auth_provider.dart';
import './pages/invest/SendInvRequest.dart';
import './statemanagment/DrawerScaffold.dart';
import './pages/MyMessagePage.dart';
import './pages/NotificationsList.dart';
import './pages/ProjectChat.dart';
import './pages/Home.dart';
import './statemanagment/dropDownItem/AnalyticsProvider.dart';
import './statemanagment/dropDownItem/CategoryProvider.dart';
import './statemanagment/dropDownItem/IndustryProvider.dart';
import './pages/AnalyticsOne.dart';
import './pages/CustomDrawerPage.dart';
import './pages/Analysis.dart';
import './pages/request.dart';
import 'pages/franchises/ViewMyRequestFranchise.dart';
import './widgets/bottom_nav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ChangeNotifierProvider(create: (_) => MyFlagState()),
      ChangeNotifierProvider(create: (_) => IndustryProvider()),
      ChangeNotifierProvider(create: (_) => AnalyticsProvider()),
      ChangeNotifierProvider(create: (_) => DrawerScaffold()),
      ChangeNotifierProvider(create: (_) => Auth()),
      ChangeNotifierProvider(create: (_) => SignupValidation()),
      ChangeNotifierProvider(create: (_) => PostIdeaValidation()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<Auth>(
      context,
    ).tryAutoLogin();
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
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? Scaffold(
                              body: Center(child: Text("Loading...")),
                            )
                          : Login(),
                ),
          MyIdeaId.routeName: (context) => MyIdeaId(),
          RequestOnFranchise.routeName: (context) => RequestOnFranchise(),
          SignUp.routeName: (context) => auth.token != null
              ? CustomDrawerPage()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
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
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? Scaffold(
                              body: Center(child: Text("Loading...")),
                            )
                          : ComplateProfile(
                              ModalRoute.of(context).settings.arguments,
                            ),
                ),
          CustomDrawerPage.routeName: (context) => CustomDrawerPage(),
          AnalyticsOne.routeName: (context) => AnalyticsOne(),
          Analysis.routerName: (context) => Analysis(),
          RequestedIdeaPage.routeName: (context) => RequestedIdeaPage(),
          ForgetPassword.routeName: (context) => auth.token != null
              ? CustomDrawerPage()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
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
                  future: auth.tryAutoLogin(),
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
          SendInvRequest.routeName: (context) => SendInvRequest(),
          SetupIdea.routeName: (context) => SetupIdea(),
          PostIdea.routeName: (context) => PostIdea(),
          ProjectChat.routeName: (context) => ProjectChat(),
          MyMessagePage.routeName: (context) => MyMessagePage(),
          NotificationsList.routeName: (context) => NotificationsList(),
          PostIdea.routeName: (context) => PostIdea(),
          FandQ.routeName: (context) => FandQ(),
          Services.routeName: (context) => Services(),
          SetupIdea.routeName: (context) => SetupIdea(),
          HomePage.routeName: (context) => HomePage(),
          PostIdea.routeName: (context) => PostIdea(),
          Settings.routeName: (context) => Settings(),
        },
      ),
    );
  }
}
