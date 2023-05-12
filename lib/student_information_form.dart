import 'package:customized_form/cubit/form_cubit.dart';
import 'package:customized_form/cubit/initial_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'static_variable/store_form_data.dart';

class StudentInformationForm extends StatefulWidget {
  const StudentInformationForm({Key? key}) : super(key: key);

  @override
  State<StudentInformationForm> createState() => _StudentInformationFormState();
}

class _StudentInformationFormState extends State<StudentInformationForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title :const Text("Student Information"),
        centerTitle: true,
      ),

      body: BlocProvider(
        create: (context)=> FormCubit(),
        child: getFrom(),

      ),

    );
  }

  Widget getFrom(){
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<FormCubit,InitialFormState>(
              builder: (context,state){
                return Container(
                  margin: EdgeInsets.all(10),
                  child: ListView.builder(
                      itemCount: state.formFields.length+1,
                      itemBuilder: (context,index){
                        // return Card(
                        //   elevation: 3,
                        //   child: ListTile(
                        //     leading: Text(index.toString()),
                        //     title: Text(state.friendsName[index]),
                        //     trailing: IconButton(icon: Icon(Icons.remove,color: Colors.red,), onPressed: ()=> BlocProvider.of<StudentInformationFormCubit>(context).removeAFriend(index)),
                        //   ),
                        // );

                        if(index == state.formFields.length){
                          return ElevatedButton(onPressed: ()=> BlocProvider.of<FormCubit>(context).addNewFriend(index,context), child: Text("Add field"));
                        }
                        return state.formFields[index];
                      }
                  ),
                );
              }
          ),
        ),

        //Submit button
        ElevatedButton(onPressed: ()=> printFormInfo(), child: Text("Submit"))

      ],
    );


  }

  //Print the form information in console
  void printFormInfo() {

    StoreFromData.formInfo.forEach((key, value) {

      print("$key : $value");
    });

  }

}
