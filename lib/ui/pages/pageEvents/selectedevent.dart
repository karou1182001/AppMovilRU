import 'package:app_ru/models/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/constants/color.dart';

class SelectedEvent extends StatelessWidget {
  Event selectedevent;

  SelectedEvent({required this.selectedevent});

  @override
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Container(
                      color: this.selectedevent.color,
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.sentiment_satisfied_outlined,
                        size: 30,
                        color: Colors.white,
                      )),
                ),
                SizedBox(width: 10),
                Text(
                  this.selectedevent.name,
                  style: TextStyle(color: Colors.black, fontSize: 25),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        Text(this.selectedevent.description,
                            style:
                                TextStyle(color: Colors.black, fontSize: 20)),
                        Spacer(),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(children: <Widget>[
                    Text('Fecha de inicio: ' +
                        this.selectedevent.from.toString()),
                    Spacer()
                  ]),
                )
              ]),
            )
          ],
        )));
  }
}
