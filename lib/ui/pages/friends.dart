import 'package:app_ru/domain/constants/color.dart';
import 'package:flutter/material.dart';

class Friends extends StatefulWidget {
  const Friends({Key? key}) : super(key: key);

  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  int widgetType = 0;
  String actualFriendName = "gg";
  String actualFriendMail = "gg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    if (widgetType == 0) {
      return ListView(
        children: [
          getCard(),
          getCard(),
          getCard(),
          getCard(),
        ],
      );
    } else {
      return getFriendWidget(actualFriendName, actualFriendMail);
    }
  }

  void getFriendInfo(String fullName, String email) {
    setState(() {
      widgetType = 1;
      actualFriendName = fullName;
      actualFriendMail = email;
    });
  }

  Widget getFriendWidget(String name, String email) {
    return Row(
      children: <Widget>[
        Text(name),
        Text(email),
      ],
    );
  }

  Widget getCard() {
    String fullName = "Alejandro Vertel";
    String email = "vertel@uninorte.edu.co";
    return GestureDetector(
        onTap: () => setState(() {
              widgetType = 1;
              getFriendInfo(fullName, email);
            }),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Row(
                children: <Widget>[
                  Container(),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "$fullName",
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 250,
                        child: Text(
                          "$email",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
