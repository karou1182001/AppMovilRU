import 'package:app_ru/domain/constants/controllers/user_controller.dart';
import 'package:app_ru/ui/widgets/navbar/nav_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'domain/constants/config/configuration.dart';
import 'domain/constants/controllers/event_controller.dart';
import 'domain/constants/controllers/friend_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _init = Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: Configuration.apiKey,
        authDomain: Configuration.authDomain,
        databaseURL: Configuration.databaseURL,
        projectId: Configuration.projectId,
        storageBucket: Configuration.storageBucket,
        messagingSenderId: Configuration.messagingSenderId,
        appId: Configuration.appId,
        measurementId: Configuration.measurementId),
  );

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
                  print('Estamos conectados');
                  return NavBar();
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
