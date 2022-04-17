import 'package:app_ru/domain/constants/constants/color.dart';
import 'package:app_ru/domain/constants/controllers/event_controller.dart';
import 'package:app_ru/models/event.dart';
import 'package:app_ru/ui/pages/pageEvents/selectedevent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widgets/eventcard.dart';

class EventosList extends StatefulWidget {
  const EventosList({Key? key}) : super(key: key);

  @override
  State<EventosList> createState() => _EventosListState();
}

class _EventosListState extends State<EventosList> {
  List<Event> entries = <Event>[];

  void initState() {}

  Widget build(BuildContext context) {
    Get.put(EventController());
    EventController eventslsit = Get.find();
    entries = eventslsit.events;
    return Scaffold(
      //AppBar
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
          ))
        ]),
      ),
    );
  }
}
