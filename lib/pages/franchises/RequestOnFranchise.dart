import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:onion/models/FranchiesModel.dart';
import 'package:onion/models/requestFranchiesModel.dart';
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
    var franchRequest = Provider.of<FranchiesProvider>(context, listen: false);
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
          child: Column(
            children: [
              Description(),
              FutureBuilder(
                future: franchRequest
                    .getReqestedFrenchies(widget.franchiesModel.id),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    List<RequestFranchiesModel> dat = snapshot.data;

                    return dat.isEmpty
                        ? ListView(
                            children: [
                              Container(
                                height: 80,
                                alignment: Alignment.center,
                                child: Text("Empty List"),
                              ),
                            ],
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: dat.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CardListItem(dat[index]);
                            },
                          );
                    // return Column(
                    //   children: [
                    //

                    //   ],
                    // );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Center(child: Text("Head Problem Try Again"));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
