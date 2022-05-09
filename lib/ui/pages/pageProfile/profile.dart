// ignore_for_file: avoid_print

import 'dart:io';

import 'package:app_ru/domain/constants/constants/color.dart';
import 'package:app_ru/domain/constants/controllers/authentication_controller.dart';
import 'package:app_ru/domain/constants/controllers/user_controller.dart';
import 'package:app_ru/domain/constants/constants/text_style.dart';
import 'package:app_ru/ui/pages/pageProfile/editProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_ru/ui/pages/pageInicioyRegistro/inicio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

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
    AuthenticationController authController = Get.find();
    String url = '';
    
    Future getImage() async {
      //Pickeamos la imagen
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      //Añadir imagen a Firebase
      userController.changeProfilePicture(image!.path);
      //Actualizamos al usuario
      setState(() async {
        url = userController.url.value;
        print(url);
      });
    }

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
                Stack(children: [
                  Container(
                      height: 115,
                      width: 115,
                      decoration: BoxDecoration(
                          border: Border.all(width: 3), shape: BoxShape.circle),
                      child: (userController.url.value != '')
                          ? CircleAvatar(backgroundImage: NetworkImage(userController.url.value))
                          : const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://www.meteorologiaenred.com/wp-content/uploads/2018/02/olas.jpg'))),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          getImage();
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.amber,
                              border:
                                  Border.all(width: 3, color: Colors.black)),
                          child: const Icon(Icons.edit, color: Colors.black),
                        ),
                      ))
                ]),
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
                //Email
                Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.email),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(userController.email.toString(),
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
                          Get.testMode = true;
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
                          authController.signOut();
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
