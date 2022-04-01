import 'package:app_ru/domain/constants/color.dart';
import 'package:app_ru/models/event.dart';
import 'package:app_ru/ui/pages/pageEvents/selectedevent.dart';
import 'package:flutter/material.dart';

import '../../widgets/eventcard.dart';

class EventosList extends StatefulWidget {
  EventosList({Key? key}) : super(key: key);

  @override
  State<EventosList> createState() => _EventosListState();
}

class _EventosListState extends State<EventosList> {
  List<Event> entries = <Event>[];

  void initState() {
    entries.add(Event(
        name: "Salir de clase",
        from: DateTime.now(),
        to: DateTime.now(),
        description: "Salir de clase y no volver más",
        persCreadora: "Mateo",
        invitados: ["Chirstian", "Danna"],
        color: Colors.blue,
        imgName: "1"));

    entries.add(Event(
        name: "Discución intelectual",
        from: DateTime.now(),
        to: DateTime.now(),
        description: "Nos creemos intelectuales y discutimos",
        persCreadora: "Mateo",
        invitados: ["Chirstian", "Danna"],
        color: Colors.green,
        imgName: "0"));

    entries.add(Event(
        name: "Sufrimiento",
        from: DateTime.now(),
        to: DateTime.now(),
        description: "Sí",
        persCreadora: "Mateo",
        invitados: ["Chirstian", "Danna"],
        color: Colors.yellow,
        imgName: "1"));

    entries.add(Event(
        name: "Intercambio de rocas",
        from: DateTime.now(),
        to: DateTime.now(),
        description: "Reunion anual de entusiastas de rocas",
        persCreadora: "Mateo",
        invitados: ["Chirstian", "Danna"],
        color: Colors.red,
        imgName: "0"));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
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
                'Eventos',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 20),
              )),
          Expanded(
              child: ListView.builder(
            itemCount: entries.length,
            itemBuilder: (BuildContext ctx, int index) {
              return Eventcard(
                  event: entries[index],
                  onEventClick: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectedEvent(
                                  selectedevent: entries[index],
                                )));
                  });
            },
          ))
        ]),
      ),
    );
  }
}
