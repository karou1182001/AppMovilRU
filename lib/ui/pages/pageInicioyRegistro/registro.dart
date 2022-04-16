import 'package:app_ru/domain/constants/color.dart';
import 'package:app_ru/domain/constants/text_style.dart';
import 'package:app_ru/ui/pages/pageInicioyRegistro/condiciones.dart';
import 'package:app_ru/ui/pages/pageInicioyRegistro/inicio.dart';
import 'package:app_ru/ui/pages/pageProfile/profile.dart';
import 'package:app_ru/ui/pages/pageInicioyRegistro/terminos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

void main() {
  runApp(MenuRegistro());
}

// ignore: must_be_immutable
class MenuRegistro extends StatelessWidget {
  MenuRegistro({Key? key}) : super(key: key);
  bool value = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(50, 80, 50, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text("Regístrate",
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
              TextFormField(controller: _emailController),
              const SizedBox(
                height: 15,
              ),
              const Text("Contraseña",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              TextFormField(controller: _passwordController),
              const SizedBox(
                height: 15,
              ),
              const Text("Número de teléfono",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              TextFormField(controller: _numberController),
              const SizedBox(
                height: 15,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ChangeNotifierProvider(
                          create: (_) => CheckboxProvider(),
                          child: Consumer<CheckboxProvider>(
                            builder: (context, checkboxProvider, _) => Checkbox(
                              value: checkboxProvider.isChecked,
                              onChanged: (value) {
                                checkboxProvider.isChecked = value ?? true;
                              },
                            ),
                          ),
                        ),
                        const Text("Acepto ",
                            style: TextStyle(color: Colors.grey, fontSize: 15)),
                        GestureDetector(
                          onTap: () => Get.to(() => Terminos()),
                          child: const Text("términos ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 1, 53, 96),
                                  fontSize: 15)),
                        ),
                        const Text("y ",
                            style: TextStyle(color: Colors.grey, fontSize: 15)),
                        GestureDetector(
                          onTap: () => Get.to(() => Condiciones()),
                          child: const Text("condiciones.",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 1, 53, 96),
                                  fontSize: 15)),
                        ),
                      ],
                    ),
                    GestureDetector(
                        onTap: () => Get.to(() => const Profile()),
                        child: MaterialButton(
                          height: 40,
                          minWidth: 270,
                          onPressed: () => Get.to(() => const Profile()),
                          color: const Color.fromARGB(255, 1, 53, 96),
                          child: const Text(
                            "Regístrate",
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Si ya tienes una cuenta, "),
                        GestureDetector(
                          onTap: () => Get.to(() => MenuInicio()),
                          child: const Text("inicia sesión",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 1, 53, 96),
                                  fontSize: 15)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckboxProvider with ChangeNotifier {
  bool _isChecked = false;

  bool get isChecked => _isChecked;

  set isChecked(bool value) {
    _isChecked = value;
    notifyListeners();
  }
}
