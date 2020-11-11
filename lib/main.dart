import 'package:flutter/material.dart';
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
import 'package:onion/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import './statemanagment/dropDownItem/AnalyticsProvider.dart';
import './statemanagment/dropDownItem/CategoryProvider.dart';
import './statemanagment/dropDownItem/IndustryProvider.dart';
import './pages/RequestedIdeaPage.dart';
import './pages/AnalyticsOne.dart';
import './pages/CustomDrawerPage.dart';
import './const/color.dart';
import './pages/Analysis.dart';
import './test.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ChangeNotifierProvider(create: (_) => MyFlagState()),
      ChangeNotifierProvider(create: (_) => IndustryProvider()),
      ChangeNotifierProvider(create: (_) => AnalyticsProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) =>
            MaterialApp(
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
                Login.routeName: (context) =>
                auth.token != null
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
                ChangePassword.routeName: (context) =>
                    ChangePassword(
                      ModalRoute
                          .of(context)
                          .settings
                          .arguments,
                    ),
                FandQ.routeName: (context) => FandQ(),
                Services.routeName: (context) => Services(),
              },
            ),
      ),
    );
  }
}
