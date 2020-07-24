import 'package:cpu_tuner/apply_tuning.dart';
import 'package:cpu_tuner/sidebar.dart';
import 'package:cpu_tuner/system_information.dart';
import 'package:cpu_tuner/tuning.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => ApplyTuning(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColorBrightness: Brightness.dark,
        accentColor: Colors.blueAccent,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("CPU Tuner"),
          centerTitle: true,
          flexibleSpace: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 40,
                      child: RaisedButton(
                        child: Text("Apply"),
                        onPressed: () {
                          Provider.of<ApplyTuning>(context, listen: false)
                              .applyTuning();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Sidebar(
                selectedItem: _currentPage,
                onItemSelected: (int item) {
                  _pageController.animateToPage(
                    item,
                    duration: Duration(milliseconds: 250),
                    curve: Curves.fastOutSlowIn,
                  );
                  setState(() {
                    _currentPage = item;
                    debugPrint(item.toString());
                  });
                }),
            Expanded(
              child: PageView(
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  Padding(
                    padding: EdgeInsets.all(24.0),
                    child: SystemInformationPage(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(24.0),
                    child: TuningPage(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
