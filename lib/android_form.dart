import 'package:flutter/material.dart';

class AndroidForm extends StatefulWidget {
  const AndroidForm({Key? key}) : super(key: key);

  @override
  State<AndroidForm> createState() => _AndroidFormState();
}

class _AndroidFormState extends State<AndroidForm> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("This is android"));
  }
}
