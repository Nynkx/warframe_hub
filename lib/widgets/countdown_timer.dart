import 'dart:async';

import 'package:flutter/cupertino.dart';

class CountdownTimer {
  Timer _timer;
  Function action;

  CountdownTimer({@required this.action});

  void start() {
    if (_timer != null) {
      // _timer.cancel();
      // _timer = null;
      return;
    } else {
      _timer = new Timer.periodic(
        Duration(seconds: 1),
        (timer) {
          this.action();
        },
      );
    }
  }

  void stop() {
    _timer.cancel();
  }
}
