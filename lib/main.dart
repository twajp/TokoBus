import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("TokoBus"),
        ),
        body: Center(
          child: Column(
            children: [
              Text("小手指駅→キャンパス"),
              Text("キャンパス→小手指駅"),
            ],
          ),
        ),
      ),
    );
  }
}
