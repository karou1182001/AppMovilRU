//ESTILO GENERAL DE LA APLICACIÓN
import 'package:flutter/cupertino.dart';
import 'color.dart';

const TextStyle bntText = TextStyle(
  color: black,
  fontWeight: FontWeight.w500,
);

TextStyle generalText(Color color, double size) {
  return TextStyle(color: color, fontSize: size, fontWeight: FontWeight.w300);
}