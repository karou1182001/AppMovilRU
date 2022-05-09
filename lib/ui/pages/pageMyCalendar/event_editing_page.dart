//En esta clase podemos crear un evento nuevo y editar sus datos
import 'dart:io';

import 'package:app_ru/models/event.dart';
import 'package:app_ru/ui/pages/pageMyCalendar/utils.dart';
import 'package:app_ru/ui/widgets/navbar/nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/constants/constants/color.dart';
import '../../../domain/constants/controllers/firebaseevent_controller.dart';
import '../../../domain/constants/controllers/user_controller.dart';
import 'mycalendar.dart';

class EventEditingPage extends StatefulWidget {
  final Event? event;

  const EventEditingPage({Key? key, this.event}) : super(key: key);

  @override
  _EventEditingPageState createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  //--------------------------Variables---------------------------------
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final invitadosController = TextEditingController();
  final descController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;
  Color colorEvento = selectColor;
  bool publico = true;
  late var _selectedPicture = File("");
  FirebaseEventController feventCont = Get.find();
  List<dynamic> personasInvitadas = [];
  String currentEmail = "";
  late TextEditingController textControllerAttendee;
  late FocusNode textFocusNodeAttendee;
  bool isEditingEmail = false;
  String eventId = "";

  @override
  void initState() {
    super.initState();
    if (widget.event == null) {
      //Horas por defecto
      fromDate = feventCont.selectedDate;
      //DateTime.now();
      toDate = feventCont.selectedDate.add(const Duration(hours: 2));
    } else {
      //Por si el evento ya fue creado y solo lo queremos editas, tomamos los valores
      //del evento
      final event = widget.event;
      eventId = event!.name;
      titleController.text = event.name;
      fromDate = DateTime.parse(event.from);
      toDate = DateTime.parse(event.to);
      descController.text = event.description;
      colorEvento = Color(event.color);
      personasInvitadas = event.invitados;
      publico = event.publico;
    }
    textControllerAttendee = TextEditingController();
    textFocusNodeAttendee = FocusNode();
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
            children: <Widget>[
              buildTitle(),
              buildDateTimePickers(),
              colorPicker(),
              const SizedBox(
                height: 20,
              ),
              imagePicker(),
              imagen(),
              invitados(),
              switchPublico(),
              const SizedBox(
                height: 20,
              ),
              parrafoDescripcion(),
            ],
          ),
        ),
      ),
    );

    //--------------------------------OTROS WIDGETS---------------------------
  }

  //Botón guardar en la esquina derecha
  List<Widget> buildEditingActions() => [
        ElevatedButton.icon(
            key: Key('botonSave'),
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
        key: Key('editableTitle'),
        style: const TextStyle(fontSize: 24),
        decoration: const InputDecoration(
            border: UnderlineInputBorder(), hintText: "Add title"),
        onFieldSubmitted: (_) => saveForm(),
        validator: (title) => title != null && title.isEmpty
            ? "El título no puede estar vacío"
            : null,
        controller: titleController,
      );

  //Invitados
  Widget invitados() => Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: PageScrollPhysics(),
            itemCount: personasInvitadas.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      personasInvitadas[index],
                      style: const TextStyle(
                        color: selectColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          personasInvitadas.removeAt(index);
                        });
                      },
                      color: Colors.red,
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  enabled: true,
                  cursorColor: selectColor,
                  focusNode: textFocusNodeAttendee,
                  controller: textControllerAttendee,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {
                    setState(() {
                      currentEmail = value;
                    });
                  },
                  onSubmitted: (value) {
                    textFocusNodeAttendee.unfocus();
                  },
                  decoration: InputDecoration(
                    disabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: selectColor, width: 1),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.redAccent, width: 2),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    contentPadding: const EdgeInsets.only(
                      left: 16,
                      bottom: 16,
                      top: 16,
                      right: 16,
                    ),
                    hintText: 'Ingresa email de invitado',
                    errorText:
                        isEditingEmail ? _validateEmail(currentEmail) : null,
                    errorStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.check_circle,
                  color: selectColor,
                  size: 35,
                ),
                onPressed: () {
                  setState(() {
                    isEditingEmail = true;
                  });
                  if (_validateEmail(currentEmail) == "email validado") {
                    setState(() {
                      textFocusNodeAttendee.unfocus();
                      //calendar.EventAttendee eventAttendee = calendar.EventAttendee();
                      //eventAttendee.email = currentEmail;

                      personasInvitadas.add(currentEmail);

                      textControllerAttendee.text = '';
                      currentEmail = "";
                      isEditingEmail = false;
                    });
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      );

  //Público o no público
  Widget switchPublico() => Container(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.person_pin_circle_outlined),
          const SizedBox(
            width: 10,
          ),
          const Text(
            'Público',
            style: TextStyle(
              color: selectColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          Switch(
              activeColor: Colors.green,
              value: publico,
              onChanged: (value) => {
                    setState(() {
                      publico = value;
                    })
                  }),
        ],
      ));
  //Pone los calendarios
  Widget buildDateTimePickers() => Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          buildFrom(),
          buildTo(),
          const SizedBox(
            height: 20,
          ),
        ],
      );
  Widget parrafoDescripcion() => TextFormField(
        key: Key('editableDescription'),
        controller: descController,
        minLines: 2,
        maxLines: 8,
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(
            hintText: 'Descripción del evento',
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )),
      );
  Widget colorPicker() => Row(
        children: [
          const Text(
            "COLOR EVENTO",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            key: Key('botonColor'),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('¡Escoge el color de tu evento!'),
                      content: SingleChildScrollView(
                        child: BlockPicker(
                          pickerColor: colorEvento, //default color
                          onColorChanged: (Color color) {
                            //on color picked
                            setState(() {
                              colorEvento = color;
                            });
                          },
                        ),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text('Listo'),
                          onPressed: () {
                            Navigator.of(context)
                                .pop(); //dismiss the color picker
                          },
                        ),
                      ],
                    );
                  });
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(colorEvento)),
            child: const Icon(Icons.color_lens),
          )
        ],
      );

  Widget imagePicker() => Row(
        children: [
          const Text(
            "IMAGEN EVENTO",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: () async {
              var image =
                  (await ImagePicker().pickImage(source: ImageSource.gallery));

              //Añadir imagen a Firebase
              feventCont.changeEventPicture(image!.path, eventId);
              setState(() {
                _selectedPicture = File(image!.path);
              });
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey)),
            child: const Icon(Icons.camera_alt),
          )
        ],
      );

  imagen() {
    //Video base para guardar imagen https://youtu.be/h5z6qwyjwi8
    if (_selectedPicture.toString() != "File: ''") {
      return Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 150,
            child: Image.file(_selectedPicture),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );
    } else {
      return const SizedBox(
        height: 20,
      );
    }
  }

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
      final isEditing = widget.event != null;
      //LLmando al controlador, añadimos el evento a la lista de controladores
      Get.put(FirebaseEventController());
      Get.put(UserController());
      FirebaseEventController feventCont = Get.find();
      UserController userController = Get.find();

      if (isEditing) {
        //eventCont.editEvent(event, widget.event!);
        feventCont.updateEvent(
            titleController.text,
            DateFormat("yyyy-MM-dd hh:mm:ss").format(fromDate),
            DateFormat("yyyy-MM-dd hh:mm:ss").format(toDate),
            descController.text,
            userController.email,
            personasInvitadas,
            publico,
            colorEvento.value,
            "1",
            widget.event!);
      } else {
        //eventCont.addEvent(event);
        feventCont.addEvent(
          titleController.text,
          DateFormat("yyyy-MM-dd hh:mm:ss").format(fromDate),
          DateFormat("yyyy-MM-dd hh:mm:ss").format(toDate),
          descController.text,
          userController.email,
          personasInvitadas,
          publico,
          [userController.email],
          colorEvento.value,
          "1",
        );
      }

      //Volvemos a la página anterior
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const NavBar()),
          (route) => false);
    }
  }

  //------------------------MÉTODOS-----------------------------------
  String _validateEmail(String value) {
    if (value != null) {
      value = value.trim();

      if (value.isEmpty) {
        return 'Can\'t add an empty email';
      } else {
        final regex = RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
        final matches = regex.allMatches(value);
        for (Match match in matches) {
          if (match.start == 0 && match.end == value.length) {
            return "email validado";
          }
        }
      }
    } else {
      return 'Can\'t add an empty email';
    }

    return 'Invalid email';
  }
}
