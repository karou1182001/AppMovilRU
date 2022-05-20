import 'package:app_ru/domain/constants/constants/color.dart';
import 'package:app_ru/domain/constants/controllers/authentication_controller.dart';
import 'package:app_ru/domain/constants/controllers/user_controller.dart';
import 'package:app_ru/domain/constants/constants/text_style.dart';
import 'package:app_ru/ui/pages/pageProfile/profile.dart';
import 'package:app_ru/ui/widgets/navbar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_ru/ui/pages/pageInicioyRegistro/registro.dart';
import 'package:app_ru/ui/pages/pageInicioyRegistro/inicioGoogle.dart';
import 'package:provider/provider.dart';

import '../../../domain/constants/controllers/authentication_controller.dart';

void main() {
  runApp(MenuInicio());
}

class MenuInicio extends StatelessWidget {
  MenuInicio({Key? key}) : super(key: key);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  AuthenticationController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    AuthenticationController authController = Get.find();
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
                    TextFormField(controller: _emailController),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text("Contraseña",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    TextFormField(
                        controller: _passwordController, obscureText: true),
                    const SizedBox(
                      height: 15,
                    ),
                  ])),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  height: 40,
                  minWidth: 270,
                  onPressed: () async {
                    try {
                      bool inicio = await authController.login(
                          _emailController.text, _passwordController.text);
                      if (inicio) {
                        Get.to(() => const NavBar());
                        print(authController.auth.currentUser!.email);
                      } else {
                        print('Error iniciando sesión');
                      }
                    } catch (e) {}
                  },
                  color: const Color.fromARGB(255, 1, 53, 96),
                  child: const Text(
                    "Ingresar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
<<<<<<< Updated upstream
=======
                Text("O", style: generalText(Colors.grey, 15)),
                GestureDetector(
                    onTap: () => Get.to(() => GoogleSignInProvider()),
                    child: MaterialButton(
                        height: 40,
                        minWidth: 270,
                        onPressed: () {
                          authController.signInWithGoogle();
                        },
                        color: Colors.white,
                        child: const Text("Inicia Sesión con Google",
                            style: TextStyle(
                                color: Color.fromARGB(255, 1, 53, 96))))),
>>>>>>> Stashed changes
                const SizedBox(
                  height: 20,
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
