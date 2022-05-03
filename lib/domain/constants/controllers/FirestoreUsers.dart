import 'package:app_ru/domain/constants/constants/firabase_constants.dart';
import 'package:app_ru/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirestoreDb {
  static addUser(User user) async {
    await userFirebase.add({
      'name': user.name,
      'number': user.number,
      'email': user.email,
      'description': user.description,
      'latitude': user.latitude,
      'longitude': user.longitude,
      'id':user.id,
      'friends': user.friends,
    });
  }

  static Stream<List<User>> userStream() {
    return userFirebase.snapshots().map((QuerySnapshot query) {
      List<User> users = [];
      for (var user in query.docs) {
        final _users = User.fromDocumentSnapshot(documentSnapshot: user);
        users.add(_users);
      }
      print(users.length);
      return users;
    });
  }
}