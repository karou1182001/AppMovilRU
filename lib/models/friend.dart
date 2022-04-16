
import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Friend {
  final String name;
  final String email;
  final AssetImage imgUrl;
  final String descripcion;
  final String number;
  final bool online;
  final AssetImage scheduleUrl;
  final String userid;
  const Friend({
    required this.name,
    required this.email,
    required this.imgUrl,
    required this.descripcion,
    required this.number,
    required this.online,
    required this.scheduleUrl,
    required this.userid,
  });
}