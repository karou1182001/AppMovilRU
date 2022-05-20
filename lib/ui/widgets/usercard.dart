
import 'package:app_ru/models/user.dart';
import 'package:app_ru/models/users.dart';
import 'package:flutter/material.dart';

class Usercard extends StatelessWidget {
  Users user;

  Function onEventClick;

  Usercard({required this.user, required this.onEventClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ()  {
              onEventClick();
            },
        key: Key(this.user.name),
        child: Card(
          child:
           ListTile(
            leading: CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(user.url),
            ),
            title: Text(this.user.name),
            subtitle: Text(this.user.email),
           )    
        )
        );
  }

  
}