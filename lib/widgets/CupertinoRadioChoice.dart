library cupertino_radio_choice;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoRadioChoice extends StatefulWidget {
  CupertinoRadioChoice(
      {@required this.choices,
      @required this.onChange,
      @required this.initialKeyValue,
      this.selectedColor = CupertinoColors.systemBlue,
      this.notBorderColor = CupertinoColors.systemBlue,
      this.notSelectedTextColor = CupertinoColors.systemBlue,
      this.selectedTextColor = CupertinoColors.systemBlue,
      this.notSelectedColor = CupertinoColors.inactiveGray,
      this.enabled = true});

  final Function onChange;
  final String initialKeyValue;
  final Map<String, String> choices;
  final Color selectedTextColor;
  final Color selectedColor;
  final Color notSelectedTextColor;
  final Color notSelectedColor;
  final Color notBorderColor;
  final bool enabled;

  @override
  _CupertinoRadioChoiceState createState() => new _CupertinoRadioChoiceState();
}

/// State of the widget
class _CupertinoRadioChoiceState extends State<CupertinoRadioChoice> {
  String _selectedKey;

  @override
  void initState() {
    super.initState();
    if (widget.choices.keys.contains(widget.initialKeyValue))
      _selectedKey = widget.initialKeyValue;
    else
      _selectedKey = widget.choices.keys.first;
  }

  Widget buildSelectionButton(String key, String value,
      {bool selected = false}) {
    return new Expanded(
        child: new RaisedButton(
            disabledColor:
                selected ? widget.selectedColor : widget.notSelectedColor,
            color: selected ? widget.selectedColor : widget.notSelectedColor,
            padding: const EdgeInsets.all(10.0),
            shape: new RoundedRectangleBorder( side: BorderSide(
                color: widget.notBorderColor, width: 1, style: BorderStyle.solid),borderRadius: BorderRadius.circular(5)),
            child: new Text(value,style: TextStyle(color: selected ? widget.selectedTextColor : widget.notSelectedTextColor,)),
            onPressed: !widget.enabled || selected
                ? null
                : () {
                    setState(() {
                      _selectedKey = key;
                    });

                    widget.onChange(_selectedKey);
                  }));
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> buttonList = [];
    for (var key in widget.choices.keys) {
      buttonList.add(buildSelectionButton(key, widget.choices[key],
          selected: _selectedKey == key));
    }
    return new Wrap(
      children: buttonList,
      spacing: 10.0,
      runSpacing: 5.0,
    );
  }
}
