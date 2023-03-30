import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'code.dart';
import 'CompactTimetableWidget.dart';
import 'AllTablePage.dart';

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
  Map timetable = code();
  int count = 0;

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
    final String dayOfWeek = timetable["fullTables"][timetable["tableInfo"]["selectedTableNames"][0]]["dayOfWeek"];
    final PageController controller = PageController();
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: controller,
          children: <Widget>[
            if (size.height > size.width) ...{
              // 縦長の画面の場合
              Column(
                children: <Widget>[
                  Expanded(
                    flex: 4, // 割合
                    child: CompactTimetableWidget(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width, tableIndex: 0),
                  ),
                  Expanded(
                    flex: 5, // 割合
                    child: CompactTimetableWidget(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width, tableIndex: 1),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "$dayOfWeekダイヤ   時刻表Ver: ${timetable["tableInfo"]["tableVer"]}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Expanded(
                    flex: 4, // 割合
                    child: CompactTimetableWidget(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width, tableIndex: 2),
                  ),
                  Expanded(
                    flex: 5, // 割合
                    child: CompactTimetableWidget(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width, tableIndex: 3),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "$dayOfWeekダイヤ   時刻表Ver: ${timetable["tableInfo"]["tableVer"]}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                ],
              ),
              AllTableListView(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width)
            } else ...{
              // Web版やiPadなどの横長の画面の場合
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CompactTimetableWidget(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width / 2.2, tableIndex: 0),
                        CompactTimetableWidget(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width / 2.2, tableIndex: 2),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CompactTimetableWidget(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width / 2.2, tableIndex: 1),
                        CompactTimetableWidget(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width / 2.2, tableIndex: 3),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "$dayOfWeekダイヤ   時刻表Ver: ${timetable["tableInfo"]["tableVer"]}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
              AllTableListView(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width / 2.2),
            }
          ],
        ),
      ),
    );
  }
}
