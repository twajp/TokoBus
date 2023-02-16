import 'package:flutter/material.dart';
import 'package:TokoBus/FullTimetableView.dart';

class AllTableListView extends StatelessWidget {
  final Map timetable;
  final double deviceHeight;
  final double deviceWidth;

  const AllTableListView({
    Key? key,
    required this.timetable,
    required this.deviceHeight,
    required this.deviceWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 10, // 割合
          child: Column(
            children: [
              // timetable["fullTables"].keys.map<Widget>((tableName) => TableNameOneRowWidget(timetable: timetable, deviceHeight: deviceHeight, deviceWidth: deviceWidth, tableName: tableName)).toList(),
              const Spacer(),

              Container(
                alignment: AlignmentDirectional.center,
                height: deviceHeight * 0.07,
                width: deviceWidth * 0.9,
                child: const Text(
                  "平日ダイヤ",
                  style: TextStyle(fontSize: 30),
                  softWrap: false,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TableNameOneRowWidget(timetable: timetable, deviceHeight: deviceHeight, deviceWidth: deviceWidth, widgetWidth: deviceWidth / 2, tableName: "stationCampusWeekdays"),
                  TableNameOneRowWidget(timetable: timetable, deviceHeight: deviceHeight, deviceWidth: deviceWidth, widgetWidth: deviceWidth / 2.4, tableName: "campusFRCWeekdays"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TableNameOneRowWidget(timetable: timetable, deviceHeight: deviceHeight, deviceWidth: deviceWidth, widgetWidth: deviceWidth / 2, tableName: "campusStationWeekdays"),
                  TableNameOneRowWidget(timetable: timetable, deviceHeight: deviceHeight, deviceWidth: deviceWidth, widgetWidth: deviceWidth / 2.4, tableName: "frcCampusWeekdays"),
                ],
              ),

              const Spacer(),

              Container(
                alignment: AlignmentDirectional.center,
                height: deviceHeight * 0.07,
                width: deviceWidth * 0.9,
                child: const Text(
                  "土曜日ダイヤ",
                  style: TextStyle(fontSize: 30),
                  softWrap: false,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TableNameOneRowWidget(timetable: timetable, deviceHeight: deviceHeight, deviceWidth: deviceWidth, widgetWidth: deviceWidth / 2, tableName: "stationCampusSaturdays"),
                  TableNameOneRowWidget(timetable: timetable, deviceHeight: deviceHeight, deviceWidth: deviceWidth, widgetWidth: deviceWidth / 2.4, tableName: "campusFRCSaturdays"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TableNameOneRowWidget(timetable: timetable, deviceHeight: deviceHeight, deviceWidth: deviceWidth, widgetWidth: deviceWidth / 2, tableName: "campusStationSaturdays"),
                  TableNameOneRowWidget(timetable: timetable, deviceHeight: deviceHeight, deviceWidth: deviceWidth, widgetWidth: deviceWidth / 2.4, tableName: "frcCampusSaturdays"),
                ],
              ),

              const Spacer(),

              Container(
                alignment: AlignmentDirectional.center,
                height: deviceHeight * 0.07,
                width: deviceWidth * 0.9,
                child: const Text(
                  "日曜日/祝日ダイヤ",
                  style: TextStyle(fontSize: 30),
                  softWrap: false,
                ),
              ),
              TableNameOneRowWidget(timetable: timetable, deviceHeight: deviceHeight, deviceWidth: deviceWidth, widgetWidth: deviceWidth / 2 + deviceWidth / 2.4 + 4 * 2, tableName: "stationCampusSundaysHolidays"),
              TableNameOneRowWidget(timetable: timetable, deviceHeight: deviceHeight, deviceWidth: deviceWidth, widgetWidth: deviceWidth / 2 + deviceWidth / 2.4 + 4 * 2, tableName: "campusStationSundaysHolidays"),

              const Spacer(),

              Container(
                alignment: AlignmentDirectional.center,
                height: deviceHeight * 0.07,
                width: deviceWidth * 0.9,
                child: const Text(
                  "3/28特別ダイヤ",
                  style: TextStyle(fontSize: 30),
                  softWrap: false,
                ),
              ),
              TableNameOneRowWidget(timetable: timetable, deviceHeight: deviceHeight, deviceWidth: deviceWidth, widgetWidth: deviceWidth / 2 + deviceWidth / 2.4 + 4 * 2, tableName: "stationCampusSpecial"),
              TableNameOneRowWidget(timetable: timetable, deviceHeight: deviceHeight, deviceWidth: deviceWidth, widgetWidth: deviceWidth / 2 + deviceWidth / 2.4 + 4 * 2, tableName: "campusStationSpecial"),

              const Spacer(),

              Container(
                alignment: Alignment.bottomCenter,
                height: 50,
                child: Text(
                  "時刻表Ver: ${timetable["tableInfo"]["tableVer"]}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}

class TableNameOneRowWidget extends StatelessWidget {
  final Map timetable;
  final double deviceHeight;
  final double deviceWidth;
  final double widgetWidth;
  final String tableName;

  const TableNameOneRowWidget({
    Key? key,
    required this.timetable,
    required this.deviceHeight,
    required this.deviceWidth,
    required this.widgetWidth,
    required this.tableName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color darkGrey = Color.fromRGBO(44, 44, 46, 1);
    final int tableFormat = timetable["fullTables"][tableName]["tableFormat"];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullTimetableView(timetable: timetable, deviceHeight: deviceHeight, deviceWidth: deviceWidth, tableName: tableName),
            fullscreenDialog: true,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          alignment: AlignmentDirectional.center,
          height: deviceHeight * 0.05,
          width: widgetWidth,
          color: darkGrey,
          child: Text(
            timetable["tableInfo"][tableFormat]["title"],
            style: const TextStyle(fontSize: 17),
            softWrap: false,
          ),
        ),
      ),
    );
  }
}
