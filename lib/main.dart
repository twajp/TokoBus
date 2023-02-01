import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'code.dart';

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
  static const Color wasedaColor = Color.fromRGBO(44, 44, 46, 1);
  static const Color darkGrey = Color.fromRGBO(142, 23, 40, 1);

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

  void _showBottomSheetMenu(BuildContext context, Size size) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (builder) {
          return Container(
            height: size.height*0.9,
            color: Colors.transparent,
            child: Container(
              alignment: AlignmentDirectional.topCenter,
              child: Row(
                children: [
                  Container(
                    alignment: AlignmentDirectional.center,
                    color: wasedaColor,
                    height: size.height * 0.06,
                    width: size.width * 0.2,
                    child: Text(
                      "発車時刻",
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.center,
                    color: wasedaColor,
                    height: size.height * 0.06,
                    width: size.width * 0.2,
                    child: Text(
                      "${timetable[7][0][0]}",
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.center,
                    color: darkGrey,
                    height: size.height * 0.06,
                    width: size.width * 0.2,
                    child: Text(
                      "${timetable[7][1][0]}",
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.center,
                    color: wasedaColor,
                    height: size.height * 0.06,
                    width: size.width * 0.2,
                    child: Text(
                      "${timetable[7][2][0]}",
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
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
                    onTap: (){
                      _showBottomSheetMenu(context, size);
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
                              "小手指駅 → キャンパス",
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                alignment: AlignmentDirectional.center,
                                color: wasedaColor,
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
                                          color: wasedaColor,
                                          height: size.height * 0.06,
                                          width: size.width * 0.2,
                                          child: Text(
                                            "発車時刻",
                                            style: TextStyle(fontSize: 19),
                                          ),
                                        ),
                                        Container(
                                          alignment: AlignmentDirectional.center,
                                          color: wasedaColor,
                                          height: size.height * 0.06,
                                          width: size.width * 0.2,
                                          child: Text(
                                            "${timetable[4][0][0]}",
                                            style: TextStyle(fontSize: 19),
                                          ),
                                        ),
                                        Container(
                                          alignment: AlignmentDirectional.center,
                                          color: darkGrey,
                                          height: size.height * 0.06,
                                          width: size.width * 0.2,
                                          child: Text(
                                            "${timetable[4][1][0]}",
                                            style: TextStyle(fontSize: 19),
                                          ),
                                        ),
                                        Container(
                                          alignment: AlignmentDirectional.center,
                                          color: wasedaColor,
                                          height: size.height * 0.06,
                                          width: size.width * 0.2,
                                          child: Text(
                                            "${timetable[4][2][0]}",
                                            style: TextStyle(fontSize: 19),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.35,
                                        child: Text(
                                          "残り時間",
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.35,
                                        child: Text(
                                          "${timetable[4][0][1]}",
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.35,
                                        child: Text(
                                          "${timetable[4][1][1]}",
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.35,
                                        child: Text(
                                          "${timetable[4][2][1]}",
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "発車場所",
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "${timetable[4][0][2]}",
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "${timetable[4][1][2]}",
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "${timetable[4][2][2]}",
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.16,
                                        child: Text(
                                          "車椅子",
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.16,
                                        child: Text(
                                          "${timetable[4][0][3]}",
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.16,
                                        child: Text(
                                          "${timetable[4][1][3]}",
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.16,
                                        child: Text(
                                          "${timetable[4][2][3]}",
                                          style: TextStyle(fontSize: 19),
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
                            "キャンパス → 小手指駅",
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              alignment: AlignmentDirectional.center,
                              color: wasedaColor,
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
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "発車時刻",
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "${timetable[5][0][0]}",
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "${timetable[5][1][0]}",
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "${timetable[5][2][0]}",
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.35,
                                      child: Text(
                                        "残り時間",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.35,
                                      child: Text(
                                        "${timetable[5][0][1]}",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: darkGrey,
                                      height: size.height * 0.06,
                                      width: size.width * 0.35,
                                      child: Text(
                                        "${timetable[5][1][1]}",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.35,
                                      child: Text(
                                        "${timetable[5][2][1]}",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.2,
                                      child: Text(
                                        "降車場所",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.2,
                                      child: Text(
                                        "${timetable[5][0][2]}",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: darkGrey,
                                      height: size.height * 0.06,
                                      width: size.width * 0.2,
                                      child: Text(
                                        "${timetable[5][1][2]}",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.2,
                                      child: Text(
                                        "${timetable[5][2][2]}",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.16,
                                      child: Text(
                                        "車椅子",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.16,
                                      child: Text(
                                        "${timetable[5][0][3]}",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: darkGrey,
                                      height: size.height * 0.06,
                                      width: size.width * 0.16,
                                      child: Text(
                                        "${timetable[5][1][3]}",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.16,
                                      child: Text(
                                        "${timetable[5][2][3]}",
                                        style: TextStyle(fontSize: 19),
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
              ],
            ),
            Column(
              children: <Widget>[
                Expanded(
                  flex: 4, // 割合
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
                            "キャンパス → FRC",
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              alignment: AlignmentDirectional.center,
                              color: wasedaColor,
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
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "発車時刻",
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "${timetable[6][0][0]}",
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "${timetable[6][1][0]}",
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "${timetable[6][2][0]}",
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.35,
                                      child: Text(
                                        "残り時間",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.35,
                                      child: Text(
                                        "${timetable[6][0][1]}",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: darkGrey,
                                      height: size.height * 0.06,
                                      width: size.width * 0.35,
                                      child: Text(
                                        "${timetable[6][1][1]}",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.35,
                                      child: Text(
                                        "${timetable[6][2][1]}",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.2,
                                      child: Text(
                                        "発車場所",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.2,
                                      child: Text(
                                        "${timetable[6][0][2]}",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: darkGrey,
                                      height: size.height * 0.06,
                                      width: size.width * 0.2,
                                      child: Text(
                                        "${timetable[6][1][2]}",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.2,
                                      child: Text(
                                        "${timetable[6][2][2]}",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.16,
                                      child: Text(
                                        "接続",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.16,
                                      child: Text(
                                        "${timetable[6][0][3]}",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: darkGrey,
                                      height: size.height * 0.06,
                                      width: size.width * 0.16,
                                      child: Text(
                                        "${timetable[6][1][3]}",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.16,
                                      child: Text(
                                        "${timetable[6][2][3]}",
                                        style: TextStyle(fontSize: 19),
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
                  flex: 6, // 割合
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
                            "FRC → キャンパス",
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              alignment: AlignmentDirectional.center,
                              color: wasedaColor,
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
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "発車時刻",
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "${timetable[7][0][0]}",
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: darkGrey,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "${timetable[7][1][0]}",
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        color: wasedaColor,
                                        height: size.height * 0.06,
                                        width: size.width * 0.2,
                                        child: Text(
                                          "${timetable[7][2][0]}",
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.35,
                                      child: Text(
                                        "残り時間",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.35,
                                      child: Text(
                                        "${timetable[7][0][1]}",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: darkGrey,
                                      height: size.height * 0.06,
                                      width: size.width * 0.35,
                                      child: Text(
                                        "${timetable[7][1][1]}",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.35,
                                      child: Text(
                                        "${timetable[7][2][1]}",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.2,
                                      child: Text(
                                        "降車場所",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.2,
                                      child: Text(
                                        "${timetable[7][0][2]}",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: darkGrey,
                                      height: size.height * 0.06,
                                      width: size.width * 0.2,
                                      child: Text(
                                        "${timetable[7][1][2]}",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.2,
                                      child: Text(
                                        "${timetable[7][2][2]}",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.16,
                                      child: Text(
                                        "接続",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.16,
                                      child: Text(
                                        "${timetable[7][0][3]}",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: darkGrey,
                                      height: size.height * 0.06,
                                      width: size.width * 0.16,
                                      child: Text(
                                        "${timetable[7][1][3]}",
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      color: wasedaColor,
                                      height: size.height * 0.06,
                                      width: size.width * 0.16,
                                      child: Text(
                                        "${timetable[7][2][3]}",
                                        style: TextStyle(fontSize: 19),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
