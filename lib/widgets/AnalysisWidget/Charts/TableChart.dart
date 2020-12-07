import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:onion/models/tableSatatis.dart';

class TableChart extends StatelessWidget {

  
  List<TableSatatis> value;

  TableChart(this.value);
  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.transparent),
      children: [
        TableRow(children: [
          Card(
              elevation: 0,
              child: Text(
                'Days/per',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              )),
          Card(
              elevation: 0,
              child: Text(
                'C',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              )),
          Card(
              elevation: 0,
              child: Text(
                'A',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              )),
          Card(
              elevation: 0,
              child: Text(
                'R',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              )),
          Card(
              elevation: 0,
              child: Text(
                'D',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )),
        ]),
        for (var item in value)
          TableRow(children: [
            Card(
                elevation: 0,
                child: Text(
                  Jiffy(DateTime.parse(item.date)).MMMd,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )),
            Card(
                elevation: 0,
                child: Text(
                  item.confiromed.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )),
            Card(
                elevation: 0,
                child: Text(
                  item.actived.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )),
            Card(
                elevation: 0,
                child: Text(
                  item.recovered.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )),
            Card(
                elevation: 0,
                child: Text(
                  item.death.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ]),
      ],
    );
  }
}
