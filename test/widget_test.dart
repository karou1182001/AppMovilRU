import 'package:app_ru/ui/pages/pageFriends/friends.dart';
import 'package:app_ru/ui/pages/pageFriends/selectedfriend.dart';
import 'package:app_ru/models/event.dart';
import 'package:app_ru/ui/pages/pageEvents/eventos.dart';
import 'package:app_ru/ui/pages/pageEvents/selectedevent.dart';
import 'package:app_ru/ui/pages/pageMyCalendar/event_editing_page.dart';
import 'package:app_ru/ui/pages/pageMyCalendar/mycalendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_ru/main.dart';

void main() {
  //Test para crear un nuevo evento en el calendario
  testWidgets('Página del calendario', (WidgetTester tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: Scaffold(body: MyCalendar())));

    expect(find.byKey(const Key('floatingbutton')), findsOneWidget);
  });
  testWidgets('Agregar nuevo evento', (WidgetTester tester) async {
    await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: EventEditingPage())));

    expect(find.byKey(const Key('editableTitle')), findsOneWidget);
    expect(find.byKey(const Key('editableDescription')), findsOneWidget);
    expect(find.byKey(const Key('editableInvitados')), findsOneWidget);
    await tester.pump();
    await tester.enterText(find.byKey(const Key('editableTitle')), "Evento");
    await tester.pump();
    await tester.enterText(find.byKey(const Key('editableDescription')),
        "Al salir de clases ir a comer");
    await tester.pump();
    await tester.enterText(find.byKey(const Key('editableInvitados')), "Julia");
    await tester.tap(find.byKey(const Key('botonColor')));
    //await tester.pump();
    await tester.tap(find.byKey(const Key('botonSave')));
  });

  testWidgets('Ver lista amigos', (WidgetTester tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: Scaffold(body: FriendsList())));
    expect(find.byKey(const Key('Alejandro Vertel')), findsOneWidget);
    expect(find.byKey(const Key('Pepe Perez')), findsOneWidget);
    expect(find.byKey(const Key('Joshua Angarita')), findsNothing);
    await tester.pump();
    await tester.tap(find.byKey(const Key('Alejandro Vertel')));
    await tester.pump();
    expect(find.text('Pepe Perez'), findsNothing);
  });

//Test de pagina de eventos
  testWidgets('Pagina de eventos', (WidgetTester tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: Scaffold(body: EventosList())));
    expect(find.text("Eventos"), findsOneWidget);
    expect(find.byKey(const Key('Event_Card0')), findsOneWidget);

    //Aqui se selecciona un evento

    await tester.tap(find.byKey(const Key('Event_Card0')));
    await tester.pump();
  });

  //Test evento particular

  testWidgets('Evento particualr', (WidgetTester tester) async {
    // Se crea una variable de tipo evento para poder cumplir con los parametros de selectedevent
    var event = Event(
        name: "Salir de clase",
        from: DateTime.now(),
        to: DateTime.now(),
        description: "Salir de clase y no volver más",
        persCreadora: "Mateo",
        invitados: ["Chirstian", "Danna"],
        color: Colors.blue,
        imgName: "1");
    await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: SelectedEvent(selectedevent: event))));

    //Se testean los widgets de selected event

    expect(find.byKey(const Key('Nombre evento')), findsOneWidget);
    expect(find.byKey(const Key('Descripcion evento')), findsOneWidget);
    expect(find.text("Inscribirse"), findsOneWidget);
  });

  /*testWidgets('Counter increments smoke test', (WidgetTester tester
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });*/
}
