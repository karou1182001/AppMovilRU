import 'package:app_ru/ui/widgets/navbar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'domain/constants/controllers/event_controller.dart';

void main() {
  Get.put(EventController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'RU',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const SafeArea(child: NavBar()),
    );
  }
}
