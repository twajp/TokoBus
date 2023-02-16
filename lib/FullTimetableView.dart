import 'package:flutter/material.dart';
import 'code.dart';

class FullTimetableView extends StatefulWidget {
  final Map timetable;
  final double deviceHeight;
  final double deviceWidth;
  final String tableName;

  const FullTimetableView({Key? key, required this.timetable, required this.deviceHeight, required this.deviceWidth, required this.tableName}) : super(key: key);

  @override
  State<FullTimetableView> createState() => _FullTimetableViewState();
}

class _FullTimetableViewState extends State<FullTimetableView> {
  // 状態を管理する変数
  late Map timetable;
  late double deviceHeight;
  late double deviceWidth;
  late String tableName;

  @override
  void initState() {
    super.initState();
    // 受け取ったデータを状態を管理する変数に格納
    timetable = widget.timetable;
    deviceHeight = widget.deviceHeight;
    deviceWidth = widget.deviceWidth;
    tableName = widget.tableName;
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
    Color wasedaColor = const Color.fromRGBO(142, 23, 40, 1);
    final int tableFormat = timetable["fullTables"][tableName]["tableFormat"];
    return Dismissible(
      direction: DismissDirection.vertical,
      key: const Key("key"),
      onDismissed: (_) => Navigator.of(context).pop(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(timetable["tableInfo"][tableFormat]["title"]),
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: AlignmentDirectional.center,
                    height: deviceHeight * 0.05,
                    width: deviceWidth * 0.2,
                    child: Text(
                      timetable["tableInfo"][tableFormat]["string0"],
                      style: const TextStyle(fontSize: 17),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.center,
                    height: deviceHeight * 0.05,
                    width: deviceWidth * 0.4,
                    child: Text(
                      timetable["tableInfo"][tableFormat]["string1"],
                      style: const TextStyle(fontSize: 17),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.center,
                    height: deviceHeight * 0.05,
                    width: deviceWidth * 0.2,
                    child: Text(
                      timetable["tableInfo"][tableFormat]["string2"],
                      style: const TextStyle(fontSize: 17),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.center,
                    height: deviceHeight * 0.05,
                    width: deviceWidth * 0.16,
                    child: Text(
                      timetable["tableInfo"][tableFormat]["string3"],
                      style: const TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: ScrollController(
                    initialScrollOffset: (timetable["fullTables"][tableName]["nextBusIndex"] - 1) * deviceHeight * 0.05,
                  ),
                  child: Column(
                    children: [
                      for (int i = 0; i < timetable["fullTables"][tableName]["table"].length; i++) ...{
                        if (i == timetable["fullTables"][tableName]["nextBusIndex"]) ...{
                          OneRow(timetable: timetable, deviceHeight: deviceHeight, deviceWidth: deviceWidth, textStyle: const TextStyle(fontSize: 17), backgroundColor: wasedaColor, tableName: tableName, rowIndex: i),
                        } else if (i < timetable["fullTables"][tableName]["nextBusIndex"]) ...{
                          OneRow(timetable: timetable, deviceHeight: deviceHeight, deviceWidth: deviceWidth, textStyle: const TextStyle(fontSize: 17, color: Colors.grey), backgroundColor: Colors.black, tableName: tableName, rowIndex: i),
                        } else ...{
                          OneRow(timetable: timetable, deviceHeight: deviceHeight, deviceWidth: deviceWidth, textStyle: const TextStyle(fontSize: 17), backgroundColor: Colors.black, tableName: tableName, rowIndex: i)
                        },
                      },
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        child: Text(
                          "${timetable["fullTables"][tableName]["dayOfWeek"]}ダイヤ   時刻表Ver: ${timetable["tableInfo"]["tableVer"]}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OneRow extends StatelessWidget {
  final Map timetable;
  final double deviceHeight;
  final double deviceWidth;
  final TextStyle textStyle;
  final Color backgroundColor;
  final String tableName;
  final int rowIndex;

  const OneRow({Key? key, required this.timetable, required this.deviceHeight, required this.deviceWidth, required this.textStyle, required this.backgroundColor, required this.tableName, required this.rowIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: AlignmentDirectional.center,
          height: deviceHeight * 0.05,
          width: deviceWidth * 0.2,
          color: backgroundColor,
          child: Text(
            timetable["fullTables"][tableName]["table"][rowIndex][4],
            style: textStyle,
            softWrap: false,
          ),
        ),
        Container(
          alignment: AlignmentDirectional.center,
          height: deviceHeight * 0.05,
          width: deviceWidth * 0.4,
          color: backgroundColor,
          child: Text(
            timetable["fullTables"][tableName]["table"][rowIndex][5],
            style: textStyle,
            softWrap: false,
          ),
        ),
        Container(
          alignment: AlignmentDirectional.center,
          height: deviceHeight * 0.05,
          width: deviceWidth * 0.2,
          color: backgroundColor,
          child: Text(
            timetable["fullTables"][tableName]["table"][rowIndex][6],
            style: textStyle,
            softWrap: false,
          ),
        ),
        Container(
          alignment: AlignmentDirectional.center,
          height: deviceHeight * 0.05,
          width: deviceWidth * 0.16,
          color: backgroundColor,
          child: Text(
            timetable["fullTables"][tableName]["table"][rowIndex][7],
            style: textStyle,
            softWrap: false,
          ),
        ),
      ],
    );
  }
}
