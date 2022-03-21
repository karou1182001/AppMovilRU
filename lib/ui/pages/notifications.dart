import 'package:app_ru/domain/constants/color.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
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
        body: ListView(children: [
          getCard('John Doe'),
          getCard('Joanna Doe'),
          getCard('Piter Doe')
        ]));
  }

  Widget getCard(String username) {
    return Card(
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: ListTile(
        title: Row(
          children: <Widget>[
            Container(),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "$username",
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(height: 10),
                Container(
                  width: 250,
                  child: Text(
                    "Quiere ser tu amigo",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
