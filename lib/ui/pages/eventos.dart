import 'package:app_ru/domain/constants/color.dart';
import 'package:flutter/material.dart';

class Eventos extends StatelessWidget {
  const Eventos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: white,
          title: Image.asset("assets/logo_appbar.png", height: 60, width: 50),
          actions: const [
            IconButton(onPressed: null, icon: Icon(Icons.search))
          ],
        ),
      ),
      body: Center(
        child: Text("Eventos"),
      ),
    );
  }
}
