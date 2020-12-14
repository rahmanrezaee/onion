import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onion/pages/Dashborad/dashborad.dart';
import 'package:onion/pages/Idea/MyIdeaDetailes.dart';
import 'package:onion/pages/analysisList/analysisList.dart';
import 'package:onion/pages/franchises/RequestOnFranchise.dart';
import 'package:onion/pages/franchises/addFranchise.dart';
import 'package:onion/pages/franchises/myFranchises.dart';
import 'package:onion/pages/profile/profile_page.dart';
import 'package:onion/pages/rating/RatingPage.dart';
import 'package:onion/pages/viewRating.dart';
import 'package:onion/statemanagment/RatingProvider.dart';
import 'package:onion/statemanagment/SaveAnalModel.dart';
import 'package:onion/statemanagment/analysis_provider.dart';
import 'package:onion/statemanagment/dropdown_provider.dart';
import 'package:onion/statemanagment/franchise_provider.dart';
import 'package:onion/utilities/Connectivity/ConnectionStatusSingleton.dart';
import 'package:onion/validation/postIdeaValidation.dart';
import 'package:onion/validation/setupIdeaValidation.dart';
import 'package:onion/validation/signup_validation.dart';
import 'package:onion/pages/franchises/requestFranchisesUser.dart';
import 'package:onion/pages/franchises/viewFranchisesUser.dart';
import 'package:onion/widgets/test.dart';
import 'package:provider/provider.dart';

import './pages/Idea/MyIdeaDetailes.dart';
import './pages/franchises/RequestOnFranchise.dart';
import './pages/franchises/requestFranchisesUser.dart';
import './pages/franchises/viewFranchisesUser.dart';
import './test.dart';
import './pages/franchises/RequestOnFranchise.dart';
import './pages/underDevelopment.dart';
import './pages/Home.dart';
import './pages/Idea/postIdea.dart';
import './pages/Idea/MyIdeaId.dart';
import './pages/authentication/ComplateProfile.dart';
import './pages/Settings.dart';
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
import './pages/AnalyticsOne.dart';
import './pages/CustomDrawerPage.dart';
import './pages/Analysis.dart';
import './pages/request.dart';
import 'pages/franchises/ViewMyRequestFranchise.dart';
import './widgets/bottom_nav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ConnectivityAppWrapper(
    app: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DrawerScaffold()),
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => SignupValidation()),
        ChangeNotifierProvider(create: (_) => PostIdeaValidation()),
        ChangeNotifierProvider(create: (_) => SetupIdeaValidation()),
        ChangeNotifierProvider(create: (_) => AnalysisProvider()),
        ChangeNotifierProvider(create: (_) => DropdownProvider()),
        ChangeNotifierProxyProvider<Auth, SaveAnalProvider>(
            update: (
              context,
              auth,
              previousMessages,
            ) =>
                SaveAnalProvider(auth),
            create: (
              context,
            ) =>
                SaveAnalProvider(null)),
        ChangeNotifierProxyProvider<Auth, RatingProvider>(
            update: (
              context,
              auth,
              previousMessages,
            ) =>
                RatingProvider(auth),
            create: (
              context,
            ) =>
                RatingProvider(null)),
        ChangeNotifierProxyProvider<Auth, FranchiesProvider>(
            update: (
              context,
              auth,
              previousMessages,
            ) =>
                FranchiesProvider(auth),
            create: (
              context,
            ) =>
                FranchiesProvider(null)),
      ],
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    Provider.of<Auth>(context, listen: false).tryAutoLogin();

    return Consumer<Auth>(
      builder: (ctx, auth, _) {
        var myFranchises = MyFranchises;
        return MaterialApp(
          title: 'Onion.ai',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Color(0xFF7B3C8A),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            }),
            textTheme: TextTheme(
              headline6: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
              headline5: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              headline4: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600),
              headline3: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              headline2: TextStyle(fontSize: 19.0, fontWeight: FontWeight.w700),
              headline1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800),
              bodyText2: TextStyle(color: Colors.black54),
            ),
          ),
          home: CustomDrawerPage(key),
          routes: {
            Login.routeName: (context) => auth.token != null
                ? CustomDrawerPage(key)
                : FutureBuilder(
                    future: Provider.of<Auth>(context, listen: false)
                        .tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? Scaffold(
                                body: Center(child: Text("Loading...")),
                              )
                            : Login(),
                  ),
            MyIdeaId.routeName: (context) => MyIdeaId(),
            AnalysisList.routeName: (context) => AnalysisList(),
            ProfilePage.routeName: (context) => ProfilePage(),
            RequestOnFranchise.routeName: (context) => RequestOnFranchise(),
            SignUp.routeName: (context) =>
                auth.token != null ? CustomDrawerPage(key) : SignUp(),
            ComplateProfile.routeName: (context) =>
                auth.token != null ? CustomDrawerPage(key) : ComplateProfile(),
            CustomDrawerPage.routeName: (context) => CustomDrawerPage(key),
            AnalyticsOne.routeName: (context) => AnalyticsOne(),
            Analysis.routeName: (context) => Analysis(),
            RequestedIdeaPage.routeName: (context) => RequestedIdeaPage(),
            ForgetPassword.routeName: (context) =>
                auth.token != null ? CustomDrawerPage(key) : ForgetPassword(),
            ChangePassword.routeName: (context) => auth.token != null
                ? CustomDrawerPage(key)
                : ChangePassword(
                    ModalRoute.of(context).settings.arguments,
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
            Settings.routeName: (context) => Settings(),
            RequestFranchisesUser.routeName: (context) =>
                RequestFranchisesUser(),
            ViewFranchisesUser.routeName: (context) => ViewFranchisesUser(
                  ModalRoute.of(context).settings.arguments,
                ),
            MyIdeaId.routeName: (context) => MyIdeaId(),
            // MyIdeaDetails.routeName: (context) => MyIdeaDetails( ModalRoute.of(context).settings.arguments,),
            // ViewMyRequestFranchise.routeName: (context) => ViewMyRequestFranchise( ),
            RequestPage.routeName: (context) => RequestPage(),
            RatingPage.routeName: (context) => RatingPage(),
            MyFranchises.routeName: (context) => MyFranchises(),
            AddFranchise.routeName: (context) => AddFranchise(),
          },
          onUnknownRoute: (settings) {
            return MaterialPageRoute(builder: (_) => UnderDevelopment());
          },
        );
      },
    );
  }
}
