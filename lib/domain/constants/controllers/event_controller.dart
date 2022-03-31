import 'package:app_ru/models/event.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  final RxList _events = [].obs;
  DateTime _selectedDate = DateTime.now();

  //Getters
  RxList get events => _events;
  DateTime get selectedDate => _selectedDate;
  RxList get eventsOfSelectedDate => _events;

  //Setters
  void addEvent(Event event) {
    _events.add(event);
  }

  void setDate(DateTime date) {
    _selectedDate = date;
  }

  //Otros

  void deleteEvent(Event event) {
    _events.remove(event);
  }

  void editEvent(Event newEvent, Event oldEvent) {
    final index = _events.indexOf(oldEvent);
    _events[index] = newEvent;
  }
}
