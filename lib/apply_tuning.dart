import 'dart:async';

import 'package:flutter/cupertino.dart';

class ApplyTuning extends ChangeNotifier {
  // ignore: close_sinks
  StreamController<void> _applyTuningStream = StreamController.broadcast();
  Stream<void> get stream => _applyTuningStream.stream;

  void applyTuning() {
    _applyTuningStream.sink.add(null);
  }
}