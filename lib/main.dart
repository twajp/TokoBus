import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show SchedulerBinding;
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
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
  final PageController controller = PageController(initialPage: 1);
  final _currentPageNotifier = ValueNotifier<int>(1);

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
    SchedulerBinding.instance.addPostFrameCallback((_) {
      showDateDialogIfNeeded(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final String dayOfWeek = timetable["fullTables"][timetable["tableInfo"]["selectedTableNames"][0]]["dayOfWeek"];
    final String timetableInfoString = "$dayOfWeekダイヤ   時刻表Ver: ${timetable["tableInfo"]["tableVer"]}";

    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return _buildVerticalLayout(size: size, timetable: timetable, timetableInfoString: timetableInfoString);
    } else {
      return _buildHorizontalLayout(size: size, timetable: timetable, timetableInfoString: timetableInfoString);
    }
  }

  _buildVerticalLayout({required Size size, required timetable, required timetableInfoString}) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: controller,
              onPageChanged: (int index) {
                _currentPageNotifier.value = index;
              },
              children: <Widget>[
                AllTableListView(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width, showTimetableInfo: true),
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
                          timetableInfoString,
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
                          timetableInfoString,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            _buildCircleIndicator(size: size),
          ],
        ),
      ),
    );
  }

  _buildHorizontalLayout({required Size size, required timetable, required timetableInfoString}) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CompactTimetableWidget(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width / 3.1, tableIndex: 0),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CompactTimetableWidget(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width / 3.1, tableIndex: 1),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CompactTimetableWidget(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width / 3.1, tableIndex: 2),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CompactTimetableWidget(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width / 3.1, tableIndex: 3),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            timetableInfoString,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Expanded(
                        flex: 9,
                        child: AllTableListView(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width / 3.1, showTimetableInfo: false),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // Expanded(
            //   flex: 1,
            //   child: Container(
            //     alignment: Alignment.center,
            //     child: Text(
            //       timetableInfoString,
            //       style: const TextStyle(color: Colors.grey),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  _buildCircleIndicator({required Size size}) {
    int itemCount;
    if (size.height > size.width) {
      itemCount = 3;
    } else {
      itemCount = 2;
    }
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CirclePageIndicator(
          itemCount: itemCount,
          dotColor: Colors.white24,
          selectedDotColor: Colors.white,
          currentPageNotifier: _currentPageNotifier,
        ),
      ),
    );
  }

  void showDateDialogIfNeeded(BuildContext context) {
    DateTime currentDate = DateTime.now();
    List specialDates = [
      DateTime(2023, 07, 22),
      DateTime(2023, 08, 05),
      DateTime(2023, 08, 06),
      DateTime(2023, 08, 26),
      DateTime(2023, 09, 02),
      DateTime(2023, 09, 03),
      DateTime(2023, 09, 09),
      DateTime(2023, 09, 23),
      DateTime(2023, 09, 30),
    ];

    for (int i = 0; i < specialDates.length; i++) {
      if (currentDate.year == specialDates[i].year && currentDate.month == specialDates[i].month && currentDate.day == specialDates[i].day) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("本日は特別ダイヤです"),
              content: const Text("本日の特別ダイヤは未対応です。\n"
                  "大学ウェブサイトのPDFを確認しますか？"),
              actions: [
                TextButton(
                  child: const Text("閉じる"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("開く"),
                  onPressed: () async {
                    const url = "https://www.waseda.jp/tokorozawa/kg/doc/bus/School_Bus_Timetable_for_Summer_Vacation(from_1_August_2023_to_4_October_%202023).pdf";
                    await launch(url);
                    if (!mounted) return;
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }
}
