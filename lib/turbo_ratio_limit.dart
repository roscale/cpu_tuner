import 'dart:async';
import 'dart:ui';
import 'dart:ffi';

import 'package:cpu_tuner/apply_tuning.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

import 'ffi.dart';

class TurboRatioLimit extends StatefulWidget {
  @override
  _TurboRatioLimitState createState() => _TurboRatioLimitState();
}

class _TurboRatioLimitState extends State<TurboRatioLimit> {
  var ratios = <int>[0, 0, 0, 0];
  String errorMessage;
  StreamSubscription<void> _streamSubscription;

  @override
  void initState() {
    super.initState();
    try {
      var ratios = getTurboRatioLimits();
      this.ratios[0] = ratios.ratio1CoresActive;
      this.ratios[1] = ratios.ratio2CoresActive;
      this.ratios[2] = ratios.ratio3CoresActive;
      this.ratios[3] = ratios.ratio4CoresActive;
    } catch (e) {
      errorMessage = e;
    }

    _streamSubscription =
        Provider.of<ApplyTuning>(context, listen: false).stream.listen((_) {
      if (errorMessage != null) {
        return;
      }
      var ptr = allocate<TurboRatioLimits>();
      ptr.ref
        ..ratio1CoresActive = this.ratios[0]
        ..ratio2CoresActive = this.ratios[1]
        ..ratio3CoresActive = this.ratios[2]
        ..ratio4CoresActive = this.ratios[3];
      setTurboRatioLimits(ptr.ref);
      free(ptr);
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    var ratios = getTurboRatioLimit();
//    this.ratios[0] = ratios.ratio1CoresActive;
//    this.ratios[1] = ratios.ratio2CoresActive;
//    this.ratios[2] = ratios.ratio3CoresActive;
//    this.ratios[3] = ratios.ratio4CoresActive;

//    this.ratios[0] = 0;
//    this.ratios[1] = 0;
//    this.ratios[2] = 0;
//    this.ratios[3] = 0;

    return Container(
      width: 600,
      child: Stack(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Turbo ratio limits",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("1 active core"),
                            Text("${this.ratios[0]}"),
                          ],
                        ),
                      ),
                      Slider(
                        value: this.ratios[0].toDouble(),
                        min: 0,
                        max: 60,
                        divisions: 60,
                        onChanged: (value) {
                          setState(() {
                            this.ratios[0] = value.round();
                          });
                        },
                      ),
                    ],
                  ),
//              Slider(
//                value: this.ratios[0].toDouble(),
//                onChanged: (d) {},
//                min: 0,
//                max: 60,
//              ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("2 active cores"),
                            Text("${this.ratios[1]}"),
                          ],
                        ),
                      ),
                      Slider(
                        value: this.ratios[1].toDouble(),
                        min: 0,
                        max: 60,
                        divisions: 60,
                        onChanged: (value) {
                          setState(() {
                            this.ratios[1] = value.round();
                          });
                        },
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("3 active cores"),
                            Text("${this.ratios[2]}"),
                          ],
                        ),
                      ),
                      Slider(
                        value: this.ratios[2].toDouble(),
                        min: 0,
                        max: 60,
                        divisions: 60,
                        onChanged: (value) {
                          setState(() {
                            this.ratios[2] = value.round();
                          });
                        },
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("4 active cores"),
                            Text("${this.ratios[3]}"),
                          ],
                        ),
                      ),
                      Slider(
                        value: this.ratios[3].toDouble(),
                        min: 0,
                        max: 60,
                        divisions: 60,
                        onChanged: (value) {
                          setState(() {
                            this.ratios[3] = value.round();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
//          Positioned.fill(
//            child: Card(
//              shadowColor: Colors.transparent,
//              color: Colors.black.withOpacity(0.0),
//            ),
//          ),
          errorMessage != null
              ? Positioned.fill(
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                      child: Container(
//                  padding: EdgeInsets.all(5.0),
                        color: Colors.transparent,
                        child: Center(
                          child: Text(
                            errorMessage,
                            textScaleFactor: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
