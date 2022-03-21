import 'package:app_ru/domain/constants/color.dart';
import 'package:app_ru/models/events.dart';
import 'package:app_ru/ui/pages/selectedevent.dart';
import 'package:flutter/material.dart';

import '../widgets/navbar/eventcard.dart';

class EventosList extends StatefulWidget {
  EventosList({Key? key}) : super(key: key);

  @override
  State<EventosList> createState() => _EventosListState();
}

class _EventosListState extends State<EventosList> {
  List<Events> entries = <Events>[];

  void initState() {
    entries.add(Events("Salir de clase", DateTime.now(),
        "Salir de clase y no volver más", Colors.blue, "1"));
    entries.add(Events("Discución intelectual", DateTime.now(),
        "Nos creemos intelectuales y dicutimos", Colors.green, "0"));
    entries
        .add(Events("Sufrimiento", DateTime.now(), "Si", Colors.yellow, "1"));
    entries.add(Events("Intercambio de rocas", DateTime.now(),
        "Reunion anual de entusiastas de rocas", Colors.red, "0"));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
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
