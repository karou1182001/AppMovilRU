import 'package:app_ru/domain/constants/constants/color.dart';
import 'package:app_ru/domain/constants/controllers/user_controller.dart';
import 'package:app_ru/models/event.dart';
import 'package:app_ru/ui/pages/pageEvents/selectedevent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../domain/constants/controllers/firebaseevent_controller.dart';
import '../../widgets/eventcard.dart';

class EventosList extends StatefulWidget {
  const EventosList({Key? key}) : super(key: key);

  @override
  State<EventosList> createState() => _EventosListState();
}

//LISTA DE EVENTOS FILTRADOS

class Lists extends StatelessWidget {
  List<Event> entries = <Event>[];
  final String text;
  Lists({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    UserController user = Get.find();
    Get.put(FirebaseEventController());
    FirebaseEventController feventCont = Get.find();
    //Filtro eventos distintos del creador
    entries = feventCont.allEvents
        .where((e) => (e.persCreadora != user.email) == true)
        .toList();
    //Filtro de busqueda
    if (text.isNotEmpty) {
      var t = text.toLowerCase();
      entries = feventCont.allEvents
          .where((e) =>
              e.name.toLowerCase().contains(t) ||
              e.description.toLowerCase().contains(t))
          .toList();
    }
    return Expanded(
        child: ListView.builder(
      itemCount: entries.length,
      itemBuilder: (BuildContext ctx, int index) {
        //EventCard
        return Eventcard(
          event: entries[index],
          onEventClick: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SelectedEvent(
                          selectedevent: entries[index],
                        )));
          },
        );
      },
    ));
  }
}

class _EventosListState extends State<EventosList> {
  List<Event> entries = <Event>[];
  void initState() {}

//ESTRUCTURA DE LA PAGINA
  Widget build(BuildContext context) {
    TextEditingController textcont = TextEditingController();
    Get.put(UserController());
    Get.put(FirebaseEventController());
    FirebaseEventController feventCont = Get.find();
    return Scaffold(
      //AppBar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: white,
          title: Image.asset("assets/logo_appbar.png", height: 60, width: 50),
          actions: [
            SizedBox(
                width: 200,
                child: TextField(
                  controller: textcont,
                  onChanged: (value) {
                    //LO QUE PASA CUANDO SE MODIFICA EL TEXTFIELD
                  },
                )),
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
                'Eventos',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 20),
              )),
          Lists(text: textcont.text)
        ]),
      ),
    );
  }
}
