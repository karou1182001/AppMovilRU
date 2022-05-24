//Esta página es la principal donde se muestra todo el calendario
//Tutorial útil: https://help.syncfusion.com/flutter/calendar/getting-started
//Sincronizar sfcalendar con google calendar:
//https://www.syncfusion.com/kb/12116/how-to-add-google-calendar-events-to-the-flutter-event-calendar-sfcalendar
//https://youtu.be/LoDtxRkGDTw
///-----------------------Librerías--------------------------------------
import 'package:app_ru/domain/constants/constants/color.dart';
import 'package:app_ru/ui/pages/pageMyCalendar/event_data_source.dart';
import 'package:app_ru/ui/pages/pageMyCalendar/event_editing_page.dart';
import 'package:app_ru/ui/pages/pageMyCalendar/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//Para poder usar el widget calendar
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../domain/constants/controllers/firebaseevent_controller.dart';

class MyCalendar extends StatefulWidget {
  @override
  State<MyCalendar> createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  final FirebaseEventController feventCont = Get.find();
  RxList<dynamic> events = [].obs;

  @override
  void initState() {
    FirebaseEventController cont = Get.find();
    cont.onInit();
    cont.subscribeUpdates();
    //loadData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /*loadData() {
    final eventos = feventCont.eventsOfUser;

    setState(() {
      events = eventos;
      print("Me actualicé");
    });
  }*/

  //-----------------------DISEÑO DE INTERFAZ-------------------------------
  @override
  Widget build(BuildContext context) {
    //Get.put(FirebaseEventController());
    //FirebaseEventController feventCont = Get.find();
    //final events = feventCont.eventsOfUser;
    //print("AQUI");
    //print(events);
    return GetBuilder<FirebaseEventController>(
      //id: "idCalendar",
      init: FirebaseEventController(),
      builder: (feventCont) {
        print("Me reparo");
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: white,
              title:
                  Image.asset("assets/logo_appbar.png", height: 60, width: 50),
            ),
          ),
          body: SfCalendar(
              view: CalendarView.month, //Vista de mes por defecto
              showDatePickerButton: true,
              initialSelectedDate: feventCont.selectedDate,
              dataSource: EventDataSource(feventCont.eventsOfUser),
              onTap: (details) {
                feventCont.setDate(details.date!);
              },
              onLongPress: (details) {
                feventCont.setDate(details.date!);
                //Esto es para que se nos muestren todos los eventos que hay ese día
                showModalBottomSheet(
                    context: context, builder: (context) => const TaskWidget());
              },
              //Vistas permitidas entre las que puede ver el usuario
              allowedViews: const [
                CalendarView.day,
                CalendarView.timelineDay,
                CalendarView.week,
                CalendarView.workWeek,
                CalendarView.month,
              ],
              //Para que los meses se rueden de forma vertical
              monthViewSettings: const MonthViewSettings(
                navigationDirection: MonthNavigationDirection.vertical,
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                numberOfWeeksInView: 5,
                showAgenda: true,
                agendaViewHeight: 120,
              ),
              firstDayOfWeek: 1, //Lunes
              cellEndPadding: 5,

              //Decoración del día seleccionado
              selectionDecoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: selectColor, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                shape: BoxShape.rectangle,
              ),
              //Decoración del día actual
              todayHighlightColor: selectColor),

          //Botón flotante que nos permite crear un nuevo evento
          floatingActionButton: FloatingActionButton(
            key: Key('floatingbutton'),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const EventEditingPage())),
            //.whenComplete(() => loadData()),
            backgroundColor: selectColor,
            tooltip: 'Crea un nuevo evento',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
