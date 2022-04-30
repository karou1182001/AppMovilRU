import 'package:app_ru/models/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/constants/constants/color.dart';

class SelectedEvent extends StatelessWidget {
  Event selectedevent;

  SelectedEvent({required this.selectedevent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            backgroundColor: white,
            title: Image.asset("assets/logo_appbar.png", height: 60, width: 50),
          ),
        ),
        body: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                //child: Image.asset('assets/' + selectedevent.imgName + '.jpg',
                child: Image.asset('assets/' + "1" + '.jpg',
                    fit: BoxFit.cover, height: 200)),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    padding:
                        const EdgeInsets.only(top: 40, right: 14, left: 14),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(selectedevent.name,
                                key: const Key('Nombre evento'),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 25)),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          selectedevent.description,
                          key: const Key('Descripcion evento'),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 15),
                        ),
                        //Suscibre buttom
                        Container(
                            margin: EdgeInsets.all(20),
                            height: 50,
                            child: Stack(
                              children: [
                                Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                            gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                colors: [
                                                  Color(selectedevent.color)
                                                      .withOpacity(0.4),
                                                  Color(selectedevent.color)
                                                      .withOpacity(1)
                                                ])))),
                                Positioned(
                                    bottom: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          ClipOval(
                                            child: Container(
                                                color:
                                                    Color(selectedevent.color),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: const Icon(
                                                  Icons.add_outlined,
                                                  size: 15,
                                                  color: Colors.white,
                                                )),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            "Inscribirse",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
