import 'package:app_ru/domain/constants/color.dart';
import 'package:flutter/material.dart';

class MyCalendar extends StatelessWidget {
  const MyCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("MyCalendar"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Hola");
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
