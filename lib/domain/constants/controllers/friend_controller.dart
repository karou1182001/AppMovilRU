import 'package:app_ru/models/friend.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendController extends GetxController {
  final _friends = RxList<Friend>();
  

  //Getters
  get friends => _friends;
  RxList get friendsList => _friends;

  FriendController() {
    _friends.add(const Friend(
      name: "Alejandro Vertel",
      email: "vertel@uninorte.edu.co",
      imgUrl: AssetImage('assets/perfilvertel.jpg'),
      descripcion: "Me encantan las tortujas y bailar",
      number: "3183745902",
      online: true,
      scheduleUrl: "",
    ));

    _friends.add(const Friend(
      name: "David Ocampo",
      email: "davidocampo@uninorte.edu.co",
      imgUrl: AssetImage('assets/perfilocampo.jpg'),
      descripcion: "Me gustan los juegos de mesa",
      number: "3183762807",
      online: true,
      scheduleUrl: "",
    ));
  }
  //Setters
  void addFriend(Friend friend) {
    _friends.add(friend);
  }

}