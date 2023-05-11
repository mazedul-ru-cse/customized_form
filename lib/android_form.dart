import 'package:customized_form/state_management/android/cubit/android_form_cubit.dart';
import 'package:customized_form/store_form_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AndroidForm extends StatefulWidget {
  const AndroidForm({Key? key}) : super(key: key);

  @override
  State<AndroidForm> createState() => _AndroidFormState();
}

class _AndroidFormState extends State<AndroidForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title :const Text("Student Information"),
        centerTitle: true,
      ),

      body: BlocProvider(
        create: (context)=> AndroidFormCubit(),
        child: getFrom(),

      ),

    );
  }

  Widget getFrom(){
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<AndroidFormCubit,AndroidFormInitial>(
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
                        //     trailing: IconButton(icon: Icon(Icons.remove,color: Colors.red,), onPressed: ()=> BlocProvider.of<AndroidFormCubit>(context).removeAFriend(index)),
                        //   ),
                        // );

                        if(index == state.formFields.length){
                          return ElevatedButton(onPressed: ()=> BlocProvider.of<AndroidFormCubit>(context).addNewFriend(index), child: Text("Add field"));
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
