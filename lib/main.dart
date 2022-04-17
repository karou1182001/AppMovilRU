import 'package:app_ru/domain/constants/controllers/authentication_controller.dart';
import 'package:app_ru/domain/constants/controllers/user_controller.dart';
import 'package:app_ru/ui/pages/pageInicioyRegistro/inicio.dart';
import 'package:app_ru/ui/widgets/navbar/nav_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'domain/constants/controllers/authentication_controller.dart';
import 'domain/constants/controllers/event_controller.dart';
import 'domain/constants/controllers/friend_controller.dart';

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

                if (snapshot.connectionState == ConnectionState.done) {
                  Get.put(UserController());
                  Get.put(EventController());
                  Get.put(FriendController());
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
    return Container(
      child: Center(child: Text("Loading")),
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
