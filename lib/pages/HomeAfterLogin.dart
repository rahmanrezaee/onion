import 'package:flutter/material.dart';
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeAfterLogin extends StatefulWidget {
  @override
  _HomeAfterLoginState createState() => _HomeAfterLoginState();
}

class _HomeAfterLoginState extends State<HomeAfterLogin> {
  @override
  Widget build( context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          RaisedButton(
            onPressed: () async{
              await Provider.of<Auth>(context, listen: false).logout();
              Navigator.pushReplacementNamed(context, "/");
            },
            child: Text("logout"),
          )
        ],
      ),
    );
  }
}
