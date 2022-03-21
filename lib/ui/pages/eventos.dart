import 'package:app_ru/domain/constants/color.dart';
import 'package:flutter/material.dart';

class Eventos extends StatelessWidget {
  const Eventos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(title: const Text("Eventos")),
      body: const Center(
        child: Text("Eventos"),
      ),
    );
  }
}
