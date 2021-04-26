import 'package:flutter/cupertino.dart';

class CetusCycle {
  final String id;
  final bool isDay;
  final String timeLeft;

  String get timeleft => this.timeLeft;

  CetusCycle(
      {@required this.id, @required this.isDay, @required this.timeLeft});

  factory CetusCycle.fromJson(Map<String, dynamic> json) {
    return CetusCycle(
        id: json['id'], isDay: json['isDay'], timeLeft: json['timeLeft']);
  }
}
