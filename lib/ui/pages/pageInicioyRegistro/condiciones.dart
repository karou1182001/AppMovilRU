import 'package:flutter/material.dart';

void main () {
  runApp(Condiciones());
}

// ignore: must_be_immutable
class Condiciones extends StatelessWidget{
  Condiciones({Key? key}) : super(key: key);
  bool value = false;

  @override 
  Widget build(BuildContext context){
    return const Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(100,200,0,0),
        child: Text("aquí van las condiciones"),
      ),
    );
  }
}