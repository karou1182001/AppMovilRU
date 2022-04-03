import 'package:app_ru/domain/constants/color.dart';
import 'package:app_ru/models/friend.dart';
import 'package:app_ru/ui/pages/pageFriends/selectedfriend.dart';
import 'package:flutter/material.dart';

import '../../widgets/friendcard.dart';

class FriendsList extends StatefulWidget {
  const FriendsList({Key? key}) : super(key: key);

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  List<Friend> entries = <Friend>[];

  void initState() {
    entries.add(const Friend(
        name: "Alejandro Vertel",
        email: "vertel@uninorte.edu.co",
        imgUrl: "https://pps.whatsapp.net/v/t61.24694-24/255159378_1025571168234367_8655761191054013483_n.jpg?ccb=11-4&oh=49c8061945288b47442494c534b722eb&oe=62509955",
        descripcion: "Me encantan las tortujas y bailar",
        number: "3183745902",
        online: true,
        scheduleUrl: "",
        ));

        entries.add(const Friend(
        name: "Pepe Perez",
        email: "perezp@uninorte.edu.co",
        imgUrl: "data:image/jpeg;base64,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",
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
