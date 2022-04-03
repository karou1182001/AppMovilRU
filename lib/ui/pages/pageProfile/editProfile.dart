import 'package:app_ru/domain/constants/controllers/user_controller.dart';
import 'package:app_ru/domain/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);
  UserController userController = UserController();

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
              const Text("Email",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              Obx(() => TextFormField(initialValue: userController.email)),
              const SizedBox(
                height: 15,
              ),
              const Text("Contraseña",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              Obx(() => TextFormField(
                  initialValue: userController.password, obscureText: true)),
              const SizedBox(
                height: 15,
              ),
              const Text("Número de teléfono",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              Obx(() => TextFormField(
                  initialValue: userController.number.toString())),
              const SizedBox(
                height: 15,
              ),
              const Text("Descripción",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              Obx(() =>
                  TextFormField(initialValue: userController.description)),
              ElevatedButton(
                  onPressed: () {},
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
