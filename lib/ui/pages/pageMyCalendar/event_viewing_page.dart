//En esta clase podemos ver un evento que ya ha sido editado
import 'package:app_ru/domain/constants/controllers/event_controller.dart';
import 'package:app_ru/models/event.dart';
import 'package:app_ru/ui/pages/pageMyCalendar/event_editing_page.dart';
import 'package:app_ru/ui/pages/pageMyCalendar/utils.dart';
import 'package:app_ru/ui/widgets/navbar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/constants/color.dart';

class EventViewingPage extends StatelessWidget {
  final Event event;

  const EventViewingPage({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //--------------------------------APPBAR-------------------------------------
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: colorp1,
          leading: const CloseButton(),
          title: Image.asset("assets/logo_appbar.png", height: 60, width: 50),
          actions: buildViewingActions(context, event),
        ),
      ),

      //--------------------------------BODY--------------------------------------
      body: ListView(
        padding: EdgeInsets.all(32),
        children: <Widget>[
          buildDateTime(event),
          const SizedBox(height: 32),
          Text(
            "Nombre: " + event.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            event.description,
            style: const TextStyle(
              fontSize: 18,
            ),
          )
        ],
      ),
    );

    //--------------------------------OTROS WIDGETS---------------------------
  }

  Widget buildDateTime(Event event) {
    return Column(
      children: [
        const Text(
          "Información del evento",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 32),
        buildDate("From:", event.from),
        const SizedBox(height: 32),
        buildDate("To:", event.to)
      ],
    );
  }

  Widget buildDate(String title, DateTime date) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 24),
        Text(
          Utils.toDate(date) + ", Hora: " + Utils.toTime(date),
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  List<Widget> buildViewingActions(BuildContext context, Event event) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => EventEditingPage(event: event),
          ),
        ),
      ),
      IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          Get.put(EventController());
          EventController eventCont = Get.find();

          eventCont.deleteEvent(event);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const NavBar()),
              (route) => false);
        },
      ),
    ];
  }
}
