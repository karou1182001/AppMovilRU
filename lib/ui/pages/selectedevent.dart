import 'package:app_ru/models/events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectedEvent extends StatelessWidget {
  Events selectedevent;

  SelectedEvent({required this.selectedevent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(child: Center(child: Text(this.selectedevent.name))));
  }
}
