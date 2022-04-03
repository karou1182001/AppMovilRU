import 'package:app_ru/models/friend.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_ru/domain/constants/text_style.dart';
import '../../../domain/constants/color.dart';

class SelectedFriend extends StatelessWidget {
  Friend selectedfriend;

  SelectedFriend({required this.selectedfriend});

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(15),
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
                  backgroundImage: selectedfriend.imgUrl,
                  radius: 60,
                )),
            SizedBox(height: 10),
            //Nombre del usuario
            Text(this.selectedfriend.name, style: generalText(Colors.black, 18)),
            SizedBox(height: 15),
            //Descripción
            Text(this.selectedfriend.descripcion, style: generalText(Colors.grey, 15)),
            const SizedBox(height: 30),
            //Celular
            Container(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.phone),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('Celular: '+ this.selectedfriend.number,
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
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.red,
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
                child: Image(image: AssetImage('assets/horario.png'))
                ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}