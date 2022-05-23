import 'dart:async';

import 'package:app_ru/domain/constants/constants/firabase_constants.dart';
import 'package:app_ru/domain/constants/controllers/authentication_controller.dart';
import 'package:app_ru/models/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../constants/storage_repo.dart';

class FirebaseEventController extends GetxController {
  DateTime _selectedDate = DateTime.now();
  //Firestore
  CollectionReference eventf = eventsFirebase;
  //Stream para obtener los datos de firebase
  final Stream<QuerySnapshot> _eventsStream = eventsFirebase.snapshots();
  late StreamSubscription<Object?> streamSubscription;
  final _eventList = <Event>[].obs;
  final _eventListofUser = <Event>[].obs;
  final _eventsearch = <Event>[].obs;
  RxString url = ''.obs;
  final RxList<dynamic> _invitedEventsList = RxList<Event>([]);

  @override
  void onInit() {
    super.onInit();
    //Inicia actualizando los eventos del usuario
    findeventsOfUser();
    findInvitation();
  }

  //Getters
  get allEvents => _eventList;
  get eventsOfUser => _eventListofUser;
  DateTime get selectedDate => _selectedDate;
  get invitedList => _invitedEventsList;

  void setDate(DateTime date) {
    _selectedDate = date;
  }

  subscribeUpdates() async {
    //Actualiza todos los eventos
    streamSubscription = _eventsStream.listen((event) {
      _eventList.clear();
      event.docs.forEach((element) {
        _eventList.add(Event.fromSnapshot(element));
      });
      findeventsOfUser();
      print("Got ${_eventList.length}");
    });
  }

  unsubscribeUpdates() {
    streamSubscription.cancel();
  }

  //Añadir eventos a Firebase
  void addEvent(name, from, to, description, persCreadora, invitados, publico,
      confirmados, color, imgName) async {
    await eventf
        .add({
          'name': name,
          'from': from,
          'to': to,
          'description': description,
          'persCreadora': persCreadora,
          'invitados': invitados,
          'confirmados': confirmados,
          'publico': publico,
          'color': color,
          'imgName': imgName
        })
        .then((value) => print("Evento añadido"))
        .catchError((onError) => print("No se pudo añadir"));
    findeventsOfUser();
  }

  //Eliminar eventos de Firebase
  void deleteEvent(Event event) async {
    StorageRepo storage = StorageRepo();
    await event.eventId.delete();
    //Eliminamos la imagen del storage
    storage.deleteFileEvent(event.name);
    findeventsOfUser();
  }

  //Actualizar eventos de firebase
  updateEvent(name, from, to, description, persCreadora, invitados, publico,
      color, imgName, Event event) async {
    await event.eventId.update({
      'name': name,
      'from': from,
      'to': to,
      'description': description,
      'invitados': invitados,
      'publico': publico,
      'color': color,
      'imgName': imgName
    });
    findeventsOfUser();
  }

  addConfirm(Event event, String? confirm) async {
    await event.eventId.update({
      'confirmados': FieldValue.arrayUnion([confirm])
    });
  }

  //Métodos para imagen
  void changeEventPicture(String filePath, String eventId) async {
    StorageRepo storage = StorageRepo();
    await storage.uploadFileEvent(filePath, eventId);
    url.value = await storage.retrieveFileEvent(eventId);
  }

  Future<void> getEventUrl(String eventId) async {
    StorageRepo storage = StorageRepo();
    try {
      url.value = await storage.retrieveFileEvent(eventId);
    } catch (e) {
      url.value = "";
    }
  }

  findInvitation() async {
    AuthenticationController authController = Get.find();
    var queryInvited = await eventsFirebase.where('invitados',
        arrayContains: authController.auth.currentUser!.email);
    QuerySnapshot invited = await queryInvited.get();
    _invitedEventsList.clear();
    invited.docs.forEach((element) {
      _invitedEventsList.add(Event.fromSnapshot(element));
      print(Event.fromSnapshot(element).name);
    });
  }

  acceptInvitation(String eventName) async {
    AuthenticationController authController = Get.find();
    var queryAcceptInvite = eventsFirebase.where('name', isEqualTo: eventName);
    QuerySnapshot inviteAccepted = await queryAcceptInvite.get();
    inviteAccepted.docs.forEach((element) {
      element.reference.update({
        'invitados':
            FieldValue.arrayRemove([authController.auth.currentUser!.email]),
        'confirmados':
            FieldValue.arrayUnion([authController.auth.currentUser!.email])
      });
    });
  }

  denyInvitation(String eventName) async {
    AuthenticationController authController = Get.find();
    var queryAcceptInvite = eventsFirebase.where('name', isEqualTo: eventName);
    QuerySnapshot inviteAccepted = await queryAcceptInvite.get();
    inviteAccepted.docs.forEach((element) {
      element.reference.update({
        'invitados':
            FieldValue.arrayRemove([authController.auth.currentUser!.email]),
      });
    });
  }

  static Stream<List<Event>> eventStream() {
    return eventsFirebase.snapshots().map((QuerySnapshot query) {
      List<Event> events = [];
      for (var event in query.docs) {
        final _events = Event.fromSnapshot(event);
        events.add(_events);
      }
      print(events.length);
      return events;
    });
  }

  void findeventsOfUser() async {
    AuthenticationController authController = Get.find();
    //Consulta a realizar
    //Busca todos los eventos a los que el usuario ha confirmado asistir
    var query = eventsFirebase.where('confirmados',
        arrayContains: authController.auth.currentUser!.email);
    QuerySnapshot evento = await query.get();
    _eventListofUser.clear();
    evento.docs.forEach((element) {
      _eventListofUser.add(Event.fromSnapshot(element));
      print(Event.fromSnapshot(element).name);
    });
    update();
  }

  void getSearch(String text) async {
    var query = eventsFirebase.where('name', arrayContains: text);
    QuerySnapshot eventos = await query.get();
    _eventsearch.clear();
    eventos.docs.forEach((element) {
      _eventsearch.add(Event.fromSnapshot(element));
      print("eventos iguales: " + Event.fromSnapshot(element).name);
    });
  }
}
