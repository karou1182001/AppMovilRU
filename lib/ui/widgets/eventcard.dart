import 'package:app_ru/models/event.dart';
import 'package:flutter/material.dart';

class Eventcard extends StatelessWidget {
  Event event;

  Function onEventClick;

  Eventcard({required this.event, required this.onEventClick});

  @override
  Widget build(BuildContext context) {
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
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset('assets/' + this.event.imgName + '.jpg',
                        fit: BoxFit.cover)),
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
                                event.color.withOpacity(0.7),
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
                              color: event.color,
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
}
