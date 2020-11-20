import 'package:flutter/material.dart';

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          autovalidate: _autoValidate,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (value.length == 4 && int.parse(value) > 2500 ||
                      int.parse(value) < 1950) return "Your Year is Invalid";
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (value.length == 4 && int.parse(value) > 2500 ||
                      int.parse(value) < 1950) return "Your Year is Invalid";
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (value.length == 4 && int.parse(value) > 2500 ||
                      int.parse(value) < 1950) return "Your Year is Invalid";
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (value.length == 4 && int.parse(value) > 2500 ||
                      int.parse(value) < 1950) return "Your Year is Invalid";
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
                    } else {
                      setState(() {
                        _autoValidate = true;
                      });
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
