import 'package:app_ru/domain/constants/controllers/firebaseevent_controller.dart';
import 'package:app_ru/domain/constants/controllers/firebaseuser_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/constants/constants/color.dart';
import '../../models/event.dart';

class EventInvitationCard extends StatelessWidget {
  Event event;
  FirebaseEventController firebaseEventController = Get.find();

  EventInvitationCard({required this.event});

  @override
  Widget build(BuildContext context) {
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
            firebaseEventController.acceptInvitation(event.name);
          } else {
            firebaseEventController.denyInvitation(event.name);
          }
        },
        child: Text(
          text,
          style: TextStyle(color: txtColor),
        ));
  }
}
