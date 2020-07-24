import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class PowerLimit extends StatefulWidget {
  final String title;

  PowerLimit({key, this.title}) : super(key: key);

  @override
  _PowerLimitState createState() => _PowerLimitState();
}

class _PowerLimitState extends State<PowerLimit> {
  bool enabled = true;
  int tdpLimit = 15;
  bool clamp = true;
  double timeWindow = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Text(
                        widget.title,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Tooltip(
                        message: "Enable",
                        child: Switch(
                          value: enabled,
                          onChanged: (v) {
                            setState(() {
                              enabled = v;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Max TDP"),
                        Text("${tdpLimit.round()} W"),
                      ],
                    ),
                  ),
                  Slider(
                    value: tdpLimit.toDouble(),
                    min: 1,
                    max: 50,
                    divisions: 49,
                    onChanged: (value) {
                      setState(() {
                        this.tdpLimit = value.round();
                      });
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
//                mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Switch(
                        value: clamp,
                        onChanged: (v) {
                          setState(() {
                            clamp = v;
                          });
                        }),
                    Text("Clamp"),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Time window"),
                        Text("${timeWindow.toStringAsFixed(1)} s"),
                      ],
                    ),
                  ),
                  Slider(
                    value: timeWindow,
                    min: 0,
                    max: 100,
                    divisions: 200,
                    onChanged: (v) {
                      setState(() {
                        timeWindow = v;
                      });
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      child: IconButton(
                        tooltip: "Reset",
                        icon: Icon(Icons.refresh),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      height: 40,
                      child: RaisedButton(
                        child: Text("Apply"),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
