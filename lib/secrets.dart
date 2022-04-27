//Este archivo es para obtener las credenciales para poder conectar con el
//calendario de google
import 'dart:io' show Platform;

class Secret {
  static const ANDROID_CLIENT_ID =
      "629335196050-2tu9l3mt847s2rqgp1m39rst32nnevcd.apps.googleusercontent.com";
  static const WEB_CLIENT_ID =
      "629335196050-qfb1pe9eha4bubd9kut8qim9nocq1tq2.apps.googleusercontent.com";
  static String getId() =>
      Platform.isAndroid ? Secret.ANDROID_CLIENT_ID : Secret.WEB_CLIENT_ID;
}
