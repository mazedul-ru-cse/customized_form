import 'package:customized_form/static_variable/static_variable.dart';
import 'package:flutter/material.dart';

/*
 This widget provide the field type dropdown
 */
class FieldTypeDropDown extends StatefulWidget {
  const FieldTypeDropDown({Key? key}) : super(key: key);

  @override
  State<FieldTypeDropDown> createState() => _FieldTypeDropDownState();
}

class _FieldTypeDropDownState extends State<FieldTypeDropDown> {
  @override
  Widget build(BuildContext context) {

    return DropdownButton<String>(
      value: StaticVariable.fieldType,
      items: <String>['Select field type','Text Field', 'Time Picker', 'Date Picker', 'DropDown','Radio button'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
            value: value,
            child: Text(value));}).toList(),
      onChanged: (String? newValue) {

        setState(() {
          StaticVariable.fieldType = newValue!;
        });

      },
    );
  }
}
