import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  Future<void> login(theEmail, thePassword) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: theEmail, password: thePassword);
      print('OK');
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('NOK 1');
        return Future.error("User not found");
      } else if (e.code == 'wrong-password') {
        print('NOK 2');
        return Future.error("Wrong password");
      }
    }
    print('NOK');
  }
}
