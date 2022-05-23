import 'package:app_ru/domain/constants/controllers/firebaseuser_controller.dart';
import 'package:app_ru/models/users.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/constants/constants/color.dart';

class UsercardRequest extends StatelessWidget {
  Users user;
  FirebaseUserController firebaseUserController = Get.find();
  dynamic onEventClick;

  UsercardRequest({required this.user, required this.onEventClick});

  @override
  Widget build(BuildContext context) {
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
          estiloBtn('Aceptar', selectColor, white, true),
          estiloBtn('Rechazar', black, white, false)
        ],
      ),
    ));
  }

  ElevatedButton estiloBtn(
      String text, Color color, Color txtColor, bool aceptar) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.resolveWith((states) => color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)))),
        onPressed: () async {
          if (aceptar) {
            firebaseUserController.acceptFriend(user.email);
            onEventClick();
          } else {
            firebaseUserController.declineFriend(user.email);
            onEventClick();
          }
        },
        child: Text(
          text,
          style: TextStyle(color: txtColor),
        ));
  }
}
