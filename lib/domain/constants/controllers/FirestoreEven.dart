import 'package:app_ru/domain/constants/constants/firabase_constants.dart';
import 'package:app_ru/models/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDb {
  static addEvent(Event event) async {
    await eventsFirebase.add({
      'name': event.name,
      'from': event.from,
      'description': event.description,
      'persCreadora': event.persCreadora,
      'invitados': event.invitados,
      'color': event.color,
      'imgName': event.imgName
    });
  }

  static Stream<List<Event>> eventStream() {
    return eventsFirebase.snapshots().map((QuerySnapshot query) {
      List<Event> events = [];
      for (var event in query.docs) {
        final _events = Event.fromDocumentSnapshot(documentSnapshot: event);
        events.add(_events);
      }
      print(events.length);
      return events;
    });
  }

  //updateevento

  // static updateStatus(bool isDone, documentId) {
  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   firebaseFirestore
  //       .collection('usuario')
  //       .doc(auth.currentUser!.uid)
  //       .collection('events')
  //       .doc(documentId)
  //       .update(
  //     {
  //       'isDone': isDone,
  //     },
  //   );
  // }

  //Borrar evento

  static deleteEvent(String? documentId) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    firebaseFirestore.collection('events').doc(documentId).delete();
  }
}
