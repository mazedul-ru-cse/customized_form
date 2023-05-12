import 'package:flutter/material.dart';

import '../static_variable/store_form_data.dart';

//This widget provide the radio button field
class RadioButtonField extends StatefulWidget {
  const RadioButtonField({Key? key, required this.fieldName}) : super(key: key);

  final String fieldName;

  @override
  State<RadioButtonField> createState() => _RadioButtonFieldState();
}

class _RadioButtonFieldState extends State<RadioButtonField> {

  RadioButtonValue radio = RadioButtonValue.yes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(

        children: [

          Text(widget.fieldName),

          Flexible(
            flex: 2,
            child: ListTile(
              title: const Text('Yes'),
              leading: Radio(
                value: RadioButtonValue.yes,
                groupValue: radio,
                onChanged: (value) {
                  setState(() {
                    radio = value!;
                    StoreFromData.formInfo.addAll({widget.fieldName:"Yes"});
                  });
                },
              ),
            ),
          ),

          Flexible(
            flex: 2,
            child: ListTile(
              title: const Text('No'),
              leading: Radio(
                value: RadioButtonValue.no,
                groupValue: radio,
                onChanged: (value) {
                  setState(() {
                    radio = value!;
                    StoreFromData.formInfo.addAll({widget.fieldName:"No"});
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum RadioButtonValue { yes, no }
