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

  void addNewFriend(int index){
    final field = state.formFields;
    field.insert(index, customField(index));
    emit(AndroidFormInitial(formFields: field));
  }

 Widget customField(int index){

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

             }, child: Text("Close",style: TextStyle(color: Colors.white)),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green.shade600)),),
             TextButton(onPressed: (){


               if(fieldType.contains("Text Field")){

                 field.insert(index, getTextField(fieldName));
               }

               else if(fieldType.contains("Time Picker")){

               }
               else if(fieldType.contains("Date Picker")){

               }
               else if(fieldType.contains("DropDown")){

               }

               field.removeAt(index+1);
               emit(AndroidFormInitial(formFields: field));

             }, child: Text("Save",style:TextStyle(color: Colors.white)),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.indigoAccent.shade400))),
           ],
         ),
       ],

      ),
    );
 }

  Widget getTextField(String fieldName) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: fieldName,
            labelText: "$fieldName*"
        ),
        onChanged: (value) => StoreFromData.formInfo.addAll({fieldName:value}),
      ),
    );
  }


}
