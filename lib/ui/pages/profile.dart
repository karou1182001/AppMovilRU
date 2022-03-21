import 'package:app_ru/domain/constants/color.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(title: const Text("Profile")),
      body: const Center(
        child: Text("Profile"),
      ),
    );
  }
}
