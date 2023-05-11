import 'dart:developer';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:customized_form/store_form_data.dart';
import 'package:flutter/material.dart';
part 'android_form_state.dart';


class Fields {

  static List<Widget> formFields =

  [
    //Student name field
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Student name",
          labelText: "Student name*"
        ),

        onChanged: (value) => StoreFromData.formInfo.addAll({"Student Name":value}),
      ),
    ),

    //Father's name field
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Fathers' name",
            labelText: "Fathers' name*"
        ),
        onChanged: (value) => StoreFromData.formInfo.addAll({"Fathers' name":value}),
      ),
    ),

    //Mother's name field
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Mother's name",
            labelText: "Mother's name*"
        ),
        onChanged: (value) => StoreFromData.formInfo.addAll({"Mother's name":value}),
      ),
    ),
  ];
}

class AndroidFormCubit extends Cubit<AndroidFormInitial> {
  AndroidFormCubit() : super(AndroidFormInitial(formFields: Fields.formFields));

  //Add a new field in the form
  void addNewFriend(int index,BuildContext context){
    final field = state.formFields;
    field.insert(index, customField(index,context));
    emit(AndroidFormInitial(formFields: field));
  }

  //It's return a fieldName, fieldType dropdown, and two buttons
  Widget customField(int index,BuildContext context){

   String fieldType = 'Select field type';
   String fieldName = "";

   final field = state.formFields;

    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      child: Column(

       children: [

         Row(
           children: [
             Flexible(
               flex: 2,
                 child: Padding(
                   padding: const EdgeInsets.all(5.0),
                   child: Text("Field Name : "),
                 )),

             Flexible(
               flex: 4,
               child: Padding(
                 padding: const EdgeInsets.all(5.0),
                 child: TextField(
                   decoration: InputDecoration(
                   ),
                   onChanged: (value){
                     fieldName = value;
                   },
                 ),

               ),
             ),
           ],
         ),

         SizedBox(height: 10,),

         Row(
           children: [
             Flexible(
               flex: 2,
               child: Padding(
                 padding: const EdgeInsets.all(5.0),
                 child: Text("Field Type : "),
               ),
             ),

             Flexible(
               flex: 4,
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: DropdownButton<String>(
                   value: fieldType,
                   items: <String>['Select field type','Text Field', 'Time Picker', 'Date Picker', 'DropDown'].map<DropdownMenuItem<String>>((String value) {
                     return DropdownMenuItem<String>(
                       value: value,
                       child: Text(value));}).toList(),
                       onChanged: (String? newValue) {

                         fieldType = newValue!;
                       },
                 ),
               ),
             ),

           ],
         ),

         SizedBox(height: 10,),

         Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
             TextButton(onPressed: (){

               field.removeAt(index);
               emit(AndroidFormInitial(formFields: field));

             }, child: const Text("Close",style: TextStyle(color: Colors.white)),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green.shade600)),),
             TextButton(onPressed: (){


               if(fieldType.contains("Text Field")){

                 field.insert(index, getTextField(fieldName));
               }

               else if(fieldType.contains("Time Picker")){
                 field.insert(index, getTimePickerField(fieldName,context));
               }
               else if(fieldType.contains("Date Picker")){
                 field.insert(index, getDatePickerField(fieldName,context));
               }
               else if(fieldType.contains("DropDown")){
               }

               field.removeAt(index+1);
               emit(AndroidFormInitial(formFields: field));

             }, child: const Text("Save",style:TextStyle(color: Colors.white)),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.indigoAccent.shade400))),
           ],
         ),
       ],

      ),
    );
 }

  //It's return a text edit field
  Widget getTextField(String fieldName) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: fieldName,
            labelText: "$fieldName*",
        ),
        onChanged: (value) => StoreFromData.formInfo.addAll({fieldName:value}),
      ),
    );
  }

  //It's return a date picker field
  Widget getDatePickerField(String fieldName,BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: "dd/mm/yyyy",
            labelText: "$fieldName*",
            suffixIcon : IconButton(icon: Icon(Icons.calendar_month,size: 20,),onPressed: ()=> getDate(fieldName,context))
        ),
      ),
    );
  }


  //It's return a time picker field
  Widget getTimePickerField(String fieldName,BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: "HH:mm",
            labelText: "$fieldName*",
            suffixIcon : IconButton(icon: Icon(Icons.calendar_month,size: 20,),onPressed: ()=> getTime(fieldName,context))
        ),
      ),
    );
  }


  //It's set date
  void getDate(String fieldName,BuildContext context,) async {

    DateTime selectedDate = DateTime.now();
    String date;

    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 3),
        lastDate: DateTime(2101));


    if (pickedDate != null) {
      date = "${numberFormat(pickedDate.day)}/${numberFormat(
            pickedDate.month)}/${pickedDate.year} ";

      // added date
      StoreFromData.formInfo.addAll({fieldName:date});
    }
  }


  //It's set time picker
  void getTime(String fieldName, BuildContext context) async {

    TimeOfDay selectedDate = TimeOfDay.now();
    final TimeOfDay? timePicker = await showTimePicker(
      context: context,
      initialTime: selectedDate,
    );

    if (timePicker != null) {

        String time = timePicker.format(context);
        // added time
        StoreFromData.formInfo.addAll({fieldName:time});
      }
    }

  // return two digit format
  String numberFormat(int num) {
    if (num <= 9) {
      return "0$num";
    } else {
      return "$num";
    }
  }

}
