import 'package:app_ru/domain/constants/color.dart';
import 'package:flutter/material.dart';

class Calendar extends StatelessWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(title: const Text("Calendar")),
      body: const Center(
        child: Text("Calendar"),
      ),
    );
  }
}
