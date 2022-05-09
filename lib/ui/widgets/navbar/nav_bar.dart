//Repositorio guía de Navbar: https://github.com/sudeshnb/animation_nav_bar
import 'package:app_ru/domain/constants/constants/color.dart';
import 'package:app_ru/domain/constants/constants/text_style.dart';
import 'package:app_ru/ui/widgets/navbar/custom_paint.dart';
import 'package:app_ru/ui/widgets/navbar/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/constants/controllers/firebaseevent_controller.dart';
import '../../../domain/constants/controllers/user_controller.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(FirebaseEventController());
    Get.put(UserController());
  }

  @override
  //Colocamos que inicie en el menú 2, para que por defecto salga el calendario
  int selectBtn = 2;
  Widget build(BuildContext context) {
    double tam = (MediaQuery.of(context).size.width / 5).floor().toDouble();
    return Scaffold(
      //Aquí se pone el widget que se seleccione en la NavBar
      body: navBtn[selectBtn].widget,
      //Aquí se pone la NavBar
      bottomNavigationBar: navigationBar(tam),
    );
  }

  //--------------------WIDGET NAVBAR------------------------------------
  //Navbar
  AnimatedContainer navigationBar(double tam) {
    return AnimatedContainer(
      //Altura de la Navbar respecto a la pantalla
      height: 75.0,
      //Tiempo que dura en pasar de un icono a otro
      duration: const Duration(milliseconds: 0),
      //Forma de la cajita de la navbar(bordeado, etc))
      decoration: BoxDecoration(
        color: colorp1,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(selectBtn == 0 ? 0.0 : 30.0),
          topRight:
              Radius.circular(selectBtn == navBtn.length - 1 ? 0.0 : 30.0),
        ),
      ),
      //Lo que se va a encontrar dentro del contenedor, una fila con cada uno de
      //los menú
      child: Row(
        children: [
          //Vaa  recorrer cada  uno de  los menú que están en la clase navbar
          //y los va a poner en una cajita iconBtn
          for (int i = 0; i < navBtn.length; i++)
            GestureDetector(
              //Con el set State activa el botón seleccionado
              onTap: () => setState(() => selectBtn = i),
              child: iconBtn(i, tam),
            ),
        ],
      ),
    );
  }

  //Cada uno de los iconos de la Navbar
  Container iconBtn(int i, double tam) {
    //Verifica si ese botón ha sido seleccionado o no
    bool isActive = selectBtn == i ? true : false;
    var height = isActive ? 60.0 : 0.0;
    var width = isActive ? 50.0 : 0.0;
    return Container(
      //Tamaño total de la pantalla sobre la cantidad de elementos en la navbar
      width: tam,
      //Stack pone widgets encima de otros
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedContainer(
              height: height,
              width: width,
              duration: const Duration(milliseconds: 50),
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
              child: Icon(
                navBtn[i].icon,
                color: isActive ? white : black,
                //size: 2,
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              navBtn[i].name,
              style: isActive ? bntText.copyWith(color: white) : bntText,
            ),
          )
        ],
      ),
    );
  }
}
