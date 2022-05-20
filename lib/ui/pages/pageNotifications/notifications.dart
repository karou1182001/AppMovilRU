import 'package:app_ru/domain/constants/constants/color.dart';
import 'package:app_ru/domain/constants/controllers/firebaseuser_controller.dart';
import 'package:app_ru/ui/widgets/userCardRequest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/users.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  FirebaseUserController firebaseUserController = Get.find();
  List<Users> friendsRequest = <Users>[];
  List<Users> usersRequest = [];

  void initState() {
    super.initState();
    firebaseUserController.onInit();
    firebaseUserController.subscribeUpdates();
    loadData();
  }

  loadData() async {
    usersRequest = await firebaseUserController.friendsRequestOfUser;
    setState(() {
      friendsRequest = usersRequest;
      print('hay un total de ' + friendsRequest.length.toString());
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            backgroundColor: white,
            title: Image.asset("assets/logo_appbar.png", height: 60, width: 50),
          ),
        ),
        body: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'Notificaciones',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
                Expanded(
                    child: ListView.builder(
                  itemCount: friendsRequest.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return UsercardRequest(
                      user: friendsRequest[index],
                      onEventClick: loadData(),
                    );
                  },
                ))
              ]),
        ));
  }
}
