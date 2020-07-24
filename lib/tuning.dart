import 'dart:ui';

import 'package:cpu_tuner/power_limit.dart';
import 'package:cpu_tuner/turbo_ratio_limit.dart';
import 'package:flutter/material.dart';

class TuningPage extends StatefulWidget {
  @override
  _TuningPageState createState() => _TuningPageState();
}

class _TuningPageState extends State<TuningPage> {
  int tdpValue = 15;
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      isAlwaysShown: true,
      child: ListView(
        controller: _scrollController,
//      shrinkWrap: true,
        children: [
          Container(
//          height: 400,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
//            direction: Axis.horizontal,
//            scrollDirection: Axis.horizontal,
              children: [
//        Container(width: 500, height: 500, color: Colors.white,),
//        Container(width: 500, height: 500, color: Colors.white,),
                PowerLimit(title: "Long power limit (PL1)"),
                PowerLimit(title: "Short power limit (PL2)"),
                TurboRatioLimit(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
