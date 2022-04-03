import 'package:app_ru/domain/constants/color.dart';
import 'package:app_ru/models/friend.dart';
import 'package:app_ru/ui/pages/pageFriends/selectedfriend.dart';
import 'package:flutter/material.dart';

import '../../widgets/friendcard.dart';

class FriendsList extends StatefulWidget {
  FriendsList({Key? key}) : super(key: key);

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  List<Friend> entries = <Friend>[];

  void initState() {
    entries.add(const Friend(
        name: "Alejandro Vertel",
        email: "vertel@uninorte.edu.co",
        imgUrl: "",
        descripcion: "Me encantan las tortujas y bailar",
        number: "3183745902",
        online: true,
        scheduleUrl: "",
        ));

        entries.add(const Friend(
        name: "Joshua Angarita",
        email: "ajoshua@uninorte.edu.co",
        imgUrl: "",
        descripcion: "Me gustan los juegos de mesa",
        number: "3183762807",
        online: true,
        scheduleUrl: "",
        ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
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
              return Friendcard(
                  friend: entries[index],
                  onEventClick: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectedFriend(
                                  selectedfriend: entries[index],
                                )));
                  });
            },
          ))
        ]),
      ),
    );
  }
}
