import 'dart:ui';

class Event {
  final String name;
  final DateTime from;
  final DateTime to;
  final String description;
  final String persCreadora;
  final List invitados;
  final Color color;
  final String imgName;
  const Event({
    required this.name,
    required this.from,
    required this.to,
    required this.description,
    required this.persCreadora,
    required this.invitados,
    required this.color,
    required this.imgName,
  });
}
