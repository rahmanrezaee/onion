import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:onion/models/FranchiesModel.dart';
import 'package:onion/statemanagment/franchise_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/Franchise/CardListItem.dart';
import '../../const/Size.dart';
import '../../const/color.dart';
import '../../const/values.dart';
import '../../widgets/Franchise/Discription.dart';
import '../../widgets/MyLittleAppbar.dart';

class RequestOnFranchise extends StatefulWidget {
  static const routeName = "request_on_franchise";
  FranchiesModel franchiesModel;
  RequestOnFranchise(this.franchiesModel);
  @override
  _RequestOnFranchiseState createState() => _RequestOnFranchiseState();
}

class _RequestOnFranchiseState extends State<RequestOnFranchise> {
  @override
  Widget build(BuildContext context) {

    var franchRequest = Provider.of<FranchiesProvider>(context,listen:false);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: MyLittleAppbar(
          myTitle: "Request On Franchise",
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(deviceSize(context).height * 0.01),
        child: RefreshIndicator(
          onRefresh: () async {
            // value.clearToNullList();
            // await value.getFranchies(isMyList: true);
          },
          child: FutureBuilder(
            future: franchRequest.getReqestedFrenchies(widget.franchiesModel.id),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return Column(
                children: [
                  Description(),
                  CardListItem(),
                  CardListItem(),
                  CardListItem(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
