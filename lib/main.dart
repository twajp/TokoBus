import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'code.dart';
import 'fullTimetableView.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    // 縦向き
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TokoBus',
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
  static const Color darkGrey = Color.fromRGBO(44, 44, 46, 1);
  static const Color wasedaColor = Color.fromRGBO(142, 23, 40, 1);

  Future<void> mainLoop() async {
    while (true) {
      await Future<void>.delayed(const Duration(seconds: 1));
      setState(() {
        timetable = code();
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
    final PageController controller = PageController();
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: controller,
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  flex: 4, // 割合
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => fullTimetableView(timetable: timetable, size: size, tableIndex: 0),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: Container(
                      //color: Colors.black,
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Spacer(),
                          Container(
                            alignment: AlignmentDirectional.center,
                            height: size.height * 0.1,
                            width: size.width * 0.9,
                            child: Text(
                              timetable[8][0]["title"],
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                alignment: AlignmentDirectional.center,
                                color: darkGrey,
                                height: size.height * 0.06 * 4,
                                width: size.width * (0.2 + 0.35 + 0.2 + 0.16) * 1.05,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: AlignmentDirectional.center,
                                          color: darkGrey,
                                          height: size.height * 0.06,
                                          width: size.width * 0.2,
                                          child: Text(
                                            timetable[8][0]["string0"],
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                        Container(
                                          alignment: AlignmentDirectional.center,
                                          color: darkGrey,
                                          height: size.height * 0.06,
                                          width: size.width * 0.2,
                                          child: Text(
                                            "${timetable[4][0][0]}",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                        Container(
                                          alignment: AlignmentDirectional.center,
                                          color: wasedaColor,
                                          height: size.height * 0.06,
                                          width: size.width * 0.2,
                                          child: Text(
                                            "${timetable[4][1][0]}",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                        Container(
                                          alignment: AlignmentDirectional.center,
                                          color: darkGrey,
                                          height: size.height * 0.06,
                                          width: size.width * 0.2,
                                          child: Text(
                                            "${timetable[4][2][0]}",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.35,
                                        child: Text(
                                          timetable[8][0]["string1"],
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.35,
                                        child: Text(
                                          "${timetable[4][0][1]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.35,
                                        child: Text(
                                          "${timetable[4][1][1]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.35,
                                        child: Text(
                                          "${timetable[4][2][1]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          timetable[8][0]["string2"],
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "${timetable[4][0][2]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "${timetable[4][1][2]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "${timetable[4][2][2]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.16,
                                        child: Text(
                                          timetable[8][0]["string3"],
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.16,
                                        child: Text(
                                          "${timetable[4][0][3]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.16,
                                        child: Text(
                                          "${timetable[4][1][3]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.16,
                                        child: Text(
                                          "${timetable[4][2][3]}",
                                          style: TextStyle(fontSize: 17),
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
                ),
                Expanded(
                  flex: 6, // 割合
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => fullTimetableView(timetable: timetable, size: size, tableIndex: 1),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: Container(
                      //color: Colors.black,
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Spacer(),
                          Container(
                            alignment: AlignmentDirectional.center,
                            height: size.height * 0.1,
                            width: size.width * 0.9,
                            child: Text(
                              timetable[8][1]["title"],
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                alignment: AlignmentDirectional.center,
                                color: darkGrey,
                                height: size.height * 0.06 * 4,
                                width: size.width * (0.2 + 0.35 + 0.2 + 0.16) * 1.05,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: AlignmentDirectional.center,
                                          color: darkGrey,
                                          height: size.height * 0.06,
                                          width: size.width * 0.2,
                                          child: Text(
                                            timetable[8][1]["string0"],
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                        Container(
                                          alignment: AlignmentDirectional.center,
                                          color: darkGrey,
                                          height: size.height * 0.06,
                                          width: size.width * 0.2,
                                          child: Text(
                                            "${timetable[5][0][0]}",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                        Container(
                                          alignment: AlignmentDirectional.center,
                                          color: wasedaColor,
                                          height: size.height * 0.06,
                                          width: size.width * 0.2,
                                          child: Text(
                                            "${timetable[5][1][0]}",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                        Container(
                                          alignment: AlignmentDirectional.center,
                                          color: darkGrey,
                                          height: size.height * 0.06,
                                          width: size.width * 0.2,
                                          child: Text(
                                            "${timetable[5][2][0]}",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.35,
                                        child: Text(
                                          timetable[8][1]["string1"],
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.35,
                                        child: Text(
                                          "${timetable[5][0][1]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.35,
                                        child: Text(
                                          "${timetable[5][1][1]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.35,
                                        child: Text(
                                          "${timetable[5][2][1]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          timetable[8][1]["string2"],
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "${timetable[5][0][2]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "${timetable[5][1][2]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "${timetable[5][2][2]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.16,
                                        child: Text(
                                          timetable[8][1]["string3"],
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.16,
                                        child: Text(
                                          "${timetable[5][0][3]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.16,
                                        child: Text(
                                          "${timetable[5][1][3]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.16,
                                        child: Text(
                                          "${timetable[5][2][3]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            child: Text("${timetable[8]["tableVer"]} ${timetable[8]["dayOfWeek"]}ダイヤ"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Expanded(
                  flex: 4, // 割合
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => fullTimetableView(timetable: timetable, size: size, tableIndex: 2),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: Container(
                      //color: Colors.black,
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Spacer(),
                          Container(
                            alignment: AlignmentDirectional.center,
                            height: size.height * 0.1,
                            width: size.width * 0.9,
                            child: Text(
                              timetable[8][2]["title"],
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                alignment: AlignmentDirectional.center,
                                color: darkGrey,
                                height: size.height * 0.06 * 4,
                                width: size.width * (0.2 + 0.35 + 0.2 + 0.16) * 1.05,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: AlignmentDirectional.center,
                                          color: darkGrey,
                                          height: size.height * 0.06,
                                          width: size.width * 0.2,
                                          child: Text(
                                            timetable[8][2]["string0"],
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                        Container(
                                          alignment: AlignmentDirectional.center,
                                          color: darkGrey,
                                          height: size.height * 0.06,
                                          width: size.width * 0.2,
                                          child: Text(
                                            "${timetable[6][0][0]}",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                        Container(
                                          alignment: AlignmentDirectional.center,
                                          color: wasedaColor,
                                          height: size.height * 0.06,
                                          width: size.width * 0.2,
                                          child: Text(
                                            "${timetable[6][1][0]}",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                        Container(
                                          alignment: AlignmentDirectional.center,
                                          color: darkGrey,
                                          height: size.height * 0.06,
                                          width: size.width * 0.2,
                                          child: Text(
                                            "${timetable[6][2][0]}",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.35,
                                        child: Text(
                                          timetable[8][2]["string1"],
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.35,
                                        child: Text(
                                          "${timetable[6][0][1]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.35,
                                        child: Text(
                                          "${timetable[6][1][1]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.35,
                                        child: Text(
                                          "${timetable[6][2][1]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          timetable[8][2]["string2"],
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "${timetable[6][0][2]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "${timetable[6][1][2]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "${timetable[6][2][2]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.16,
                                        child: Text(
                                          timetable[8][2]["string3"],
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.16,
                                        child: Text(
                                          "${timetable[6][0][3]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.16,
                                        child: Text(
                                          "${timetable[6][1][3]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.16,
                                        child: Text(
                                          "${timetable[6][2][3]}",
                                          style: TextStyle(fontSize: 17),
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
                ),
                Expanded(
                  flex: 6, // 割合
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => fullTimetableView(timetable: timetable, size: size, tableIndex: 3),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: Container(
                      //color: Colors.black,
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Spacer(),
                          Container(
                            alignment: AlignmentDirectional.center,
                            height: size.height * 0.1,
                            width: size.width * 0.9,
                            child: Text(
                              timetable[8][3]["title"],
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                alignment: AlignmentDirectional.center,
                                color: darkGrey,
                                height: size.height * 0.06 * 4,
                                width: size.width * (0.2 + 0.35 + 0.2 + 0.16) * 1.05,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: AlignmentDirectional.center,
                                          color: darkGrey,
                                          height: size.height * 0.06,
                                          width: size.width * 0.2,
                                          child: Text(
                                            timetable[8][3]["string0"],
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                        Container(
                                          alignment: AlignmentDirectional.center,
                                          color: darkGrey,
                                          height: size.height * 0.06,
                                          width: size.width * 0.2,
                                          child: Text(
                                            "${timetable[7][0][0]}",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                        Container(
                                          alignment: AlignmentDirectional.center,
                                          color: wasedaColor,
                                          height: size.height * 0.06,
                                          width: size.width * 0.2,
                                          child: Text(
                                            "${timetable[7][1][0]}",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                        Container(
                                          alignment: AlignmentDirectional.center,
                                          color: darkGrey,
                                          height: size.height * 0.06,
                                          width: size.width * 0.2,
                                          child: Text(
                                            "${timetable[7][2][0]}",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.35,
                                        child: Text(
                                          timetable[8][3]["string1"],
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.35,
                                        child: Text(
                                          "${timetable[7][0][1]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.35,
                                        child: Text(
                                          "${timetable[7][1][1]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.35,
                                        child: Text(
                                          "${timetable[7][2][1]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          timetable[8][3]["string2"],
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "${timetable[7][0][2]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "${timetable[7][1][2]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "${timetable[7][2][2]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.16,
                                        child: Text(
                                          timetable[8][3]["string3"],
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.16,
                                        child: Text(
                                          "${timetable[7][0][3]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.16,
                                        child: Text(
                                          "${timetable[7][1][3]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.16,
                                        child: Text(
                                          "${timetable[7][2][3]}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            child: Text("${timetable[8]["tableVer"]} ${timetable[8]["dayOfWeek"]}ダイヤ"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
