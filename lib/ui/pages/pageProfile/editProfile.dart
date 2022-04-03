// ignore_for_file: file_names

import 'package:app_ru/domain/constants/controllers/user_controller.dart';
import 'package:app_ru/domain/constants/text_style.dart';
import 'package:app_ru/ui/pages/pageProfile/profile.dart';
import 'package:app_ru/ui/widgets/navbar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);
  UserController userController = UserController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(50, 80, 50, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text("Editar Perfil",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 25,
              ),
              const Text("Name",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              Obx(() => TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: userController.name))),
              const SizedBox(
                height: 15,
              ),
              const Text("Contraseña",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              TextFormField(
                  decoration:
                      InputDecoration(hintText: 'Digite una nueva contraseña'),
                  obscureText: true),
              const SizedBox(
                height: 15,
              ),
              const Text("Número de teléfono",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              Obx(() => TextFormField(
                  decoration: InputDecoration(
                      hintText: userController.number.toString()))),
              const SizedBox(
                height: 15,
              ),
              const Text("Descripción",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              Obx(() => TextField(
                  decoration:
                      InputDecoration(hintText: userController.description),
                  keyboardType: TextInputType.multiline,
                  maxLines: null)),
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => const NavBar());
                  },
                  child: Text(
                    'Editar Datos',
                    style: generalText(Colors.black, 18),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
