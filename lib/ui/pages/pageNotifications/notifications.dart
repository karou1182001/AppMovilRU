import 'package:app_ru/domain/constants/constants/color.dart';
import 'package:app_ru/domain/constants/controllers/firebaseevent_controller.dart';
import 'package:app_ru/domain/constants/controllers/firebaseuser_controller.dart';
import 'package:app_ru/models/event.dart';
import 'package:app_ru/ui/widgets/eventInvitationCard.dart';
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
  FirebaseEventController firebaseEventController = Get.find();
  List<Users> friendsRequest = <Users>[];
  List<Users> usersRequest = [];
  List<Event> invitedRequest = <Event>[];
  List<Event> invited = [];

  void initState() {
    super.initState();
    firebaseUserController.onInit();
    firebaseUserController.subscribeUpdates();
    loadData();
  }

  findInvitation() async {
    await firebaseEventController.findInvitation();
  }

  loadData() async {
    await firebaseEventController.findInvitation();
    usersRequest = await firebaseUserController.friendsRequestOfUser;
    invited = await firebaseEventController.invitedList;
    setState(() {
      friendsRequest = usersRequest;
      invitedRequest = invited;
      print('hay un total de ' + invitedRequest.length.toString());
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
                      'Solicitudes de Amistad',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    )),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: friendsRequest.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return userCardReq(friendsRequest[index]);
                    },
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'Invitaciones a Eventos',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    )),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: invitedRequest.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return invitationCard(invitedRequest[index]);
                    },
                  ),
                )
              ]),
        ));
  }

//Widgets

  Card userCardReq(Users user) {
    return Card(
        child: ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage(user.url),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              child: Text(
                "${user.name}",
                style: TextStyle(fontSize: 17),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          estiloBtn('Aceptar', selectColor, white, true, user),
          estiloBtn('Rechazar', black, white, false, user)
        ],
      ),
    ));
  }

  ElevatedButton estiloBtn(
      String text, Color color, Color txtColor, bool aceptar, Users user) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.resolveWith((states) => color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)))),
        onPressed: () async {
          if (aceptar) {
            await firebaseUserController.acceptFriend(user.email);
            loadData();
          } else {
            await firebaseUserController.declineFriend(user.email);
            loadData();
          }
        },
        child: Text(
          text,
          style: TextStyle(color: txtColor),
        ));
  }

  Card invitationCard(Event event) {
    return Card(
        child: ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              child: Text(
                event.name,
                style: TextStyle(fontSize: 17),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          estiloBtnInvite('Aceptar', selectColor, white, true, event),
          estiloBtnInvite('Rechazar', black, white, false, event)
        ],
      ),
    ));
  }

  ElevatedButton estiloBtnInvite(
      String text, Color color, Color txtColor, bool aceptar, Event event) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.resolveWith((states) => color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)))),
        onPressed: () async {
          if (aceptar) {
            await firebaseEventController.acceptInvitation(event.name);
            loadData();
          } else {
            await firebaseEventController.denyInvitation(event.name);
            loadData();
          }
        },
        child: Text(
          text,
          style: TextStyle(color: txtColor),
        ));
  }
}
