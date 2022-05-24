import 'package:app_ru/domain/constants/constants/color.dart';
import 'package:app_ru/domain/constants/constants/storage_repo.dart';
import 'package:app_ru/domain/constants/controllers/authentication_controller.dart';
import 'package:app_ru/domain/constants/controllers/firebaseuser_controller.dart';
import 'package:app_ru/ui/pages/pageInicioyRegistro/inicio.dart';
import 'package:app_ru/ui/widgets/navbar/nav_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'domain/constants/controllers/authentication_controller.dart';
import 'domain/constants/controllers/firebaseevent_controller.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  _requestPermission();
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _init = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'RU',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: SafeArea(
          child: FutureBuilder(
              future: _init,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Container(child: Text('Error'));
                }
                //Si la conexión fue exitosa
                if (snapshot.connectionState == ConnectionState.done) {
                  Get.put(AuthenticationController());
                  print('Estamos conectados');
                  return MenuInicio();
                }
                //Poner bonito esto
                return Loading();
              })),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Container(
        child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/logo_appbar.png"),
                          )
                        )
                    ),
                    const Text("Loading",
                        style: TextStyle(
                            color: colorp1,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),])))
    );
  }
}

_requestPermission() async {
  var status = await Permission.location.request();
  if (status.isGranted) {
    print('done');
  } else if (status.isDenied) {
    _requestPermission();
  } else if (status.isPermanentlyDenied) {
    openAppSettings();
  }
}
