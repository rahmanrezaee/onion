import 'package:flutter/material.dart';
import 'package:onion/widgets/MyLittleAppbar.dart';

class SendInvRequest extends StatelessWidget {
  static const routeName = "send_inv_request";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: MyLittleAppbar(myTitle: "Send Investing Request"),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
