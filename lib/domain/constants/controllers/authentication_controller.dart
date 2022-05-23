
import 'package:app_ru/ui/widgets/navbar/nav_bar.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../ui/pages/pageInicioyRegistro/inicio.dart';


class AuthenticationController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  late Rx<GoogleSignInAccount?> googleSignInAccount;
  GoogleSignIn googleSign = GoogleSignIn();
  late Rx<User?> firebaseUser;

  @override
  void onReady() {
    super.onReady();
    // auth is comning from the constants.dart file but it is basically FirebaseAuth.instance.
    // Since we have to use that many times I just made a constant file and declared there

    firebaseUser = Rx<User?>(auth.currentUser);
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);

    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);

    googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSignInAccount, _setInitialScreenGoogle);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      // if the user is not found then the user is navigated to the Register Screen
      Get.offAll(() => MenuInicio());
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
      Get.offAll(() => NavBar());
    }
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    print(googleSignInAccount);
    if (googleSignInAccount == null) {
      // if the user is not found then the user is navigated to the Register Screen
      Get.offAll(() => MenuInicio());
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
      Get.offAll(() => NavBar());
    }
  }

  void signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await auth
            .signInWithCredential(credential)
            .catchError((onErr) => print(onErr));
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e.toString());
    }
  }

  Future<void> register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (firebaseAuthException) {}
  }

  Future<bool> login(theEmail, thePassword) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: theEmail, password: thePassword);
      //Leemos la info del usuario actual
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('NOK 1');
        return Future.value(false);
      } else if (e.code == 'wrong-password') {
        print('NOK 2');
        return Future.value(false);
      }
    }
    return Future.value(false);
  }

  void signOut() async {
    await auth.signOut();
  }
}
