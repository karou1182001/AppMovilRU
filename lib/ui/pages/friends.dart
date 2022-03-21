import 'package:app_ru/domain/constants/color.dart';
import 'package:flutter/material.dart';

class Friends extends StatelessWidget {
  const Friends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(title: const Text("Friends")),
      body: const Center(
        child: Text("Friends"),
      ),
    );
  }
}
