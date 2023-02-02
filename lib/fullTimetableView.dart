import 'package:flutter/material.dart';
import 'code.dart';

class fullTimetableView extends StatefulWidget {
  final List timetable;
  final Size size;
  final int tableIndex;

  const fullTimetableView({Key? key, required this.timetable, required this.size, required this.tableIndex}) : super(key: key);

  @override
  State<fullTimetableView> createState() => _fullTimetableViewState();
}

class _fullTimetableViewState extends State<fullTimetableView> {
  // 状態を管理する変数
  late List timetable;
  late Size size;
  late int tableIndex;

  @override
  void initState() {
    super.initState();
    // 受け取ったデータを状態を管理する変数に格納
    timetable = widget.timetable;
    size = widget.size;
    tableIndex = widget.tableIndex;
    mainLoop();
  }

  Future<void> mainLoop() async {
    while (true) {
      await Future<void>.delayed(const Duration(seconds: 1));
      setState(() {
        timetable = code();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //Color wasedaColor = Color.fromRGBO(44*2, 44*2, 46*2, 1);
    Color wasedaColor = Colors.red;
    return Scaffold(
      appBar: AppBar(
        title: Text(timetable[8][tableIndex]["title"]),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          //alignment: AlignmentDirectional.topCenter,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: AlignmentDirectional.center,
                    height: size.height * 0.05,
                    width: size.width * 0.2,
                    child: Text(
                      timetable[8][tableIndex]["string0"],
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.center,
                    height: size.height * 0.05,
                    width: size.width * 0.4,
                    child: Text(
                      timetable[8][tableIndex]["string1"],
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.center,
                    height: size.height * 0.05,
                    width: size.width * 0.2,
                    child: Text(
                      timetable[8][tableIndex]["string2"],
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.center,
                    height: size.height * 0.05,
                    width: size.width * 0.16,
                    child: Text(
                      timetable[8][tableIndex]["string3"],
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              for (int i = 0; i < timetable[tableIndex].length; i++) ...{
                if (i == timetable[8][tableIndex]["nextBusIndex"]) ...{
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: AlignmentDirectional.center,
                        height: size.height * 0.05,
                        width: size.width * 0.2,
                        child: Text(
                          timetable[tableIndex][i][4],
                          style: TextStyle(fontSize: 18, color: wasedaColor),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        height: size.height * 0.05,
                        width: size.width * 0.4,
                        child: Text(
                          timetable[tableIndex][i][5],
                          style: TextStyle(fontSize: 18, color: wasedaColor),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        height: size.height * 0.05,
                        width: size.width * 0.2,
                        child: Text(
                          timetable[tableIndex][i][6],
                          style: TextStyle(fontSize: 18, color: wasedaColor),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        height: size.height * 0.05,
                        width: size.width * 0.16,
                        child: Text(
                          timetable[tableIndex][i][7],
                          style: TextStyle(fontSize: 18, color: wasedaColor),
                        ),
                      ),
                    ],
                  ),
                } else ...{
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: AlignmentDirectional.center,
                        height: size.height * 0.05,
                        width: size.width * 0.2,
                        child: Text(
                          timetable[tableIndex][i][4],
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        height: size.height * 0.05,
                        width: size.width * 0.4,
                        child: Text(
                          timetable[tableIndex][i][5],
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        height: size.height * 0.05,
                        width: size.width * 0.2,
                        child: Text(
                          timetable[tableIndex][i][6],
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        height: size.height * 0.05,
                        width: size.width * 0.16,
                        child: Text(
                          timetable[tableIndex][i][7],
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                },
              },
              Container(
                alignment: Alignment.center,
                height: 50,
                child: Text(timetable[8]["tableVer"]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
