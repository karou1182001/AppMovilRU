import 'package:app_ru/domain/constants/controllers/authentication_controller.dart';
import 'package:app_ru/models/event.dart';
import 'package:app_ru/ui/widgets/navbar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/constants/constants/color.dart';
import '../../../domain/constants/controllers/firebaseevent_controller.dart';

class SelectedEvent extends StatelessWidget {
  Event selectedevent;
  String url;
  SelectedEvent({required this.selectedevent, required this.url});
  AuthenticationController authController = Get.find();

  final FirebaseEventController feventCont = Get.find();
  @override
  Widget build(BuildContext context) {
    FirebaseEventController feventCont = Get.find();
    feventCont.getEventUrl(selectedevent.name);
    //APPBAR
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            backgroundColor: white,
            title: Image.asset("assets/logo_appbar.png", height: 60, width: 50),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  // IMAGEN DEL EVENTO
                  images(),
                  //NOMBRE DEL EVENTO
                  Text(selectedevent.name,
                      key: const Key('Nombre evento'),
                      style:
                          const TextStyle(color: Colors.black, fontSize: 30)),
                  //NOMBRE DEL CREADOR DEL EVENTO
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Creado por: " + selectedevent.persCreadora,
                          key: const Key('Dueño del evento'),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 13))
                    ],
                  ),
                  const SizedBox(height: 15),
                  //DESCRIPCION DEL EVENTO
                  Text(
                    selectedevent.description,
                    key: const Key('Descripcion evento'),
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  const SizedBox(height: 15),
                  //INICIO DEL EVENTO
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Comienza el: " + selectedevent.from,
                          key: const Key('Inicio evento'),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16))
                    ],
                  ),
                  const SizedBox(height: 15),
                  // FINAL DEL EVENTO
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Finaliza el : " + selectedevent.to,
                          key: const Key('Final evento'),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16))
                    ],
                  ),
                  //Suscibre buttom
                  GestureDetector(
                    onTap: () {
                      feventCont.addConfirm(this.selectedevent,
                          authController.auth.currentUser!.email);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NavBar()),
                          (route) => false);
                    },
                    child: Container(
                        margin: EdgeInsets.all(20),
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(selectedevent.color),
                          border: Border.all(color: Colors.black26),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Color(selectedevent.color)))),
                            Positioned(
                                bottom: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      ClipOval(
                                        child: Container(
                                            color: Color(selectedevent.color),
                                            padding: const EdgeInsets.all(10),
                                            child: const Icon(
                                              Icons.add_outlined,
                                              size: 15,
                                              color: Colors.white,
                                            )),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        "Inscribirse",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )
                                    ],
                                  ),
                                ))
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget images() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        //child: Image.asset('assets/' + selectedevent.imgName + '.jpg',
        child: (url != '')
            ? Image.network(url, fit: BoxFit.cover, height: 200)
            : Image.network(
                'https://www.meteorologiaenred.com/wp-content/uploads/2018/02/olas.jpg',
                fit: BoxFit.cover,
                height: 200));
  }
}
