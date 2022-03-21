import 'package:app_ru/domain/constants/color.dart';
import 'package:app_ru/domain/constants/text_style.dart';
import 'package:app_ru/domain/controllers/nav_controller.dart';
import 'package:app_ru/ui/pages/calendar.dart';
import 'package:app_ru/ui/pages/friends.dart';
import 'package:app_ru/ui/pages/mycalendar.dart';
import 'package:app_ru/ui/pages/notifications.dart';
import 'package:app_ru/ui/pages/profile.dart';
import 'package:app_ru/ui/widgets/navbar/custom_paint.dart';
import 'package:app_ru/ui/widgets/navbar/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    NavController navCont = Get.find();
    return Scaffold(
      body: Obx(() => navBtn[navCont.selectBtn].widget),
      bottomNavigationBar: navigationBar(),
    );
  }

  AnimatedContainer navigationBar() {
    NavController navCont = Get.find();
    return AnimatedContainer(
      //Altura de la Navbar respecto a la pantalla
      height: 80.0,
      //Tiempo que dura en pasar de un icono a otro
      duration: const Duration(milliseconds: 0),
      //Forma de la cajita de la navbar(bordeado, etc))
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(navCont.selectBtn == 0 ? 0.0 : 30.0),
          topRight: Radius.circular(
              navCont.selectBtn == navBtn.length - 1 ? 0.0 : 30.0),
        ),
      ),
      //Lo que se va a encontrar dentro del contenedor, una fila con cada uno de
      //los menú
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //Vaa  recorrer cada  uno de  los menú que están en la clase navbar
          //y los va a poner en una cajita iconBtn
          for (int i = 0; i < navBtn.length; i++)
            Obx(
              () => GestureDetector(
                //Con el set State activa el botón seleccionado
                onTap: () => navCont.setSelecBtn(i),
                child: iconBtn(i),
              ),
            ),
        ],
      ),
    );
  }

  SizedBox iconBtn(int i) {
    NavController navCont = Get.find();
    //Verifica si ese botón ha sido seleccionado o no
    bool isActive = navCont.selectBtn == i ? true : false;
    var height = isActive ? 60.0 : 0.0;
    var width = isActive ? 50.0 : 0.0;
    return SizedBox(
      width: 80.0,
      //Stack pone widgets encima de otros
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedContainer(
              height: height,
              width: width,
              duration: const Duration(milliseconds: 200),
              //Si el botón está activado lo pinta
              child: isActive
                  ? CustomPaint(
                      painter: ButtonNotch(),
                    )
                  : const SizedBox(),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              navBtn[i].imagePath,
              color: isActive ? selectColor : black,
              scale: 2,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              navBtn[i].name,
              style: isActive ? bntText.copyWith(color: selectColor) : bntText,
            ),
          )
        ],
      ),
    );
  }
}
