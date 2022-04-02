import 'package:app_ru/domain/constants/color.dart';
import 'package:app_ru/domain/constants/controllers/user_controller.dart';
import 'package:app_ru/domain/constants/text_style.dart';
import 'package:app_ru/ui/pages/pageProfile/profile.dart';
import 'package:app_ru/ui/widgets/navbar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_ru/ui/pages/pageInicioyRegistro/registro.dart';
import 'package:app_ru/ui/pages/pageInicioyRegistro/inicioGoogle.dart';

void main() {
  runApp(MenuInicio());
}

class MenuInicio extends StatelessWidget {
  MenuInicio({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              width: 110,
              height: 200,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/logo_appbar.png")))),
          Container(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Iniciar Sesión",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 3,
                    ),
                    Text("¡Qué gusto verte!",
                        style: generalText(Colors.grey, 18)),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text("Email",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    Obx(() =>
                        TextFormField(initialValue: userController.email)),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text("Contraseña",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    Obx(() => TextFormField(
                        initialValue: userController.password,
                        obscureText: true)),
                    const SizedBox(
                      height: 15,
                    ),
                  ])),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    child: MaterialButton(
                      height: 40,
                      minWidth: 270,
                      onPressed: () => Get.to(() => const NavBar()),
                      color: const Color.fromARGB(255, 1, 53, 96),
                      child: const Text(
                        "Ingresar",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                Text("O", style: generalText(Colors.grey, 15)),
                GestureDetector(
                    onTap: () => Get.to(() => const MenuRegistroGoogle()),
                    child: MaterialButton(
                        height: 40,
                        minWidth: 270,
                        onPressed: () =>
                            Get.to(() => const MenuRegistroGoogle()),
                        color: Colors.white,
                        child: const Text("Inicia Sesión con Google",
                            style: TextStyle(
                                color: Color.fromARGB(255, 1, 53, 96))))),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("¿No tienes cuenta? ",
                        style: generalText(Colors.grey, 15)),
                    GestureDetector(
                      onTap: () => Get.to(() => MenuRegistro()),
                      child: const Text("Regístrate",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
