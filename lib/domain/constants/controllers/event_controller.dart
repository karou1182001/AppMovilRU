import 'package:app_ru/models/event.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  final _events = RxList<Event>();
  DateTime _selectedDate = DateTime.now();

  //Getters
  get events => _events;
  DateTime get selectedDate => _selectedDate;
  RxList get eventsOfSelectedDate => _events;

  EventController() {
    _events.add(Event(
        name: "Salir de clase",
        from: DateTime.now(),
        to: DateTime.now(),
        description: "Salir de clase y no volver más",
        persCreadora: "Mateo",
        invitados: ["Chirstian", "Danna"],
        color: Colors.blue,
        imgName: "1"));
    _events.add(Event(
        name: "Discución intelectual",
        from: DateTime.now(),
        to: DateTime.now(),
        description: "Nos creemos intelectuales y discutimos",
        persCreadora: "Mateo",
        invitados: ["Chirstian", "Danna"],
        color: Colors.green,
        imgName: "0"));
  }

  //Setters
  void addEvent(Event event) {
    _events.add(event);
  }

  void setDate(DateTime date) {
    _selectedDate = date;
  }

  //Otros

  void deleteEvent(Event event) {
    _events.remove(event);
  }

  void editEvent(Event newEvent, Event oldEvent) {
    final index = _events.indexOf(oldEvent);
    _events[index] = newEvent;
  }
}
