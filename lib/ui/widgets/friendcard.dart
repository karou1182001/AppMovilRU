import 'package:app_ru/models/friend.dart';
import 'package:app_ru/models/user.dart';
import 'package:flutter/material.dart';

class Friendcard extends StatelessWidget {
  User friend;

  Function onEventClick;

  Friendcard({required this.friend, required this.onEventClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ()  {
              onEventClick();
            },
        key: Key(this.friend.name),
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
                        this.friend.name,
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 250,
                        child: Text(
                          this.friend.email,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
        );
  }
}