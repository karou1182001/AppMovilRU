import 'package:flutter/material.dart';

void main () {
  runApp(Terminos());
}

// ignore: must_be_immutable
class Terminos extends StatelessWidget{
  Terminos({Key? key}) : super(key: key);
  bool value = false;

  @override 
  Widget build(BuildContext context){
    return const Scaffold( 
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(100,200,0,0),
        child: Text("aquí van los términos"),
      ),
    );
  }
}