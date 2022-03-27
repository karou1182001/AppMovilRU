import 'package:app_ru/domain/constants/color.dart';
import 'package:app_ru/domain/constants/text_style.dart';
import 'package:app_ru/ui/pages/profile.dart';
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
          const Text("Iniciar Sesión", style: TextStyle(color: Colors.black, fontSize:25, fontWeight: FontWeight.bold)),
          Text("¡Qué gusto verte!", style: generalText(Colors.grey, 20)),
            const SizedBox(
              height: 15,
            ),
          const Text("Email", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
          TextFormField(
          ),
          const SizedBox(
              height: 15,
          ),
          const Text("Contraseña", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
          TextFormField(
          ),
          const SizedBox(
              height: 15,
          ),
          GestureDetector(
            onTap: () => Get.to(() => const Profile()),
            child: MaterialButton(height: 30, minWidth: 60, onPressed: () => Get.to(() => const Profile()), color: const Color.fromARGB(255, 1, 53, 96), child: const Text("Ingresar", style: TextStyle(color: Colors.white),),)
          ),
          const SizedBox(
              height: 15,
          ),
          Text("O", style: generalText(Colors.grey, 15)),
          const SizedBox(
              height: 15,
          ),
          GestureDetector(
            onTap: () => Get.to(() => const MenuRegistroGoogle()),
            child: MaterialButton(height: 30, minWidth: 60, onPressed: () => Get.to(() => const MenuRegistroGoogle()), color: Colors.white, child: const Text("Inicia Sesión con Google", style: TextStyle(color: Color.fromARGB(255, 1, 53, 96))))
          ),
          const SizedBox(
              height: 15,
          ),
          Text("Si aún no tienes una cuenta, ¿qué esperas?", style: generalText(Colors.grey, 15)),
          const SizedBox(
              height: 15,
          ),
          GestureDetector(
          onTap: () => Get.to(() =>  MenuRegistro()),
          child: const Text("Regístrate", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
          ),
        ]
        ),
      ),
    );
  }
}