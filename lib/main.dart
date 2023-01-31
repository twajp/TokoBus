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
        print(timetableCompact);
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${timetableCompact[0][0]} ${timetableCompact[0][1]} ${timetableCompact[0][2]} ${timetableCompact[0][3]}"),
            Text("${timetableCompact[1][0]} ${timetableCompact[1][1]} ${timetableCompact[1][2]} ${timetableCompact[1][3]}"),
            Text("${timetableCompact[2][0]} ${timetableCompact[2][1]} ${timetableCompact[2][2]} ${timetableCompact[2][3]}"),
          ],
        ),
      ),
    );
  }
}
