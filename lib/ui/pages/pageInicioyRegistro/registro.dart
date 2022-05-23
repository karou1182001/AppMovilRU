import 'package:app_ru/domain/constants/constants/color.dart';
import 'package:app_ru/domain/constants/constants/firabase_constants.dart';
import 'package:app_ru/domain/constants/controllers/authentication_controller.dart';
import 'package:app_ru/domain/constants/constants/text_style.dart';
import 'package:app_ru/ui/pages/pageInicioyRegistro/condiciones.dart';
import 'package:app_ru/ui/pages/pageInicioyRegistro/inicio.dart';
import 'package:app_ru/ui/pages/pageProfile/profile.dart';
import 'package:app_ru/ui/pages/pageInicioyRegistro/terminos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../domain/constants/controllers/authentication_controller.dart';

void main() {
  runApp(MenuRegistro());
}

// ignore: must_be_immutable
class MenuRegistro extends StatelessWidget {
  MenuRegistro({Key? key}) : super(key: key);
  bool value = false;

  TextEditingController _nombreController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  AuthenticationController authController = Get.find();

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
              //Nombre del Usuario
              const Text("Nombre",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              TextFormField(controller: _nombreController),
              const SizedBox(
                height: 15,
              ),
              //Email del Usuario
              const Text("Email",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              TextFormField(controller: _emailController),
              const SizedBox(
                height: 15,
              ),
              //Contraseña del Usuario (tiene que ser de mínimo 6 caracteres)
              const Text("Contraseña",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              TextFormField(controller: _passwordController, obscureText: true),
              const SizedBox(
                height: 15,
              ),
              //Número del usuario
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
                    MaterialButton(
                      height: 40,
                      minWidth: 270,
                      onPressed: () async {
                        //Condiciones
                        if (_nombreController.text != '' &&
                            _emailController.text != '' &&
                            _numberController != 0 &&
                            _passwordController.text.length >= 6) {
                          try {
                            //Realizamos el registro en Firebase
                            await authController.register(_emailController.text,
                                _passwordController.text);
                            //Registramos los datos en Firestore
                            List<String> friends = [];
                            List<String> friendsRequest = [];
                            List<String> friendsRequested = [];
                            await FirebaseFirestore.instance
                                .collection('usuario')
                                .doc(_emailController.text)
                                .set({
                              'name': _nombreController.text,
                              'email': _emailController.text,
                              'ru': false,
                              'number': _numberController.text,
                              'description': '¡Dinos quién eres!',
                              'id': _emailController.text,
                              'latitude': 0.1,
                              'longitude': 0.1,
                              'friends':friends,
                              'friendsRequest' :friendsRequest,
                              'friendsRequested':friendsRequested,
                              'url' :'https://www.meteorologiaenred.com/wp-content/uploads/2018/02/olas.jpg',
                              'urlSchedule' : 'https://i.pinimg.com/originals/36/1c/73/361c7372f6113e6dfb5c28f6f03194ee.png',
                            }, SetOptions(merge: true));
                            //Enviamos un mensaje exitoso
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Registro Exitoso'),
                                    content: const Text(
                                        '¡Muchas gracias por registrarte!'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Get.to(MenuInicio());
                                          },
                                          child: const Text('OK'))
                                    ],
                                  );
                                });
                          } catch (e) {}
                        }
                      },
                      color: const Color.fromARGB(255, 1, 53, 96),
                      child: const Text(
                        "Regístrate",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
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
