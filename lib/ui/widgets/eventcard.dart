import 'package:app_ru/models/event.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../domain/constants/controllers/firebaseevent_controller.dart';

class Eventcard extends StatelessWidget {
  Event event;
  String url;
  Function onEventClick;

  Eventcard(
      {required this.event, required this.url, required this.onEventClick});

  @override
  Widget build(BuildContext context) {
    FirebaseEventController feventCont = Get.find();
    feventCont.getEventUrl(event.name);
    return GestureDetector(
      onTap: () {
        onEventClick();
      },
      child: Container(
          key: Key('Event_Card' + this.event.imgName),
          margin: EdgeInsets.all(20),
          height: 150,
          child: Stack(
            children: [
              Positioned.fill(
                child: images(),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Color(event.color).withOpacity(0.7),
                                Colors.transparent
                              ])))),
              Positioned(
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Container(
                              color: Color(event.color),
                              padding: const EdgeInsets.all(10),
                              child: const Icon(
                                Icons.add_outlined,
                                size: 30,
                                color: Colors.white,
                              )),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          event.name,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 25),
                        )
                      ],
                    ),
                  ))
            ],
          )),
    );
  }

  Widget images() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: (url != '')
            ? Image.network(url, fit: BoxFit.cover)
            : Image.network(
                'https://www.meteorologiaenred.com/wp-content/uploads/2018/02/olas.jpg',
                fit: BoxFit.cover));
  }
}
