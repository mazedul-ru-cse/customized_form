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
                  margin: const EdgeInsets.all(10),
                  child: ListView.builder(
                      itemCount: state.formFields.length+1,
                      itemBuilder: (context,index){

                        if(index == state.formFields.length){
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              //Add a new field button
                              Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ElevatedButton(onPressed: ()=> BlocProvider.of<FormCubit>(context).addNewFriend(BlocProvider.of<FormCubit>(context).getLastIndex(),context), child: Text("Add a new field")),
                                  )),


                              //Submit button
                              Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ElevatedButton(onPressed: ()=> printFormInfo(), child: Text("Submit")),
                                  )),
                            ],
                          );
                        }
                        return state.formFields[index];
                      }
                  ),
                );
              }
          ),
        ),

        //Submit button

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
