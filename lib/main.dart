import 'package:flutter/material.dart';
import 'code.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TokoBus',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'TokoBus'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List timetableCompact = code();
  int count = 0;

  Future<void> mainLoop() async {
    while (true) {
      await Future<void>.delayed(const Duration(seconds: 1));
      setState(() {
        timetableCompact = code();
        //print(timetableCompact);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    mainLoop();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(children: <Widget>[
          Expanded(
            flex: 5, // 割合
            child: Container(
              color: Colors.black,
              child: Container(
                alignment: Alignment.center,
                color: Colors.grey,
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "小手指駅 → キャンパス",
                      style: TextStyle(fontSize: 25),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Text(
                                "発車時刻",
                                strutStyle: StrutStyle(height: 2, fontSize: 30),
                              ),
                            ),
                            Container(
                              child: Text(
                                "${timetableCompact[0][0]}",
                                strutStyle: StrutStyle(height: 2, fontSize: 30),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(color: Color.fromRGBO(142, 23, 40, 100)),
                              child: Text(
                                "${timetableCompact[1][0]}",
                                strutStyle: StrutStyle(height: 2, fontSize: 30),
                              ),
                            ),
                            Container(
                              child: Text(
                                "${timetableCompact[2][0]}",
                                strutStyle: StrutStyle(height: 2, fontSize: 30),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Text(
                                "残り時間",
                                strutStyle: StrutStyle(height: 2, fontSize: 30),
                              ),
                            ),
                            Container(
                              child: Text(
                                "${timetableCompact[0][1]}",
                                strutStyle: StrutStyle(height: 2, fontSize: 30),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(color: Color.fromRGBO(142, 23, 40, 100)),
                              child: Text(
                                "${timetableCompact[1][1]}",
                                strutStyle: StrutStyle(height: 2, fontSize: 30),
                              ),
                            ),
                            Container(
                              child: Text(
                                "${timetableCompact[2][1]}",
                                strutStyle: StrutStyle(height: 2, fontSize: 30),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Text(
                                "発車場所",
                                strutStyle: StrutStyle(height: 2, fontSize: 30),
                              ),
                            ),
                            Container(
                              child: Text(
                                "${timetableCompact[0][2]}",
                                strutStyle: StrutStyle(height: 2, fontSize: 30),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(color: Color.fromRGBO(142, 23, 40, 100)),
                              child: Text(
                                "${timetableCompact[1][2]}",
                                strutStyle: StrutStyle(height: 2, fontSize: 30),
                              ),
                            ),
                            Container(
                              child: Text(
                                "${timetableCompact[2][2]}",
                                strutStyle: StrutStyle(height: 2, fontSize: 30),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Text(
                                "車椅子",
                                strutStyle: StrutStyle(height: 2, fontSize: 30),
                              ),
                            ),
                            Container(
                              child: Text(
                                "${timetableCompact[0][3]}",
                                strutStyle: StrutStyle(height: 2, fontSize: 30),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(color: Color.fromRGBO(142, 23, 40, 100)),
                              child: Text(
                                "${timetableCompact[1][3]}",
                                strutStyle: StrutStyle(height: 2, fontSize: 30),
                              ),
                            ),
                            Container(
                              child: Text(
                                "${timetableCompact[2][3]}",
                                strutStyle: StrutStyle(height: 2, fontSize: 30),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5, // 割合
            child: Container(
              color: Colors.blue,
            ),
          )
        ]));
  }
}
