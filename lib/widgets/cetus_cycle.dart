import "package:flutter/material.dart";
import 'package:warframe_hub/api.dart';
import 'package:warframe_hub/cetus_cycle.dart';
import 'dart:async';
import 'dart:convert';

import 'countdown_timer.dart';

class CetusCycleWidget extends StatefulWidget {
  CetusCycleWidget({Key key}) : super(key: key);

  String time;

  @override
  _CetusCycleWidgetState createState() => _CetusCycleWidgetState();
}

class _CetusCycleWidgetState extends State<CetusCycleWidget> {
  CountdownTimer _timer;

  int timeInSeconds = 10;

  void countdown() {
    setState(
      () {
        if (timeInSeconds < 1) {
          _timer.stop();
        } else {
          timeInSeconds -= 1;
        }
      },
    );
  }

  Future<CetusCycle> cc;

  @override
  void initState() {
    super.initState();

    cc = APIHelper.api.fetchCetusCycle();

    _timer = new CountdownTimer(action: countdown);
    // _timer.start();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      child: FutureBuilder(
        future: cc,
        builder: (BuildContext bc, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            widget.time = snapshot.data.timeLeft;
            List<String> parts =
                widget.time.replaceAll(RegExp(r"([hms])"), "").split(" ");

            for (String part in parts) {
              timeInSeconds += int.parse(part) * 60;
            }
            print(widget.time);
            _timer.start();
            return Column(
              children: [
                Text("status: a"),
                Text(
                    "${timeInSeconds ~/ 3600}h:${timeInSeconds ~/ 60 % 60}m:${timeInSeconds % 60}s"),
              ],
            );
          }
          return Text("loading");
        },
      ),
    );
  }
}
