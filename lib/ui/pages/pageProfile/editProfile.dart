// ignore_for_file: file_names

import 'package:app_ru/domain/constants/controllers/authentication_controller.dart';
import 'package:app_ru/domain/constants/constants/text_style.dart';
import 'package:app_ru/domain/constants/controllers/firebaseuser_controller.dart';
import 'package:app_ru/ui/widgets/navbar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/constants/constants/color.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthenticationController authController = Get.find();
  FirebaseUserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset("assets/logo_appbar.png", height: 60, width: 50),
        ),
      ),
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
              TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: userController.actualUser.name)),
              const SizedBox(
                height: 15,
              ),
              //Editar contraseña
              const Text("Contraseña",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              TextFormField(controller: passwordController, obscureText: true,),
              const SizedBox(
                height: 15,
              ),
              //Editar número
              const Text("Número de teléfono",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              TextFormField(
                  controller: numberController,
                  decoration: InputDecoration(
                      hintText: userController.actualUser.number.toString())),
              const SizedBox(
                height: 15,
              ),
              //Editar descripción
              const Text("Descripción",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: descriptionController,
                  decoration: InputDecoration(
                      hintText: userController.actualUser.description)),
                      const SizedBox(
              height: 15,
            ),
              ElevatedButton(
                  key: Key('editar'),
                  style: ButtonStyle(
                                          backgroundColor: MaterialStateColor.resolveWith(
                                              (states) => colorp2)),
                  onPressed: () {
                    if (nameController.text != '') {
                      userController.changeUserName(nameController.text);
                    }
                    if (numberController.text != '') {
                      userController.changeUserNumber((numberController.text));
                    }
                    if (passwordController.text != '') {
                      authController.auth.currentUser!
                          .updatePassword(passwordController.text);
                    }
                    if (descriptionController.text != '') {
                      userController
                          .changeUserDescription(descriptionController.text);
                    }
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Perfil Editado Correctamente'),
                            content: const Text('👍👍👍'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Get.to(const NavBar());
                                  },
                                  child: const Text('OK'))
                            ],
                          );
                        });
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
