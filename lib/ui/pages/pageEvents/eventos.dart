import 'package:app_ru/domain/constants/constants/color.dart';
import 'package:app_ru/domain/constants/controllers/authentication_controller.dart';
import 'package:app_ru/models/event.dart';
import 'package:app_ru/ui/pages/pageEvents/selectedevent.dart';
import 'package:app_ru/ui/widgets/refreshWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/constants/controllers/firebaseevent_controller.dart';
import '../../widgets/eventcard.dart';
import '../../widgets/serchWidget.dart';

class EventosList extends StatefulWidget {
  const EventosList({Key? key}) : super(key: key);

  @override
  State<EventosList> createState() => _EventosListState();
}

class _EventosListState extends State<EventosList> {
  final FirebaseEventController feventCont = Get.find();
  AuthenticationController authController = Get.find();
  List<Event> entries = <Event>[];
  List<Event> entrie = <Event>[];
  List<String> url = <String>[];
  String query = '';
  void initState() {
    super.initState();

    FirebaseEventController feventCont = Get.find();
    feventCont.onInit();
    feventCont.subscribeUpdates();
    loadData();
  }

  Future loadData() async {
    print("LoadData");
    entrie = await feventCont.allEvents
        .where((e) =>
            (e.persCreadora != authController.auth.currentUser!.email) ==
                true &&
            e.confirmados.contains(authController.auth.currentUser!.email) ==
                false &&
            e.publico == true)
        .toList();
    int ind = 0;
    for (var evn in entrie) {
      await feventCont.getEventUrl(evn.name);
      url.add(feventCont.url.value);
    }
    setState(() {
      //Filtro eventos distintos del creador
      entries = entrie;
      print('hay un total de ' + entries.length.toString());
    });
  }

//ESTRUCTURA DE LA PAGINA
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: white,
          title: Image.asset("assets/logo_appbar.png", height: 60, width: 50),
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
          buildSearch(),
          Expanded(
              child: RefreshWidget(
                  onRefresh: loadData,
                  child: ListView.builder(
                    itemCount: entries.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      //EventCard
                      return Eventcard(
                        event: entries[index],
                        url: url[index],
                        onEventClick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectedEvent(
                                        selectedevent: entries[index],
                                        url: url[index],
                                      )));
                        },
                      );
                    },
                  )))
        ]),
      ),
    );
  }
  //widget de busqueda

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Busca eventos',
        onChanged: searchEvent,
      );

  void searchEvent(String query) {
    print("buscando evento");
    final events = entries.where((event) {
      final nameLower = event.name.toLowerCase();
      final searchLower = query.toLowerCase();
      return nameLower.contains(searchLower);
    }).toList();

    setState(() {
      print("Entries actualizado");
      this.query = query;
      if (query.isEmpty) {
        loadData();
      } else {
        this.entries = events;
      }
    });
  }
}
