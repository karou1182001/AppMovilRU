//Esta clase es para que cuando el usuario seleccione un día particular,
//podamos tomar los datos para mostrar los eventos de ese día
import 'package:app_ru/models/event.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(RxList<dynamic> appointments) {
    this.appointments = appointments;
  }

  Event getEvent(int index) => appointments![index] as Event;

  //Métodos
  @override
  DateTime getStartTime(int index) => getEvent(index).from;

  @override
  DateTime getEndTime(int index) => getEvent(index).to;

  @override
  String getSubject(int index) => getEvent(index).name;
}
