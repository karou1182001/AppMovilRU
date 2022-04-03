// ignore_for_file: avoid_print

import 'package:app_ru/domain/constants/color.dart';
import 'package:app_ru/domain/constants/controllers/user_controller.dart';
import 'package:app_ru/domain/constants/text_style.dart';
import 'package:app_ru/ui/pages/pageProfile/editProfile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_ru/ui/pages/pageInicioyRegistro/inicio.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    UserController userController = Get.find();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: white,
          title: Image.asset("assets/logo_appbar.png", height: 60, width: 50),
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                //Imagen de perfil
                const SizedBox(
                    height: 115,
                    width: 115,
                    child: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/profile_example.jpg'))),
                const SizedBox(height: 10),
                //Nombre del usuario
                Text(userController.name, style: generalText(Colors.black, 20)),
                const SizedBox(height: 15),
                //Descripción
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text(userController.description,
                      style: generalText(Colors.grey, 15)),
                ),
                const SizedBox(height: 30),
                //Celular
                Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.phone),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(userController.number.toString(),
                            style: generalText(Colors.black, 15)),
                      ],
                    )),
                const SizedBox(
                  height: 15,
                ),
                //Parte del switch de RU?, que indica si el usuario se encuentra en la U o no.
                Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.location_on),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('RU?', style: generalText(Colors.black, 15)),
                        Obx(() => Switch(
                            activeColor: selectColor,
                            value: userController.ru,
                            onChanged: (value) => userController.changeRU()))
                      ],
                    )),
                const SizedBox(
                  height: 15,
                ),
                Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.calendar_today),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('Horario', style: generalText(Colors.black, 15)),
                      ],
                    )),
                const SizedBox(height: 10),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child:
                        const Image(image: AssetImage('assets/horario.png'))),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 220),
                    child: ElevatedButton(
                        key: const Key('edit'),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18))),
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.black)),
                        onPressed: () {
                          print('Navegar hacia la pantalla de editar perfil');
                          Get.to(() => EditProfile());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Editar Perfil',
                              style: generalText(Colors.white, 15),
                            )
                          ],
                        )),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 220),
                    child: ElevatedButton(
                        key: const Key('logout'),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18))),
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.black)),
                        onPressed: () {
                          print(
                              'Navegar hacia la pantalla de inicio de sesión');
                          Get.to(() => MenuInicio());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.logout, color: Colors.white),
                            const SizedBox(width: 10),
                            Text(
                              'Cerrar Sesión',
                              style: generalText(Colors.white, 15),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
