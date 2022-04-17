import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String? eventId;
  late String name;
  late DateTime from;
  late DateTime to;
  late String description;
  late String persCreadora;
  late List invitados;
  late int color;
  late String imgName;

  Event({
    required this.name,
    required this.from,
    required this.to,
    required this.description,
    required this.persCreadora,
    required this.invitados,
    required this.color,
    required this.imgName,
  });

  Event.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    eventId = documentSnapshot.id;
    name = documentSnapshot['name'];
    from = documentSnapshot['from'];
    to = documentSnapshot['to'];
    description = documentSnapshot['description'];
    persCreadora = documentSnapshot['persCreadora'];
    invitados = documentSnapshot['invitados'];
    color = documentSnapshot['color'];
    imgName = documentSnapshot['imgName'];
  }
}
