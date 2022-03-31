//En esta clase podemos crear un evento nuevo y editarlo
import 'package:app_ru/domain/constants/controllers/event_controller.dart';
import 'package:app_ru/models/event.dart';
import 'package:app_ru/ui/pages/pageMyCalendar/utils.dart';
import 'package:app_ru/ui/widgets/navbar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/constants/color.dart';

class EventEditingPage extends StatefulWidget {
  final Event? event;

  const EventEditingPage({Key? key, this.event}) : super(key: key);

  @override
  _EventEditingPageState createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  //Variables
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;

  @override
  void initState() {
    super.initState();
    if (widget.event == null) {
      //Horas por defecto
      fromDate = DateTime.now();
      toDate = DateTime.now().add(const Duration(hours: 2));
    } else {
      final event = widget.event;
      titleController.text = event!.name;
      fromDate = event.from;
      toDate = event.to;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

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
          actions: buildEditingActions(),
        ),
      ),

      //--------------------------------BODY--------------------------------------
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[buildTitle(), buildDateTimePickers()],
          ),
        ),
      ),
    );

    //--------------------------------OTROS WIDGETS---------------------------
  }

  //Botón guardar
  List<Widget> buildEditingActions() => [
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            //Método que va a agregar el nuevo evento
            onPressed: saveForm,
            icon: const Icon(Icons.done),
            label: const Text("SAVE"))
      ];

  //Pone el título
  Widget buildTitle() => TextFormField(
        style: const TextStyle(fontSize: 24),
        decoration: const InputDecoration(
            border: UnderlineInputBorder(), hintText: "Add title"),
        onFieldSubmitted: (_) => saveForm(),
        validator: (title) => title != null && title.isEmpty
            ? "El título no puede estar vacío"
            : null,
        controller: titleController,
      );
  //Pone los calendarios
  Widget buildDateTimePickers() => Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          buildFrom(),
          buildTo(),
        ],
      );
  //Pone los calendarios del From
  Widget buildFrom() => buildHeader(
        header: "FROM",
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: Utils.toDate(fromDate),
                onClicked: () => pickFromDateTime(pickDate: true),
              ),
            ),
            Expanded(
              child: buildDropdownField(
                text: Utils.toTime(fromDate),
                onClicked: () => pickFromDateTime(pickDate: false),
              ),
            ),
          ],
        ),
      );
  //Pone los calendarios del To
  Widget buildTo() => buildHeader(
        header: "TO",
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: Utils.toDate(toDate),
                onClicked: () => pickToDateTime(pickDate: true),
              ),
            ),
            Expanded(
              child: buildDropdownField(
                text: Utils.toTime(toDate),
                onClicked: () => pickToDateTime(pickDate: false),
              ),
            ),
          ],
        ),
      );
  //Pick la fecha de from
  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);

    if (date == null) return;

    //Si la fecha del from es mayor a la fecha del toDate, actualiza la fecha del
    //toDate a la del from
    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }

    //Actulizamos las fechas que se muestran en pantalla
    setState(() => fromDate = date);
  }

  //Fecha de To
  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(toDate,
        pickDate: pickDate, firstDate: pickDate ? fromDate : null);

    if (date == null) return;

    //Actulizamos las fechas que se muestran en pantalla
    setState(() => toDate = date);
  }

  //Date y time picker
  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2015, 8),
        //Fecha máxima de nuestro calendario
        lastDate: DateTime(2101),
      );
      if (date == null) return null;

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));

      if (timeOfDay == null) return null;

      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);

      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

      return date.add(time);
    }
  }

  Widget buildDropdownField({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        title: Text(text),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );
  //Pone la palabra form y to
  Widget buildHeader({required String header, required Widget child}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          child,
        ],
      );

  //Método para crear el nuevo evento
  Future saveForm() async {
    //Validamos que todo esté bien ingresado
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      //Creamos un nuevo evento
      final event = Event(
        name: titleController.text,
        from: fromDate,
        to: toDate,
        description: "Descripción",
        color: Colors.blue,
        imgName: "1",
      );

      final isEditing = widget.event != null;
      //LLmando al controlador, añadimos el evento a la lista de controladores
      Get.put(EventController());
      EventController eventCont = Get.find();

      if (isEditing) {
        eventCont.editEvent(event, widget.event!);
      } else {
        eventCont.addEvent(event);
      }

      //Volvemos a la página anterior

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const NavBar()),
          (route) => false);
    }
  }
}
