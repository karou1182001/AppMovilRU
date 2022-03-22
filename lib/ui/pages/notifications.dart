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
          ),
        ),
        body: ListView(children: [
          getCardFriend('John Doe'),
          getCardFriend('Joanna Doe'),
          getCardFriend('Piter Doe')
        ]));
  }

  Widget getCardFriend(String username) {
    return Card(
        child: Padding(
      padding: EdgeInsets.only(top: 8),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$username",
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(height: 10),
                Container(
                  width: 160,
                  child: Text(
                    "Quiere ser tu amigo",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            estiloBtn('Aceptar', Colors.amber, Colors.black),
            estiloBtn('Rechazar', Colors.black, Colors.white)
          ],
        ),
      ),
    ));
  }

  ElevatedButton estiloBtn(String text, Color color, Color txtColor) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.resolveWith((states) => color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)))),
        onPressed: () {},
        child: Text(
          text,
          style: TextStyle(color: txtColor),
        ));
  }
}
