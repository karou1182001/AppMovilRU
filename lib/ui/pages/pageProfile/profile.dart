// ignore_for_file: avoid_print
import 'package:app_ru/domain/constants/constants/color.dart';
import 'package:app_ru/domain/constants/controllers/authentication_controller.dart';
import 'package:app_ru/domain/constants/constants/text_style.dart';
import 'package:app_ru/ui/pages/pageProfile/editProfile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_ru/ui/pages/pageInicioyRegistro/inicio.dart';
import 'package:image_picker/image_picker.dart';
import '../../../domain/constants/controllers/firebaseuser_controller.dart';
import '../../../models/users.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  @override
  FirebaseUserController userController = Get.find();
  AuthenticationController authController = Get.find();

  bool ru = false;
  bool loaded = false;
  late Users actualUser;

  Future getImage() async {
    //Pickeamos la imagen
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    //Añadir imagen a Firebase
    if (image != null) {
      userController.changeProfilePicture(image.path);
      loadData();
    }
  }

  Future getImageHorario() async {
    //Pickeamos la imagen
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    //Añadir imagen a Firebase
    if (image != null) {
      userController.changeProfileSchedule(image.path);
      loadData();
    }
  }

  void initState() {
    super.initState();
    FirebaseUserController userController = Get.find();
    userController.subscribeUpdates();
    loadData();
  }

   loadData() async {
    Users actualUsers = userController.actualUser;
    setState(() {
      actualUser = actualUsers;
      loaded = userController.loaded;
      ru = userController.actualUser.ru;
    });
    print(loaded);
  }

  void changeRu() async {
    await userController.changeRU();
    setState(() {
      ru = userController.actualUser.ru;
    });
    loadData();
  }

  Widget build(BuildContext context) {
    if (loaded) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            backgroundColor: white,
            title: Image.asset("assets/logo_appbar.png", height: 60, width: 50),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
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
                  child: CircleAvatar(
                      backgroundImage: NetworkImage(actualUser.url))),
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
                          color: colorp1,
                          border: Border.all(width: 3, color: Colors.black)),
                      child: const Icon(Icons.edit, color: Colors.black),
                    ),
                  ))
            ]),
            const SizedBox(height: 10),
            //Nombre del usuario
            Text(actualUser.name, style: generalText(Colors.black, 20)),
            const SizedBox(height: 15),
            //Descripción
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(actualUser.description,
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
                    Text(actualUser.number.toString(),
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
                    Text(actualUser.email.toString(),
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
                    Switch(
                        activeColor: selectColor,
                        value: actualUser.ru,
                        onChanged: (value) => changeRu())
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
                child: Image(
                    image: NetworkImage(actualUser.urlSchedule, scale: 1))),
            const SizedBox(
              height: 15,
            ),

            Row(
                children: [
                  
                  Container(
                padding: const EdgeInsets.only(left: 10),
                child: Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: ElevatedButton(
                      key: const Key('changeschedule'),
                      onPressed: () async {
                        await getImageHorario();
                      },
                      child: const Icon(Icons.add_a_photo, color: colorp1),),
                ),
              ),

                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: ElevatedButton(
                        onPressed: () {
                        print('Navegar hacia la pantalla de editar perfil');
                          Get.testMode = true;
                          Get.to(() => EditProfile());
                        },
                        key: const Key('edit'),
                        child: const Icon(Icons.edit, color: colorp1),
                  ),
                ),),

                Container(
              padding: const EdgeInsets.only(left: 10),
              child: Padding(
                padding: const EdgeInsets.only(right: 50),
                child: ElevatedButton(
                    key: const Key('logout'),
                    onPressed: () {
                      print('Navegar hacia la pantalla de inicio de sesión');
                      authController.signOut();
                      Get.to(() => MenuInicio());
                    },
                    child: const Icon(Icons.logout, color: colorp1),
                    ),
              ),
            ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            
          ],
        )),
      );
    } else {
      return const Center(child: Text('Cargando...'));
    }
  }
}
