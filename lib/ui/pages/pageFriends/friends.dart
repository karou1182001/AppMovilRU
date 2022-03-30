import 'package:app_ru/domain/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:app_ru/domain/constants/text_style.dart';

class Friends extends StatefulWidget {
  const Friends({Key? key}) : super(key: key);

  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  int widgetType = 0;
  String actualFriendName = "gg";
  String actualFriendMail = "gg";
  String actualFriendImg = "gg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    if (widgetType == 0) {
      return friendsList();
      
    } else {
      return getFriendWidget(
          actualFriendName, actualFriendMail, actualFriendImg);
    }
  }


  Widget friendsList(){
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
      body: (
        ListView(
        children: [
          getCard("Alejandro Vertel","vertel@uninorte.edu.co","https://pps.whatsapp.net/v/t61.24694-24/255159378_1025571168234367_8655761191054013483_n.jpg?ccb=11-4&oh=b9dda4905db512f22fcd0fc126f0b18b&oe=623B8155"),
        ],
      )
      )
    );
  }
  void getFriendInfo(String fullName, String email, String imgUrl) {
    setState(() {
      widgetType = 1;
      actualFriendName = fullName;
      actualFriendMail = email;
      actualFriendImg = imgUrl;
    });
  }

  Widget getFriendWidget(String name, String email, String imgUrl) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: white,
          title: Image.asset("assets/logo_appbar.png", height: 60, width: 50),
          actions:  [
            IconButton(onPressed: () => setState(() => widgetType = 0), icon: const Icon(Icons.arrow_back),color: Colors.amber,)
          ],
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
                  'Perfil',
                  style: generalText(Colors.black, 32),
                ),
              ),
            ),
            //Imagen de perfil
            SizedBox(
                height: 115,
                width: 115,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(imgUrl),
                  radius: 60,
                )),
            SizedBox(height: 10),
            //Nombre del usuario
            Text(name, style: generalText(Colors.black, 18)),
            SizedBox(height: 15),
            //Descripción
            Text('Me gustan las tortugas', style: generalText(Colors.grey, 15)),
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
                    Text('Celular: 3183762809',
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
                child: Image(image: AssetImage('assets/horario.png'))),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget getCard(String fullName, String email, String imgUrl) {
    return GestureDetector(
        onTap: () => setState(() {
              widgetType = 1;
              getFriendInfo(fullName, email, imgUrl);
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
