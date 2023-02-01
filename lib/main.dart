import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
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
      //theme: ThemeData(
      //primarySwatch: Colors.blue,
      //brightness: Brightness.dark,
      //),
      theme: FlexThemeData.light(scheme: FlexScheme.hippieBlue),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.hippieBlue,
        darkIsTrueBlack: true,
      ),
      themeMode: ThemeMode.dark,
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
  List timetable = code();
  int count = 0;

  Future<void> mainLoop() async {
    while (true) {
      await Future<void>.delayed(const Duration(seconds: 1));
      setState(() {
        timetable = code();
        //print(timetable[4);
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
        //appBar: AppBar(
        //title: Text(widget.title),
        //),
        body: SafeArea(
      child: Column(children: <Widget>[
        Expanded(
          flex: 5, // 割合
          child: Container(
            //color: Colors.black,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Spacer(),
                Container(
                  alignment: AlignmentDirectional.center,
                  //color: Color.fromRGBO(44,44,46,1,
                  height: size.height * 0.1,
                  width: size.width * 0.9,
                  child: Text("小手指駅 → キャンパス",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      alignment: AlignmentDirectional.center,
                      color: Color.fromRGBO(44,44,46,1),
                      height: size.height * 0.06*4,
                      width: size.width * (0.2+0.35+0.2+0.16)*1.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Container(
                                alignment: AlignmentDirectional.center,
                                color: Color.fromRGBO(44,44,46,1),
                                height: size.height * 0.06,
                                width: size.width * 0.2,
                                child: Text(
                                  "発車時刻",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Container(
                                alignment: AlignmentDirectional.center,
                                color: Color.fromRGBO(44,44,46,1),
                                height: size.height * 0.06,
                                width: size.width * 0.2,
                                child: Text(
                                  "${timetable[4][0][0]}",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Container(
                                alignment: AlignmentDirectional.center,
                                color: Color.fromRGBO(142, 23, 40, 1),
                                height: size.height * 0.06,
                                width: size.width * 0.2,
                                child: Text(
                                  "${timetable[4][1][0]}",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Container(
                                alignment: AlignmentDirectional.center,
                                color: Color.fromRGBO(44,44,46,1),
                                height: size.height * 0.06,
                                width: size.width * 0.2,
                                child: Text(
                                  "${timetable[4][2][0]}",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              alignment: AlignmentDirectional.center,
                              color: Color.fromRGBO(44,44,46,1),
                              height: size.height * 0.06,
                              width: size.width * 0.35,
                              child: Text(
                                "残り時間",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Container(
                              alignment: AlignmentDirectional.center,
                              color: Color.fromRGBO(44,44,46,1),
                              height: size.height * 0.06,
                              width: size.width * 0.35,
                              child: Text(
                                "${timetable[4][0][1]}",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Container(
                              alignment: AlignmentDirectional.center,
                              color: Color.fromRGBO(142, 23, 40, 1),
                              height: size.height * 0.06,
                              width: size.width * 0.35,
                              child: Text(
                                "${timetable[4][1][1]}",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Container(
                              alignment: AlignmentDirectional.center,
                              color: Color.fromRGBO(44,44,46,1),
                              height: size.height * 0.06,
                              width: size.width * 0.35,
                              child: Text(
                                "${timetable[4][2][1]}",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              alignment: AlignmentDirectional.center,
                              color: Color.fromRGBO(44,44,46,1),
                              height: size.height * 0.06,
                              width: size.width * 0.2,
                              child: Text(
                                "発車場所",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Container(
                              alignment: AlignmentDirectional.center,
                              color: Color.fromRGBO(44,44,46,1),
                              height: size.height * 0.06,
                              width: size.width * 0.2,
                              child: Text(
                                "${timetable[4][0][2]}",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Container(
                              alignment: AlignmentDirectional.center,
                              color: Color.fromRGBO(142, 23, 40, 1),
                              height: size.height * 0.06,
                              width: size.width * 0.2,
                              child: Text(
                                "${timetable[4][1][2]}",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Container(
                              alignment: AlignmentDirectional.center,
                              color: Color.fromRGBO(44,44,46,1),
                              height: size.height * 0.06,
                              width: size.width * 0.2,
                              child: Text(
                                "${timetable[4][2][2]}",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              alignment: AlignmentDirectional.center,
                              color: Color.fromRGBO(44,44,46,1),
                              height: size.height * 0.06,
                              width: size.width * 0.16,
                              child: Text(
                                "車椅子",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Container(
                              alignment: AlignmentDirectional.center,
                              color: Color.fromRGBO(44,44,46,1),
                              height: size.height * 0.06,
                              width: size.width * 0.16,
                              child: Text(
                                "${timetable[4][0][3]}",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Container(
                              alignment: AlignmentDirectional.center,
                              color: Color.fromRGBO(142, 23, 40, 1),
                              height: size.height * 0.06,
                              width: size.width * 0.16,
                              child: Text(
                                "${timetable[4][1][3]}",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Container(
                              alignment: AlignmentDirectional.center,
                              color: Color.fromRGBO(44,44,46,1),
                              height: size.height * 0.06,
                              width: size.width * 0.16,
                              child: Text(
                                "${timetable[4][2][3]}",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer()
              ],
            ),
          ),
        ),
        Expanded(
          flex: 5, // 割合
          child: Container(
            color: Colors.blue,
          ),
        )
      ]),
    ));
  }
}
