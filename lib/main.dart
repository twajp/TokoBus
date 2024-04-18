import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show SchedulerBinding;
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'code.dart';
import 'CompactTimetableWidget.dart';
import 'FullTimetableView.dart';

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
        // scheme: FlexScheme.hippieBlue,
        darkIsTrueBlack: true,
        background: Colors.black, // 背景
        primary: const Color.fromRGBO(142, 23, 40, 1), // 早稲田色
        secondary: const Color.fromRGBO(44, 44, 46, 1), // Containerの色
        tertiary: Colors.white24, // 非アクティブなドット色
        onBackground: Colors.white, // 背景色の上に書く文字・アイコン色
        // surface: const Color.fromRGBO(44, 44, 46, 1),// 勝手に色が変わるから使えない
        // useMaterial3: false,
        // surfaceTint: Colors.transparent,
        // applyElevationOverlayColor: false,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(fontSize: 30.0, color: Colors.white), // 時刻表名
          bodyLarge: TextStyle(fontSize: 17.0, color: Colors.white), // これから来るバス
        ),
        primaryTextTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 17.0, color: Colors.grey), // 過ぎたバス
          bodyMedium: TextStyle(fontSize: 14.0, color: Colors.grey), // 時刻表Ver
        ),
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
  final PageController controller = PageController(initialPage: 0);
  final _currentPageNotifier = ValueNotifier<int>(0);
  Map<String, dynamic> jsonData = {};

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
      showDateDialogIfNeeded(context, timetable: timetable);
    });
    downloadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final String dayOfWeek = timetable["fullTables"][timetable["tableInfo"]["selectedTableNames"][0]]["dayOfWeek"];
    final String timetableInfoString = "$dayOfWeekダイヤ   時刻表Ver: ${timetable["tableInfo"]["tableVer"]}";

    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return _buildPortraitLayout(size: size, timetable: timetable, timetableInfoString: timetableInfoString);
    } else {
      return _buildLandscapeLayout(size: size, timetable: timetable, timetableInfoString: timetableInfoString);
    }
  }

  _buildPortraitLayout({required Size size, required timetable, required timetableInfoString}) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/icon/icon_transparent.png', height: kToolbarHeight),
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text("大学公式PDFを開く"),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text("時刻表の間違いを報告する"),
                ),
                const PopupMenuItem<int>(
                  value: 2,
                  child: Text("TokoBusについて"),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                launchUrl(timetable["pdf_url"]["default"]);
              } else if (value == 1) {
                launchUrl("https://twajp.github.io/TokoBusWebsite/support");
              } else if (value == 2) {
                launchUrl("https://twajp.github.io/TokoBusWebsite/");
              }
            },
          ),
        ],
      ),
      drawer: drawerWidget(timetable: timetable, height: size.height, width: size.width),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 7,
                  child: PageView(
                    controller: controller,
                    onPageChanged: (int index) {
                      _currentPageNotifier.value = index;
                    },
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Expanded(child: CompactTimetableWidget(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width, tableIndex: 0)),
                          Expanded(child: CompactTimetableWidget(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width, tableIndex: 1)),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Expanded(child: CompactTimetableWidget(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width, tableIndex: 2)),
                          Expanded(child: CompactTimetableWidget(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width, tableIndex: 3)),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      timetableInfoString,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).primaryTextTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
            _buildCircleIndicator(size: size),
          ],
        ),
      ),
    );
  }

  _buildLandscapeLayout({required Size size, required timetable, required timetableInfoString}) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/icon/icon_transparent.png', height: kToolbarHeight),
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text("大学公式PDFを開く"),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text("時刻表の間違いを報告する"),
                ),
                const PopupMenuItem<int>(
                  value: 2,
                  child: Text("TokoBusについて"),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                launchUrl(timetable["pdf_url"]["default"]);
              } else if (value == 1) {
                launchUrl("https://twajp.github.io/TokoBusWebsite/support");
              } else if (value == 2) {
                launchUrl("https://twajp.github.io/TokoBusWebsite/");
              }
            },
          ),
        ],
      ),
      drawer: drawerWidget(timetable: timetable, height: size.height, width: size.height),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: <Widget>[
                      Expanded(child: CompactTimetableWidget(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width, tableIndex: 0)),
                      Expanded(child: CompactTimetableWidget(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width, tableIndex: 1)),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Expanded(child: CompactTimetableWidget(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width, tableIndex: 2)),
                      Expanded(child: CompactTimetableWidget(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width, tableIndex: 3)),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  timetableInfoString,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).primaryTextTheme.bodyMedium,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  drawerWidget({required timetable, required height, required width}) {
    final String weekdaysTimetableName = timetable["fullTables"]["stationCampusWeekdays"]["dayOfWeek"] + "ダイヤ";
    final String saturdaysTimetableName = timetable["fullTables"]["stationCampusSaturdays"]["dayOfWeek"] + "ダイヤ";
    final String sundaysHolidaysTimetableName = timetable["fullTables"]["stationCampusSundaysHolidays"]["dayOfWeek"] + "ダイヤ";
    String specialTimetableName;
    if (timetable["fullTables"].containsKey("stationCampusSpecial")) {
      specialTimetableName = timetable["fullTables"]["stationCampusSpecial"]["dayOfWeek"] + "ダイヤ";
    } else {
      specialTimetableName = "";
    }
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset('assets/icon/icon_transparent.png'),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    ExpansionTile(
                      title: Text(weekdaysTimetableName),
                      leading: const Icon(Icons.school),
                      textColor: Theme.of(context).colorScheme.onBackground,
                      iconColor: Theme.of(context).colorScheme.onBackground,
                      collapsedTextColor: Theme.of(context).colorScheme.onBackground,
                      collapsedIconColor: Theme.of(context).colorScheme.onBackground,
                      initiallyExpanded: true,
                      childrenPadding: const EdgeInsets.only(left: 56),
                      children: [
                        ListTile(
                          title: Text(timetable["tableInfo"][0]["title"]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullTimetableView(tableName: "stationCampusWeekdays", timetable: timetable, deviceHeight: height, deviceWidth: width),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: Text(timetable["tableInfo"][1]["title"]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullTimetableView(tableName: "campusStationWeekdays", timetable: timetable, deviceHeight: height, deviceWidth: width),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: Text(timetable["tableInfo"][2]["title"]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullTimetableView(tableName: "campusFRCWeekdays", timetable: timetable, deviceHeight: height, deviceWidth: width),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: Text(timetable["tableInfo"][3]["title"]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullTimetableView(tableName: "frcCampusWeekdays", timetable: timetable, deviceHeight: height, deviceWidth: width),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    if (specialTimetableName != "") ...{
                      ExpansionTile(
                        title: Text(specialTimetableName),
                        leading: const Icon(Icons.school),
                        textColor: Theme.of(context).colorScheme.onBackground,
                        iconColor: Theme.of(context).colorScheme.onBackground,
                        collapsedTextColor: Theme.of(context).colorScheme.onBackground,
                        collapsedIconColor: Theme.of(context).colorScheme.onBackground,
                        childrenPadding: const EdgeInsets.only(left: 56),
                        children: [
                          ListTile(
                            title: Text(timetable["tableInfo"][0]["title"]),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullTimetableView(tableName: "stationCampusSpecial", timetable: timetable, deviceHeight: height, deviceWidth: width),
                                  fullscreenDialog: true,
                                ),
                              );
                            },
                          ),
                          ListTile(
                            title: Text(timetable["tableInfo"][1]["title"]),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullTimetableView(tableName: "campusStationSpecial", timetable: timetable, deviceHeight: height, deviceWidth: width),
                                  fullscreenDialog: true,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    },
                    ExpansionTile(
                      title: Text(saturdaysTimetableName),
                      leading: const Icon(Icons.weekend),
                      textColor: Theme.of(context).colorScheme.onBackground,
                      iconColor: Theme.of(context).colorScheme.onBackground,
                      collapsedTextColor: Theme.of(context).colorScheme.onBackground,
                      collapsedIconColor: Theme.of(context).colorScheme.onBackground,
                      childrenPadding: const EdgeInsets.only(left: 56),
                      children: [
                        ListTile(
                          title: Text(timetable["tableInfo"][0]["title"]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullTimetableView(tableName: "stationCampusSaturdays", timetable: timetable, deviceHeight: height, deviceWidth: width),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: Text(timetable["tableInfo"][1]["title"]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullTimetableView(tableName: "campusStationSaturdays", timetable: timetable, deviceHeight: height, deviceWidth: width),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: Text(timetable["tableInfo"][2]["title"]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullTimetableView(tableName: "campusFRCSaturdays", timetable: timetable, deviceHeight: height, deviceWidth: width),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: Text(timetable["tableInfo"][3]["title"]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullTimetableView(tableName: "frcCampusSaturdays", timetable: timetable, deviceHeight: height, deviceWidth: width),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text(sundaysHolidaysTimetableName),
                      leading: const Icon(Icons.weekend),
                      textColor: Theme.of(context).colorScheme.onBackground,
                      iconColor: Theme.of(context).colorScheme.onBackground,
                      collapsedTextColor: Theme.of(context).colorScheme.onBackground,
                      collapsedIconColor: Theme.of(context).colorScheme.onBackground,
                      childrenPadding: const EdgeInsets.only(left: 56),
                      children: [
                        ListTile(
                          title: Text(timetable["tableInfo"][0]["title"]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullTimetableView(tableName: "stationCampusSundaysHolidays", timetable: timetable, deviceHeight: height, deviceWidth: width),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: Text(timetable["tableInfo"][1]["title"]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullTimetableView(tableName: "campusStationSundaysHolidays", timetable: timetable, deviceHeight: height, deviceWidth: width),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildCircleIndicator({required Size size}) {
    int itemCount = 2;
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CirclePageIndicator(
          itemCount: itemCount,
          dotColor: Theme.of(context).colorScheme.tertiary,
          selectedDotColor: Theme.of(context).colorScheme.onBackground,
          currentPageNotifier: _currentPageNotifier,
        ),
      ),
    );
  }

  void showDateDialogIfNeeded(BuildContext context, {required timetable}) {
    DateTime currentDate = DateTime.now();
    String url = timetable["pdf_url"]["default"];
    if (timetable["pdf_url"]["special"].containsKey(DateTime(currentDate.year, currentDate.month, currentDate.day))) {
      url = timetable["pdf_url"]["special"][DateTime(currentDate.year, currentDate.month, currentDate.day)];
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("本日は特別ダイヤです"),
            content: const Text("本日の特別ダイヤは未対応です。\n大学ウェブサイトのPDFを確認しますか？"),
            actions: [
              TextButton(
                child: const Text("閉じる"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                onPressed: () async {
                  await launch(url);
                  if (!mounted) return;
                  Navigator.of(context).pop();
                },
                child: const Text("開く"),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> downloadJsonData() async {
    final url = Uri.parse("https://raw.githubusercontent.com/twajp/TokoBus/main/data/dialog.json");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      setState(() {
        jsonData = jsonBody;
      });
      if (jsonData["flag"] == true) {
        _showJsonAlert();
      }
    } else {
      throw Exception("Failed to load JSON data");
    }
  }

  void _showJsonAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(jsonData["title"]),
          content: Text(jsonData["content"]),
          actions: [
            TextButton(
              child: const Text("閉じる"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            if (jsonData["url"] != "") ...{
              TextButton(
                onPressed: () async {
                  await launch(jsonData["url"]);
                  if (!mounted) return;
                  Navigator.of(context).pop();
                },
                child: const Text("開く"),
              ),
            },
          ],
        );
      },
    );
  }

  Future<void> launchUrl(url) async {
    if (!await launch(url)) {
      throw Exception("Could not launch $url");
    }
  }
}
