import 'package:app_ru/ui/pages/pageFriends/friends.dart';
import 'package:app_ru/ui/pages/pageFriends/selectedfriend.dart';
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
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: FriendsList())));
    expect(find.byKey(const Key('Alejandro Vertel')), findsOneWidget);
    expect(find.byKey(const Key('Pepe Perez')), findsOneWidget);
    expect(find.byKey(const Key('Joshua Angarita')), findsNothing);
    await tester.pump();
    await tester.tap(find.byKey(const Key('Alejandro Vertel')));
    await tester.pump();
    expect(find.text('Pepe Perez'), findsNothing);
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
