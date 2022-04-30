//Esta clase es para mostrar los eventos de un día particular como una timeline
import 'package:app_ru/ui/pages/pageMyCalendar/event_data_source.dart';
import 'package:app_ru/ui/pages/pageMyCalendar/event_viewing_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../../domain/constants/constants/color.dart';
import '../../../domain/constants/controllers/firebaseevent_controller.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({Key? key}) : super(key: key);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    FirebaseEventController feventCont = Get.find();
    final selectedEvents = feventCont.eventsOfUser;
    if (selectedEvents.isEmpty) {
      return const Center(
        child: Text(
          "No hay eventos agendados este día",
          style: TextStyle(color: black, fontSize: 24),
        ),
      );
    }

    return SfCalendarTheme(
      data: SfCalendarThemeData(),
      child: SfCalendar(
        view: CalendarView.timelineDay,
        dataSource: EventDataSource(feventCont.eventsOfUser),
        //Para que como día inicial, se muestre el día que oprimió la persona
        initialDisplayDate: feventCont.selectedDate,
        appointmentBuilder: appointmentBuilder,
        onTap: (details) {
          if (details.appointments == null) return;

          final event = details.appointments!.first;
          //Vamos a una nueva página para ver los datos del evento
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EventViewingPage(event: event)));
        },
      ),
    );
  }

  Widget appointmentBuilder(
      BuildContext context, CalendarAppointmentDetails details) {
    final event = details.appointments.first;
    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
          color: Color(event.color).withOpacity(0.5),
          borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Text(
          event.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
