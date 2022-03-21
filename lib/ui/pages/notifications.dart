import 'package:app_ru/domain/constants/color.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(title: const Text("Notifications")),
      body: const Center(
        child: Text("Notifications"),
      ),
    );
  }
}
