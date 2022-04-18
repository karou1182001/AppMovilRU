import 'package:app_ru/models/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/firabase_constants.dart';
import 'FirestoreEven.dart';
import 'authentication_controller.dart';

class EventController extends GetxController {
  RxList<Event> eventList = RxList<Event>([]);
  DateTime _selectedDate = DateTime.now();

  //Firestore
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //Getters
  get events => eventList;
  DateTime get selectedDate => _selectedDate;
  RxList get eventsOfSelectedDate => eventList;

  EventController() {
    findevents();
    // _events.add(Event(
    //     name: "Salir de clase",
    //     from: DateTime.now(),
    //     to: DateTime.now(),
    //     description: "Salir de clase y no volver más",
    //     persCreadora: "Mateo",
    //     invitados: ["Chirstian", "Danna"],
    //     color: Colors.blue,
    //     imgName: "1"));
    // _events.add(Event(
    //     name: "Discución intelectual",
    //     from: DateTime.now(),
    //     to: DateTime.now(),
    //     description: "Nos creemos intelectuales y discutimos",
    //     persCreadora: "Mateo",
    //     invitados: ["Chirstian", "Danna"],
    //     color: Colors.green,
    //     imgName: "0"));
  }

  @override
  void onInit() {
    super.onInit();
    //eventList.bindStream(FirestoreDb.eventStream());
    print("on init");
  }

  //Setters
  void addEvent(Event event) {
    FirestoreDb.addEvent(event);
    eventList.add(event);
  }

  void setDate(DateTime date) {
    _selectedDate = date;
  }

  //Otros

  void deleteEvent(Event event) {
    FirestoreDb.deleteEvent(event.eventId);
    eventList.remove(event);
  }

  void editEvent(Event newEvent, Event oldEvent) {
    final index = eventList.indexOf(oldEvent);
    eventList[index] = newEvent;
  }

  @override
  void onReady() {
    super.onReady();
  }

  void findevents() async {
    var query =
        eventsFirebase.where('persCreadora', isEqualTo: "Usuario actual");
    QuerySnapshot evento = await query.get();
    List<Event> events = [];
    for (var event in evento.docs) {
      final _events = Event.fromDocumentSnapshot(documentSnapshot: event);
      events.add(_events);
    }
    eventList = events.obs;
  }
}
