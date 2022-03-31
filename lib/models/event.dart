import 'dart:ui';

class Event {
  final String name;
  final DateTime from;
  final DateTime to;
  final String description;
  final Color color;
  final String imgName;
  const Event({
    required this.name,
    required this.from,
    required this.to,
    required this.description,
    required this.color,
    required this.imgName,
  });
}
