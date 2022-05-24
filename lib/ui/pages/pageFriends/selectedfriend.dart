
import 'dart:async';
import 'package:app_ru/models/users.dart';
import 'package:app_ru/ui/pages/pageFriends/selectedFriendMap.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_ru/domain/constants/constants/text_style.dart';
import '../../../domain/constants/constants/color.dart';
import '../../../domain/constants/constants/firabase_constants.dart';

class SelectedFriend extends StatelessWidget {
  Users selectedfriend;
  CollectionReference userf = userFirebase;
  //Stream para obtener los datos de firebase
  final Stream<QuerySnapshot> _userStream = userFirebase.snapshots();
  late StreamSubscription<Object?> streamSubscription;
  SelectedFriend({required this.selectedfriend});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: white,
          title: Image.asset("assets/logo_appbar.png", height: 60, width: 50),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: Center(
                child: Text(
                  'Profile',
                  style: generalText(Colors.black, 32),
                ),
              ),
            ),
            //Imagen de perfil
              SizedBox(
                height: 115,
                width: 115,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(selectedfriend.url),
                  radius: 60,
                )),
            const SizedBox(height: 10),
            //Nombre del usuario
            Text(selectedfriend.name, style: generalText(Colors.black, 18)),
            const SizedBox(height: 15),
            //Descripción
            Text(selectedfriend.description, style: generalText(Colors.grey, 15)),
            const SizedBox(height: 30),
            //Celular
            Container(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.phone),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('Celular: '+ selectedfriend.number,
                        style: generalText(Colors.black, 15)),
                  ],
                )),
            const SizedBox(
              height: 15,
            ),
            //Parte del switch de RU?, que indica si el usuario se encuentra en la U o no.
            Container(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('RU?', style: generalText(Colors.black, 15)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: selectedfriend.color,
                          border: Border.all(
                            width: 1
                          )
                        ),
                      ),
                    )
                  ],
                )),
            const SizedBox(
              height: 15,
            ),
            Container(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.calendar_today),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('Horario', style: generalText(Colors.black, 15)),
                  ],
                )),
            const SizedBox(height: 10),
            Container(
                height: MediaQuery.of(context).size.height * 0.2,
                child:  Image(image: NetworkImage(selectedfriend.urlSchedule))
                ),
            const SizedBox(
              height: 15,
            ),
            Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 220),
                    child: ElevatedButton(
                        key: const Key('Track Friend'),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18))),
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.black)),
                        onPressed: () {
                          streamSubscription = _userStream.listen((user) {
                            if(user.docs.singleWhere((element) => element['id']==selectedfriend.email)['ru']){
                              Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  SelectedFriendMap(selectedfriend.email)));
                            }else{
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Accion Denegada'),
                                  content: const Text('Este usuario no esta compartiendo su localizacion'),
                                  actions: <Widget>[
                                    FlatButton(onPressed:() {Navigator.of(context).pop();} , child: Text('OK'))
                                  ],
                                )
                              );
                            }
                           });
                          
                          
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.directions, color: Colors.white),
                            const SizedBox(width: 10),
                            Text(
                              'Track',
                              style: generalText(Colors.white, 15),
                            ),
                          ],
                        )),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}