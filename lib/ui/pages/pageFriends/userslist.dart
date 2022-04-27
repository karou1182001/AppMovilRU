import 'package:app_ru/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_ru/ui/pages/pageFriends/userslist.dart';
import '../../../domain/constants/controllers/user_controller.dart';
import '../../widgets/friendcard.dart';
import '../../widgets/usercard.dart';
import 'package:get/get.dart';
class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList>{
List<User> entries = <User>[];


  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    UserController usersList = Get.find();
    entries = usersList.users;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset("assets/logo_appbar.png", height: 60, width: 50),
        ),
      ),
        body: Container(
          child: ListView.builder(
                  itemCount: entries.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return Usercard(
                    user: entries[index],
                    onEventClick: () {
                      null;
                    },
                );
              })
        ),
  );
  }
}

