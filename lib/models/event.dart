import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  DocumentReference eventId;
  late String name;
  late String from;
  late String to;
  late String description;
  late String persCreadora;
  late List invitados;
  late List confirmados;
  late int color;
  late String imgName;

  /*Event({
    required this.eventId,
    required this.name,
    required this.from,
    required this.to,
    required this.description,
    required this.persCreadora,
    required this.invitados,
    required this.color,
    required this.imgName,
  });*/

  Event.fromMap(Map<String, dynamic> map, {required this.eventId})
      : assert(map['name'] != null),
        assert(map['from'] != null),
        assert(map['to'] != null),
        assert(map['description'] != null),
        assert(map['persCreadora'] != null),
        assert(map['invitados'] != null),
        assert(map['confirmados'] != null),
        assert(map['color'] != null),
        assert(map['imgName'] != null),
        name = map['name'],
        from = map['from'],
        to = map['to'],
        description = map['description'],
        persCreadora = map['persCreadora'],
        invitados = map['invitados'],
        confirmados = map['confirmados'],
        color = map['color'],
        imgName = map['imgName'];

  Event.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            eventId: snapshot.reference);
}
