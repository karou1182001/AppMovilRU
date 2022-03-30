import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main () {
  runApp(const MenuRegistroGoogle());
}

class MenuRegistroGoogle extends StatelessWidget{
  const MenuRegistroGoogle({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context){
    return const Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(100,200,0,0),
        child: Text("Pantalla con libreria de Google"),
      ),
    );
  }
}