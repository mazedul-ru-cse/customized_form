import 'package:customized_form/android_form.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        title: Text("Customized Form"),
        centerTitle: true,
      ),

      body: Center(
          child: ElevatedButton(child: const Text("Form"),onPressed: (){

            //for windows
            if (defaultTargetPlatform == TargetPlatform.windows){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const AndroidForm()));}

            // for mobile
            else if (defaultTargetPlatform == TargetPlatform.android){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const AndroidForm()));
            }
          }
          )
      )
    );
  }

}

