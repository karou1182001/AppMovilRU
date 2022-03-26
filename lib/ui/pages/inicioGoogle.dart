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
        child: Text("Pantalla con libreria de Google"),
      ),
    );
  }
}