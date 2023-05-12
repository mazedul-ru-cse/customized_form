import 'package:customized_form/static_variable/store_form_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/form_cubit.dart';

class CreateDropdownButton extends StatefulWidget {
  const CreateDropdownButton({Key? key, required this.fieldName, required this.index}) : super(key: key);
  final String fieldName;
  final int index;

  @override
  State<CreateDropdownButton> createState() => _CreateDropdownButtonState();
}

class _CreateDropdownButtonState extends State<CreateDropdownButton> {

  List<String> dropdownItems = [];
  bool isDropdownCreated = false;


  @override
  Widget build(BuildContext context) {
    return isDropdownCreated ? generateItems() : Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Flexible(
            flex: 5,
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Please enter number of items",
                labelText: "eg. 2,4 etc",
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: IconButton(icon: Icon(Icons.add), onPressed: (){
              setState(() {
                isDropdownCreated = true;
              });
            },
            ),
          )
        ],
      );
    }

  Widget generateItems() {

    Map<int,String> item = {};

    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListView.builder(
              primary : false,
              itemCount: 4,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index){
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Item ${index+1}"),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter item value",
                          ),
                          onChanged: (value)=>item.addAll({index:value}),
                        ),

                      ),
                    ),
                  ],
                );
              }
          ),


          //Submit button
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(onPressed: (){

              //Added dropdown item value
              BlocProvider.of<FormCubit>(context).addDropdownField(widget.index,widget.fieldName,item.values.toList());

              }, child: Text("Build")),
          )
        ],
      ),
    );

 }

}
