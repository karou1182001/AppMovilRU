//Tutorial útil: https://help.syncfusion.com/flutter/calendar/getting-started
//Sincronizar sfcalendar con google calendar:
//https://www.syncfusion.com/kb/12116/how-to-add-google-calendar-events-to-the-flutter-event-calendar-sfcalendar
//https://youtu.be/LoDtxRkGDTw
///-----------------------Librerías--------------------------------------
import 'package:app_ru/domain/constants/color.dart';
import 'package:flutter/material.dart';
//Para poder usar el widget calendar
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MyCalendar extends StatelessWidget {
  const MyCalendar({Key? key}) : super(key: key);

  //-----------------------DISEÑO DE INTERFAZ-------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
          view: CalendarView.month, //Vista de mes por defecto
          initialSelectedDate: DateTime.now(),
          //cellBorderColor: Colors.transparent,
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
              navigationDirection: MonthNavigationDirection.vertical),
          firstDayOfWeek: 1, //Lunes
          //Decoración del día seleccionado
          selectionDecoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: selectColor, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            shape: BoxShape.rectangle,
          ),
          //Decoración del día actual
          todayHighlightColor: selectColor),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Aquí se pone lo que hará este botón");
        },
        backgroundColor: selectColor,
        tooltip: 'Crea un nuevo evento',
        child: const Icon(Icons.add),
      ),
    );
  }
}
