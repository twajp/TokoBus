import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'code.dart';

class FullTimetableView extends StatefulWidget {
  final Map timetable;
  final double deviceHeight;
  final double deviceWidth;
  final String tableName;

  const FullTimetableView({super.key, required this.timetable, required this.deviceHeight, required this.deviceWidth, required this.tableName});

  @override
  State<FullTimetableView> createState() => _FullTimetableViewState();
}

class _FullTimetableViewState extends State<FullTimetableView> {
  // 状態を管理する変数
  late Map timetable;
  late double deviceHeight;
  late double deviceWidth;
  late String tableName;

  final _key = GlobalKey();
  double scrollViewHeight = 0;

  @override
  void initState() {
    super.initState();
    // 受け取ったデータを状態を管理する変数に格納
    timetable = widget.timetable;
    deviceHeight = widget.deviceHeight;
    deviceWidth = widget.deviceWidth;
    tableName = widget.tableName;
    mainLoop();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        scrollViewHeight = _key.currentContext!.size!.height;
      });
    });
  }

  Future<void> mainLoop() async {
    while (true) {
      await Future<void>.delayed(const Duration(seconds: 1));
      setState(() {
        timetable = code();
      });
    }
  }

  double setInitialScrollOffset({required Key key, required int nextBusIndex}) {
    double initialScrollOffset = 0;
    final numberOfBuses = timetable["fullTables"][tableName]["table"].length;
    final rowHeight = deviceHeight * 0.05;
    if ((nextBusIndex - 1) * deviceHeight * 0.05 < 0) {
      //　始発前
      initialScrollOffset = 0;
      print("1 $initialScrollOffset");
    } else if ((numberOfBuses - nextBusIndex) * rowHeight + 50 > scrollViewHeight) {
      initialScrollOffset = (nextBusIndex - 1) * rowHeight;
      print("2 $initialScrollOffset");
    } else {
      //last - nextBusIndex > key
      initialScrollOffset = numberOfBuses * rowHeight - scrollViewHeight;
      print("3 $initialScrollOffset");
    }
    return initialScrollOffset;
  }

  @override
  Widget build(BuildContext context) {
    const Color wasedaColor = Color.fromRGBO(142, 23, 40, 1);
    final int tableFormat = timetable["fullTables"][tableName]["tableFormat"];
    return Dismissible(
      direction: DismissDirection.down,
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
                  key: _key,
                  controller: ScrollController(initialScrollOffset: setInitialScrollOffset(key: _key, nextBusIndex: timetable["fullTables"][tableName]["nextBusIndex"])),
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

  const OneRow({super.key, required this.timetable, required this.deviceHeight, required this.deviceWidth, required this.textStyle, required this.backgroundColor, required this.tableName, required this.rowIndex});

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
