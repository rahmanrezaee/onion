import 'package:flutter/material.dart';
import 'package:onion/const/Size.dart';

class MyCardItem extends StatelessWidget {
  final String category;
  final String region;
  final String industry;
  final String analysis;
  final String id;
  final onDelete;

  const MyCardItem({
    Key key,
    this.category,
    this.region,
    this.industry,
    this.onDelete,
    this.analysis,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: deviceSize(context).height * 0.005,
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () async {
                Widget okButton = FlatButton(
                  child: Text("OK"),
                  onPressed: () async {
                    onDelete(id);

                    Navigator.pop(context);
                  },
                );

                Widget cancelButton = FlatButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );

                // set up the AlertDialog
                AlertDialog alert = AlertDialog(
                  title: Text("Delete"),
                  content: Text("Do you want to delete this Analysis?"),
                  actions: [
                    cancelButton,
                    okButton,
                  ],
                );

                // show the dialog
                return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              },
              child: Icon(
                Icons.delete_outline,
                color: Colors.redAccent,
                size: 20,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: deviceSize(context).height * 0.025,
              horizontal: deviceSize(context).width * 0.01,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MyColRow(title: "Category", myTxt: category),
                MyColRow(title: "Region", myTxt: region),
                MyColRow(title: "Industry", myTxt: industry),
                MyColRow(title: "Analysis", myTxt: analysis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyColRow extends StatelessWidget {
  final String title;
  final String myTxt;

  const MyColRow({
    Key key,
    this.title,
    this.myTxt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: deviceSize(context).width * 0.18,
            maxWidth: deviceSize(context).width * 0.25,
          ),
          child: Text(
            "$title",
            textScaleFactor: 0.8,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: deviceSize(context).height * 0.01),
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: deviceSize(context).width * 0.18,
            maxWidth: deviceSize(context).width * 0.25,
          ),
          child: Text(
            "$myTxt",
            textScaleFactor: 0.8,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}

class SalesData {
  SalesData(
      this.date, this.year, this.sales, this.sales1, this.sales2, this.sales3);
  int date;
  final double year;
  final double sales;
  final double sales1;
  final double sales2;
  final double sales3;
}
