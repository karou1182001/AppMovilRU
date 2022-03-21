//Esta clase va a tener la información de cada uno de los menú
import 'package:app_ru/ui/pages/calendar.dart';
import 'package:app_ru/ui/pages/friends.dart';
import 'package:app_ru/ui/pages/mycalendar.dart';
import 'package:app_ru/ui/pages/notifications.dart';
import 'package:app_ru/ui/pages/profile.dart';
import 'package:flutter/cupertino.dart';

class Model {
  final int id;
  final String imagePath;
  final String name;
  final Widget widget;

  Model(
      {required this.id,
      required this.imagePath,
      required this.name,
      required this.widget});
}

List<Model> navBtn = [
  Model(
      id: 0,
      imagePath: 'assets/icon/home.png',
      name: 'Home',
      widget: const Friends()),
  Model(
      id: 1,
      imagePath: 'assets/icon/search.png',
      name: 'Search',
      widget: const Calendar()),
  Model(
      id: 2,
      imagePath: 'assets/icon/heart.png',
      name: 'Like',
      widget: const MyCalendar()),
  Model(
      id: 3,
      imagePath: 'assets/icon/notification.png',
      name: 'notif',
      widget: const Notifications()),
  Model(
      id: 4,
      imagePath: 'assets/icon/user.png',
      name: 'Profile',
      widget: const Profile()),
];
