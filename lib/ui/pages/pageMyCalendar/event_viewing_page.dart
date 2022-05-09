//En esta clase podemos ver un evento que ya ha sido editado
import 'package:app_ru/domain/constants/controllers/user_controller.dart';
import 'package:app_ru/models/event.dart';
import 'package:app_ru/ui/pages/pageMyCalendar/event_editing_page.dart';
import 'package:app_ru/ui/pages/pageMyCalendar/utils.dart';
import 'package:app_ru/ui/widgets/navbar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/constants/constants/color.dart';
import '../../../domain/constants/controllers/firebaseevent_controller.dart';

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
        padding: const EdgeInsets.all(32),
        children: <Widget>[
          buildDateTime(event),
          const SizedBox(height: 32),
          buildHeader(
            header: "Nombre",
            child: Text(
              event.name,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 24),
          buildHeader(
            header: "Descripción",
            child: Text(
              event.description,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 24),
          buildHeader(
            header: "Autor",
            child: Text(
              event.persCreadora,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 24),
          buildHeader(
            header: "Invitados",
            child: Text(
              event.invitados.join("\n"),
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 24),
          buildHeader(
            header: "Confirmados",
            child: Text(
              event.confirmados.join("\n"),
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 24),
          buildHeader(header: "Tipo de evento", child: widgetPublico()),
          const SizedBox(height: 24),
          showColor()
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
              fontSize: 18, fontWeight: FontWeight.bold, color: selectColor),
        ),
        const SizedBox(height: 10),
        imagen(),
        const SizedBox(height: 32),
        buildDate("From:", DateTime.parse(event.from)),
        const SizedBox(height: 32),
        buildDate("To:     ", DateTime.parse(event.to))
      ],
    );
  }

  Widget buildHeader({required String header, required Widget child}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 20,
          ),
          child,
        ],
      );

  Widget showColor() => Row(
        children: [
          const Text(
            "Color evento",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(event.color))),
            child: const Text(""),
          ),
        ],
      );

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
    UserController userController = Get.find();
    if (userController.email == event.persCreadora) {
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
            //Get.put(EventController());
            //EventController eventCont = Get.find();
            Get.put(FirebaseEventController());
            FirebaseEventController feventCont = Get.find();

            feventCont.deleteEvent(event);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const NavBar()),
                (route) => false);
          },
        ),
      ];
    } else {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.playlist_remove_sharp),
          onPressed: () {
            //Eliminamos al usuario de los invitados y y confirmados del evento
            event.invitados.remove(userController.email);
            event.confirmados.remove(userController.email);
            //Actualizamos la base de datos
            event.eventId.update({
              'invitados': event.invitados,
              'confirmados': event.confirmados
            });
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const NavBar()),
                (route) => false);
          },
        )
      ];
    }
  }

  Widget widgetPublico() {
    if (event.publico == true) {
      return const Text("Público", style: TextStyle(fontSize: 18));
    } else {
      return const Text("Privado", style: TextStyle(fontSize: 18));
    }
  }

  Widget imagen() {
    FirebaseEventController feventCont = Get.find();
    feventCont.getProfileUrl(event.name);
    return Container(
        height: 115,
        width: 115,
        decoration:
            BoxDecoration(border: Border.all(width: 3), shape: BoxShape.circle),
        child: (feventCont.url.value != '')
            ? CircleAvatar(backgroundImage: NetworkImage(feventCont.url.value))
            : const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://www.meteorologiaenred.com/wp-content/uploads/2018/02/olas.jpg')));
  }
}
