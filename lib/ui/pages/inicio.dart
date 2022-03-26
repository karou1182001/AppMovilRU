import 'package:app_ru/domain/constants/color.dart';
import 'package:app_ru/domain/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_ru/ui/pages/registro.dart';
import 'package:app_ru/ui/pages/inicioGoogle.dart';

void main () {
  runApp(const MenuInicio());
}

class MenuInicio extends StatelessWidget{
  const MenuInicio({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Column( crossAxisAlignment: CrossAxisAlignment.center,
        children: [ Container(
          width: 110,
          height: 200,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/logo_appbar.png"))
          )
        ),
            const SizedBox(
              height: 15,
            ),
          Text("Iniciar Sesión", style: generalText(Colors.black, 32)),
          Text("¡Qué gusto verte!", style: generalText(Colors.grey, 32)),
            const SizedBox(
              height: 15,
            ),
          Text("Email", style: generalText(Colors.black, 32)),
          const TextField(
              obscureText: true,
              decoration: InputDecoration(
              border: OutlineInputBorder(),)
          ),
          const SizedBox(
              height: 15,
          ),
          Text("Contraseña", style: generalText(Colors.black, 32)),
          const TextField(
              obscureText: true,
              decoration: InputDecoration(
              border: OutlineInputBorder(),)
          ),
          const SizedBox(
              height: 15,
          ),
          GestureDetector(
            onTap: () => Get.to(() => const MenuRegistro()),
            child: ElevatedButton(onPressed: () {}, child: const Text("Ingresar"),)
          ),
          const SizedBox(
              height: 15,
          ),
          Text("O", style: generalText(Colors.grey, 32)),
          const SizedBox(
              height: 15,
          ),
          GestureDetector(
            onTap: () => Get.to(() => const MenuRegistroGoogle()),
            child: ElevatedButton(onPressed: () {}, child: const Text("Inicia Sesión con Google"),)
          ),
          const SizedBox(
              height: 15,
          ),
          Text("Si aún no tienes una cuenta, ¿qué esperas?", style: generalText(Colors.grey, 32)),
          Text("Regístrate", style: generalText(Colors.black, 32)),
        ]
        ),
      ),
    );
  }
}