import 'package:app_ru/models/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDb {
  static addEvent(Event event) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    await firebaseFirestore.collection('events').add({
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
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    return firebaseFirestore
        .collection('events')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Event> events = [];
      for (var event in query.docs) {
        final _events = Event.fromDocumentSnapshot(documentSnapshot: event);
        events.add(_events);
      }
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
    FirebaseAuth auth = FirebaseAuth.instance;
    firebaseFirestore.collection('events').doc(documentId).delete();
  }
}
