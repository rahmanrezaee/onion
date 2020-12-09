import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';

class LocationWidget extends StatefulWidget {
  Function locationRemove;
  TextEditingController controller;
  Function valided;
  Function change;
  String hintText;
  Function save;
  bool hasLocationIcon;
  Color borderColor;

  LocationWidget({
    @required String text,
    this.change,
    this.save,
    this.hintText,
    this.controller,
    this.hasLocationIcon = true,
    this.valided,
    @required this.locationRemove,
    this.borderColor,
  });

  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  String errorText;
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              // child: SearchPlaceAutoCompleteWidget(
              //     apiKey: "AIzaSyANhuhlGahkeWvVIdJvjDu7gfTfMkoTbWk"),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: widget.controller,
                style: TextStyle(
                  color: Colors.purple,
                ),
                onSaved: this.widget.save,
                validator: this.widget.valided,
                decoration: InputDecoration(
                  hintText:
                      widget.hintText != null ? widget.hintText : "Location",
                  suffixIcon:
                      widget.hasLocationIcon ? Icon(Icons.location_on) : null,
                  errorText: errorText,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 10,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.borderColor ?? Colors.black87,
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
              onTap: widget.locationRemove,
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
