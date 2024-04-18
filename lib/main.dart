import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show SchedulerBinding;
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'services/code.dart';
import 'services/show_dialog_on_special_date.dart';
import 'services/json_alart_handler.dart';
import 'pages/build_portrait_layout.dart';
import 'pages/build_landscape_layout.dart';

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
      showDialogOnSpecialDate(context: context, timetable: timetable);
    });
    jsonAlertHandler(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final String dayOfWeek = timetable["fullTables"][timetable["tableInfo"]["selectedTableNames"][0]]["dayOfWeek"];
    final String timetableInfoString = "$dayOfWeekダイヤ   時刻表Ver: ${timetable["tableInfo"]["tableVer"]}";

    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return buildPortraitLayout(context: context, size: size, timetable: timetable, timetableInfoString: timetableInfoString);
    } else {
      return buildLandscapeLayout(context: context, size: size, timetable: timetable, timetableInfoString: timetableInfoString);
    }
  }
}
