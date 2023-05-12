import 'package:customized_form/static_variable/static_variable.dart';
import 'package:customized_form/student_information_form.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/*
 @auth M A Mazedul Islam
 Mobile App Developer
 mazedulislam4970@gmail.com
 */

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Form()
    );
  }
}

class Form extends StatelessWidget {
  const Form({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customized Form"),
        centerTitle: true,
      ),

      body: Container(
        height: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(StaticVariable.message,textAlign: TextAlign.justify,style: TextStyle(fontSize: 18),),
                    ),
                  ),

                  ElevatedButton(child: const Text("Form"),onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> const StudentInformationForm()))),
                ],
              ),
        ),
      )

    );
  }

}

