import 'package:app_ru/domain/constants/constants/color.dart';
import 'package:app_ru/domain/constants/controllers/user_controller.dart';
import 'package:app_ru/models/user.dart';
import 'package:app_ru/models/users.dart';
import 'package:app_ru/ui/pages/pageFriends/selectedfriend.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:app_ru/ui/pages/pageFriends/userslist.dart';

import '../../../domain/constants/controllers/firebaseuser_controller.dart';
import '../../widgets/usercard.dart';

class FriendsList extends StatefulWidget {
  const FriendsList({Key? key}) : super(key: key);

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  final FirebaseUserController fuserCont = Get.find();
  List<Users> entries = <Users>[];
 void initState(){
    FirebaseUserController fuserCont = Get.find();
    fuserCont.onInit();
    fuserCont.subscribeUpdates();
    loadData();
    super.initState();
  }
  loadData() async {
    final users = await fuserCont.friendsOfUser;
    
    setState(() {
      entries = users;
      print('hay un total de '+entries.length.toString());
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: white,
          title: Image.asset("assets/logo_appbar.png", height: 60, width: 50),
          actions: const [
            IconButton(onPressed: null, icon: Icon(Icons.search))
          ],
        ),
      ),
      body: Container(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                'Friends',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 20),
              )),
          Expanded(
              child: ListView.builder(
            itemCount: entries.length,
            itemBuilder: (BuildContext ctx, int index) {
              return Usercard(
                  user: entries[index],
                  onEventClick: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectedFriend(
                                  selectedfriend: entries[index],
                                )
                              )
                            );
                  },
                );
            },
          ))
          
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('floatingbutton'),
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) =>  UserList())),
        backgroundColor: selectColor,
        tooltip: 'Busca Usuarios',
        child: const Icon(Icons.add),
      ),
    );
  }
}
