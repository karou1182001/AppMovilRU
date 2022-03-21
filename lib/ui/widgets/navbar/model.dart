//Esta clase va a tener la información para mostrar cada uno de los widget de la navbar
import 'package:app_ru/ui/pages/eventos.dart';
import 'package:app_ru/ui/pages/friends.dart';
import 'package:app_ru/ui/pages/mycalendar.dart';
import 'package:app_ru/ui/pages/notifications.dart';
import 'package:app_ru/ui/pages/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Model {
  final int id;
  final IconData icon;
  final String name;
  final Widget widget;

  Model(
      {required this.id,
      required this.icon,
      required this.name,
      required this.widget});
}

List<Model> navBtn = [
  Model(
      id: 0,
      icon: CupertinoIcons.person_2_fill,
      name: 'Amigos',
      widget:  Friends()),
  Model(
      id: 1,
      icon: CupertinoIcons.calendar_circle,
      name: 'Eventos',
      widget: EventosList()),
  Model(
      id: 2,
      icon: CupertinoIcons.calendar,
      name: 'Calendario',
      widget: const MyCalendar()),
  Model(
      id: 3,
      icon: Icons.notifications,
      name: 'Notif',
      widget: const Notifications()),
  Model(
      id: 4,
      icon: CupertinoIcons.profile_circled,
      name: 'Perfil',
      widget: const Profile()),
];
