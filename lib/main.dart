import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'code.dart';
import 'compactTimetableWidget.dart';

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
                  child: compactTimetableWidget(timetable: timetable, size: size, tableIndex: 0),
                ),
                Expanded(
                  flex: 6, // 割合
                  child:compactTimetableWidget(timetable: timetable, size: size, tableIndex: 1),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Expanded(
                  flex: 4, // 割合
                  child: compactTimetableWidget(timetable: timetable, size: size, tableIndex: 2),
                ),
                Expanded(
                  flex: 6, // 割合
                  child: compactTimetableWidget(timetable: timetable, size: size, tableIndex: 3),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
