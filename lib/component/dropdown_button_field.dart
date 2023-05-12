import 'package:customized_form/static_variable/store_form_data.dart';
import 'package:flutter/material.dart';

class DropdownButtonField extends StatefulWidget {
  const DropdownButtonField({Key? key, required this.itemNames, required this.fieldName}) : super(key: key);

  final List<String> itemNames;
  final String fieldName;

  @override
  State<DropdownButtonField> createState() => _DropdownButtonFieldState();
}

class _DropdownButtonFieldState extends State<DropdownButtonField> {


  late String firstItem;

  @override
  void initState() {
    // TODO: implement initState
    firstItem = "Select ${widget.fieldName}";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    List<String> itemList = ["Select ${widget.fieldName}"];
    itemList.addAll(widget.itemNames);

    // return DropdownButton<String>(
    //   value: firstItem,
    //   items: itemList.map<DropdownMenuItem<String>>((String value) {
    //     return DropdownMenuItem<String>(
    //         value: value,
    //         child: Text(value));}).toList(),
    //         onChanged: (String? newValue) {
    //
    //         setState(() {
    //           firstItem = newValue!;
    //         });
    //
    //   },
    // );


    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: DropdownButtonFormField(

        isExpanded: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          border: const OutlineInputBorder(),
          labelText: widget.fieldName,
        ),
        value: firstItem,
        onChanged: (String? newValue) {
          setState(() {
            firstItem = newValue!;
            StoreFromData.formInfo.addAll({widget.fieldName : firstItem});
          });
        },

        items: itemList.map((String value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        }).toList(),

      ),
    );
  }
}
