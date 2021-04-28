import "package:flutter/material.dart";
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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

  int timeInSeconds = 0;

  void countdown() {
    setState(
      () {
        if (timeInSeconds < 1) {
          _timer.stop();
          cc = APIHelper.api.fetchCetusCycle();
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
            CetusCycle data = snapshot.data;

            if (timeInSeconds < 1) {
              widget.time = data.timeLeft;
              List<String> parts =
                  widget.time.replaceAll(RegExp(r"([hms])"), "").split(" ");

              for (String part in parts) {
                timeInSeconds += int.parse(part) * 60;
              }
              // timeInSeconds = 10;

              _timer.start();
            }

            return Column(
              children: [
                Card(
                  child: ListTile(
                    leading: Icon(MdiIcons.moonWaningCrescent),
                    title: Text('Cetus Cycle'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Status: ${data.isDay ? 'Day' : "Night"}"),
                        Text("${!data.isDay ? 'Day' : "Night"} in " +
                            "${timeInSeconds ~/ 3600}h:${timeInSeconds ~/ 60 % 60}m:${timeInSeconds % 60}s"),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return Text("loading");
        },
      ),
    );
  }
}
