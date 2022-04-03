// ignore_for_file: file_names

import 'package:app_ru/domain/constants/controllers/user_controller.dart';
import 'package:app_ru/domain/constants/text_style.dart';
import 'package:app_ru/ui/widgets/navbar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    UserController userController = Get.find();
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
              //Editar nombre
              const Text("Nombre",
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
              //Editar contraseña
              const Text("Contraseña",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              TextFormField(controller: passwordController),
              const SizedBox(
                height: 15,
              ),
              //Editar número
              const Text("Número de teléfono",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              Obx(() => TextFormField(
                  controller: numberController,
                  decoration: InputDecoration(
                      hintText: userController.number.toString()))),
              const SizedBox(
                height: 15,
              ),
              //Editar descripción
              const Text("Descripción",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              Obx(() => TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: descriptionController,
                  decoration:
                      InputDecoration(hintText: userController.description))),
              ElevatedButton(
                key: Key('editar'),
                  onPressed: () {
                    if (nameController.text != '') {
                      userController.changeUserName(nameController.text);
                    }
                    if (numberController.text != '') {
                      userController
                          .changeUserNumber(int.parse(numberController.text));
                    }
                    if (passwordController.text != '') {
                      userController
                          .changeUserPassword(passwordController.text);
                    }
                    if (descriptionController.text != '') {
                      userController
                          .changeUserDescription(descriptionController.text);
                    }

                    Get.to(() => NavBar());
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
