import 'package:flutter/material.dart';

class DropDownFormField extends FormField<dynamic> {
  final String titleText;
  final String hintText;
  final bool required;
  final String errorText;
  final dynamic value;
  final padding;
  final List dataSource;
  final String textField;
  final String valueField;
  final Function onChanged;
  final bool filled;
  final bool enable;

  DropDownFormField(
      {FormFieldSetter<dynamic> onSaved,
      FormFieldValidator<dynamic> validator,
      bool autovalidate = false,
      this.titleText = 'Title',
      this.hintText = 'Select one option',
      this.required = false,
      this.errorText = 'Please select one option',
      this.value,
      this.dataSource,
      this.textField,
      this.padding,
      this.valueField,
      this.onChanged,
      this.enable = true,
      this.filled = true})
      : super(
          onSaved: onSaved,
          validator: validator,
          autovalidate: autovalidate,
          initialValue: value == '' ? null : value,
          builder: (FormFieldState<dynamic> state) {
            return InputDecorator(
              decoration: InputDecoration(
                contentPadding: padding != null ? padding: const EdgeInsets.symmetric(
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
              child: DropdownButtonHideUnderline(
                child: DropdownButton<dynamic>(
                  value: value == '' ? dataSource[0][valueField] : value,
                  onChanged: enable
                      ? (dynamic newValue) {
                          state.didChange(newValue);

                          onChanged(newValue);
                        }
                      : null,
                  items: dataSource.map((item) {
                    return DropdownMenuItem<dynamic>(
                      value: item[valueField],
                      child: Text(item[textField]),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        );
}
