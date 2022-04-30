import 'dart:async';

import 'package:app_ru/domain/constants/constants/firabase_constants.dart';
import 'package:app_ru/models/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'user_controller.dart';

class FirebaseEventController extends GetxController {
  DateTime _selectedDate = DateTime.now();
  //Firestore
  CollectionReference eventf = eventsFirebase;
  //Stream para obtener los datos de firebase
  final Stream<QuerySnapshot> _eventsStream = eventsFirebase.snapshots();
  late StreamSubscription<Object?> streamSubscription;
  final _eventList = <Event>[].obs;
  //_evenList= eventStream();

  @override
  void onInit() {
    super.onInit();
    _eventList.bindStream(eventStream());
    print("on init");
  }

  //Getters
  get events => _eventList;
  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) {
    _selectedDate = date;
  }

  subscribeUpdates() async {
    streamSubscription = _eventsStream.listen((event) {
      _eventList.clear();
      event.docs.forEach((element) {
        _eventList.add(Event.fromSnapshot(element));
      });
      print("Got ${_eventList.length}");
    });
  }

  unsubscribeUpdates() {
    streamSubscription.cancel();
  }

  void addEvent(name, from, to, description, persCreadora, invitados,
      confirmados, color, imgName) {
    eventf
        .add({
          'name': name,
          'from': from,
          'to': to,
          'description': description,
          'persCreadora': persCreadora,
          'invitados': invitados,
          'confirmados': confirmados,
          'color': color,
          'imgName': imgName
        })
        .then((value) => print("Evento añadido"))
        .catchError((onError) => print("No se pudo añadir"));
  }

  void deleteEvent(Event event) {
    event.eventId.delete();
  }

  updateEvent(name, from, to, description, persCreadora, invitados, color,
      imgName, Event event) {
    event.eventId.update({
      'name': name,
      'from': from,
      'to': to,
      'description': description,
      'invitados': invitados,
      'color': color,
      'imgName': imgName
    });
  }

  static Stream<List<Event>> eventStream() {
    return eventsFirebase.snapshots().map((QuerySnapshot query) {
      List<Event> events = [];
      for (var event in query.docs) {
        final _events = Event.fromSnapshot(event);
        events.add(_events);
      }
      print(events.length);
      return events;
    });
  }

  void findevents() async {
    UserController userController = Get.find();
    var query =
        eventsFirebase.where('persCreadora', isEqualTo: "Usuario actual");
    QuerySnapshot evento = await query.get();
    _eventList.clear();
    evento.docs.forEach((element) {
      _eventList.add(Event.fromSnapshot(element));
      print(Event.fromSnapshot(element).name);
    });
  }

  /*void findevents() async {
    var query =
        eventsFirebase.where('persCreadora', isEqualTo: "Usuario actual");
    QuerySnapshot evento = await query.get();
    List<Event> events = [];
    for (var event in evento.docs) {
      final _events = Event.fromDocumentSnapshot(documentSnapshot: event);
      events.add(_events);
    }
    eventList = events.obs;
  }*/
}
