import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  Function locationRemove;
  TextEditingController controller;
  Function valided;
  Function change;
  Function save;

  LocationWidget(
      {@required String text,
      this.change,
      this.save,
      this.controller,
      this.valided,
      @required this.locationRemove});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: controller,
                style: TextStyle(
                  color: Colors.purple,
                ),
                onSaved: this.save,
                validator: this.valided,
                decoration: InputDecoration(
                  hintText: "Location",
                  suffixIcon: Icon(Icons.location_on),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 10,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black87,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.purple,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            InkWell(
              onTap: locationRemove,
              child: Icon(Icons.delete),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
