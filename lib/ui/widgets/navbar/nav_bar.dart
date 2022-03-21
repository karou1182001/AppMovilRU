//Repositorio guía de Navbar: https://github.com/sudeshnb/animation_nav_bar
import 'package:app_ru/domain/constants/color.dart';
import 'package:app_ru/domain/constants/text_style.dart';
import 'package:app_ru/ui/widgets/navbar/custom_paint.dart';
import 'package:app_ru/ui/widgets/navbar/model.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  int selectBtn = 2;
  Widget build(BuildContext context) {
    return Scaffold(
      //Aquí se pone el widget que se seleccione en la NavBar
      body: navBtn[selectBtn].widget,
      //Aquí se pone la NavBar
      bottomNavigationBar: navigationBar(),
    );
  }

  //--------------------WIDGET NAVBAR------------------------------------
  AnimatedContainer navigationBar() {
    return AnimatedContainer(
      //Altura de la Navbar respecto a la pantalla
      height: 80.0,
      //Tiempo que dura en pasar de un icono a otro
      duration: const Duration(milliseconds: 0),
      //Forma de la cajita de la navbar(bordeado, etc))
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(selectBtn == 0 ? 0.0 : 30.0),
          topRight:
              Radius.circular(selectBtn == navBtn.length - 1 ? 0.0 : 30.0),
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
            GestureDetector(
              //Con el set State activa el botón seleccionado
              onTap: () => setState(() => selectBtn = i),
              child: iconBtn(i),
            ),
        ],
      ),
    );
  }

  SizedBox iconBtn(int i) {
    //Verifica si ese botón ha sido seleccionado o no
    bool isActive = selectBtn == i ? true : false;
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
              child: Icon(
                navBtn[i].icon,
                color: isActive ? selectColor : black,
                //size: 2,
              )
              /*child: Image.asset(
              navBtn[i].imagePath,
              color: isActive ? selectColor : black,
              scale: 2,
            ),*/
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
