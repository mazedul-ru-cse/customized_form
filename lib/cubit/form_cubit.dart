import 'package:bloc/bloc.dart';
import 'package:customized_form/component/create_dropdown_button.dart';
import 'package:customized_form/component/dropdown_button_field.dart';
import 'package:flutter/material.dart';

import '../component/field_type_dropdown.dart';
import '../component/radio_button_field.dart';
import '../static_variable/static_variable.dart';
import '../static_variable/store_form_data.dart';
import 'initial_form_state.dart';


class Fields {

  static List<Widget> formFields =

  [
    //Student name field
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: const InputDecoration(
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
        decoration: const InputDecoration(
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
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Mother's name",
            labelText: "Mother's name*"
        ),
        onChanged: (value) => StoreFromData.formInfo.addAll({"Mother's name":value}),
      ),
    ),
  ];
}

class FormCubit extends Cubit<InitialFormState> {
  FormCubit() : super(InitialFormState(formFields: Fields.formFields));

  //Add a new field in the form
  void addNewFriend(int index,BuildContext context){
    final field = state.formFields;
    field.insert(index, customField(index,context));
    emit(InitialFormState(formFields: field));
  }


  int getLastIndex(){
    return state.formFields.length;
  }

  //Add a new field in the form
  void addDropdownField(int index,String fieldName, List<String> itemNames){
    final field = state.formFields;
    field.removeAt(index);
    field.insert(index, DropdownButtonField(itemNames: itemNames,fieldName: fieldName, ));
    emit(InitialFormState(formFields: field));
  }


  //It's return a fieldName, fieldType dropdown, and two buttons
  Widget customField(int index,BuildContext context){

    String fieldName = "";

    final field = state.formFields;

    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5,
      child: Column(

        children: [

          //Field name
          Row(
            children: [
              const Flexible(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text("Field Name : "),
                  )),

              Flexible(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    decoration: const InputDecoration(
                    ),
                    onChanged: (value){
                      fieldName = value;
                    },
                  ),

                ),
              ),
            ],
          ),

          const SizedBox(height: 10,),

          // Field type
          Row(
            children: [
              const Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text("Field Type : "),
                ),
              ),

              const Flexible(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FieldTypeDropDown(),
                ),
              ),

            ],
          ),

          const SizedBox(height: 10,),

          //Close & save button

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: (){

                field.removeAt(index);
                emit(InitialFormState(formFields: field));

              }, child: const Text("Close",style: TextStyle(color: Colors.white)),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green.shade600)),),
              TextButton(onPressed: (){


                if(StaticVariable.fieldType.contains("Text Field")){
                  field.insert(index, getTextField(fieldName));
                }

                else if(StaticVariable.fieldType.contains("Time Picker")){
                  field.insert(index, getTimePickerField(fieldName,context));
                }

                else if(StaticVariable.fieldType.contains("Date Picker")){
                  field.insert(index, getDatePickerField(fieldName,context));
                }

                else if(StaticVariable.fieldType.contains("DropDown")){
                  field.insert(index, CreateDropdownButton(fieldName: fieldName, index: index));
                }

                else if(StaticVariable.fieldType.contains("Radio button")){
                  field.insert(index, RadioButtonField(fieldName: fieldName));
                }

                field.removeAt(index+1);
                emit(InitialFormState(formFields: field));

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

  var datePickerController = TextEditingController();
  //It's return a date picker field
  Widget getDatePickerField(String fieldName,BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: datePickerController,
        readOnly: true,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: "dd/mm/yyyy",
            labelText: "$fieldName*",
            suffixIcon : IconButton(icon: const Icon(Icons.calendar_month,size: 20,),onPressed: ()=> getDate(fieldName,context))
        ),
      ),
    );
  }


  var timePickerController = TextEditingController();
  //It's return a time picker field
  Widget getTimePickerField(String fieldName,BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: timePickerController,
        readOnly: true,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: "HH:mm",
            labelText: "$fieldName*",
            suffixIcon : IconButton(icon: const Icon(Icons.watch_later_outlined,size: 20,),onPressed: ()=> getTime(fieldName,context))
        ),
      ),
    );
  }

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
      datePickerController.text = date;

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

      timePickerController.text = time;

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

