import 'package:app_ru/models/events.dart';
import 'package:flutter/material.dart';

class Eventcard extends StatelessWidget {
  Events event;

  Function onEventClick;

  Eventcard({required this.event, required this.onEventClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onEventClick();
      },
      child: Container(
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
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                this.event.color.withOpacity(0.7),
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
                              color: this.event.color,
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.add_outlined,
                                size: 30,
                                color: Colors.white,
                              )),
                        ),
                        SizedBox(width: 10),
                        Text(
                          this.event.name,
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        )
                      ],
                    ),
                  ))
            ],
          )),
    );
  }
}
