import 'package:flutter/material.dart';

class DesktopForm extends StatefulWidget {
  const DesktopForm({Key? key}) : super(key: key);

  @override
  State<DesktopForm> createState() => _DesktopFormState();
}

class _DesktopFormState extends State<DesktopForm> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("This is Desktop"));
  }
}