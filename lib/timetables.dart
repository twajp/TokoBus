import 'package:nholiday_jp/nholiday_jp.dart';

// timetableの構造メモ
// timetable["fullTables"]["stationCampusWeekdays" -> "frcCampusSaturday"]["table"] == [[int 時, int 分, DateTime 時刻, Duration 残り時間, String 時:分, String 残り時間, String 場所, String 車椅子対応], ...]
// timetable["fullTables"]["stationCampusWeekdays" -> "frcCampusSaturday"]["nextBusIndex"] == int
// timetable["compactTables"][0 -> 3] == [[String 時:分, String 残り時間, String 場所, String 車椅子対応], * 3]
// timetable["tableInfo"] == 下のコード参照

Map timetables() {
  List stationCampusWeekdays = [
    [8, 15, "北口", "×"],
    [8, 25, "北口", "〇"],
    [8, 35, "北口", "×"],
    [8, 55, "北口", "×"],
    [9, 05, "北口", "×"],
    [9, 25, "北口", "×"],
    [9, 35, "北口", "×"],
    [9, 45, "北口", "×"],
    [10, 05, "北口", "〇"],
    [10, 25, "北口", "×"],
    [10, 55, "北口", "×"],
    [11, 25, "北口", "×"],
    [11, 55, "北口", "〇"],
    [12, 15, "北口", "×"],
    [12, 35, "北口", "×"],
    [12, 50, "南口", "×"],
    [13, 05, "南口", "×"],
    [13, 35, "北口", "〇"],
    [13, 55, "南口", "×"],
    [14, 25, "南口", "×"],
    [14, 55, "南口", "×"],
    [15, 35, "北口", "〇"],
    [15, 45, "南口", "×"],
    [16, 10, "南口", "×"],
    [16, 50, "南口", "×"],
    [17, 25, "北口", "〇"],
    [17, 45, "南口", "×"],
    [18, 00, "南口", "×"],
    [18, 35, "南口", "×"],
    [19, 15, "南口", "×"],
    [20, 15, "南口", "×"],
  ];

  List stationCampusSaturdays = [for (var value in stationCampusWeekdays) List.from(value)];

  List stationCampusSundaysHolidays = [
    [8, 15, "北口", "×"],
    [8, 55, "北口", "×"],
    [9, 45, "北口", "×"],
    [11, 25, "北口", "×"],
    [12, 15, "南口", "×"],
    [12, 55, "南口", "×"],
    [14, 45, "南口", "×"],
    [15, 45, "南口", "×"],
    [16, 45, "南口", "×"],
    [17, 25, "南口", "×"],
    [18, 15, "南口", "×"],
    [19, 45, "南口", "×"],
  ];

  List campusStationWeekdays = [
    [8, 45, "北口", "×"],
    [9, 35, "北口", "×"],
    [10, 05, "北口", "×"],
    [10, 35, "北口", "×"],
    [11, 05, "北口", "×"],
    [11, 25, "北口", "○"],
    [11, 55, "北口", "×"],
    [12, 15, "北口", "×"],
    [12, 35, "南口", "×"],
    [12, 50, "南口", "×"],
    [13, 05, "北口", "○"],
    [13, 40, "南口", "×"],
    [14, 10, "南口", "×"],
    [14, 40, "南口", "×"],
    [15, 05, "北口", "○"],
    [15, 30, "南口", "×"],
    [15, 55, "南口", "×"],
    [16, 15, "南口", "×"],
    [16, 35, "南口", "×"],
    [16, 55, "北口", "○"],
    [17, 15, "南口", "×"],
    [17, 30, "南口", "×"],
    [17, 45, "南口", "×"],
    [18, 00, "南口", "×"],
    [18, 20, "南口", "×"],
    [18, 40, "南口", "×"],
    [19, 00, "南口", "×"],
    [19, 20, "南口", "×"],
    [19, 40, "南口", "×"],
    [20, 00, "南口", "×"],
    [20, 20, "南口", "×"],
    [20, 40, "南口", "×"],
    [21, 10, "南口", "×"],
    [21, 40, "南口", "×"],
  ];

  List campusStationSaturdays = [for (var value in campusStationWeekdays) List.from(value)];

  List campusStationSundaysHolidays = [
    [8, 35, "北口", "×"],
    [9, 25, "北口", "×"],
    [11, 05, "北口", "×"],
    [12, 00, "南口", "×"],
    [12, 40, "南口", "×"],
    [14, 30, "南口", "×"],
    [15, 30, "南口", "×"],
    [16, 30, "南口", "×"],
    [17, 10, "南口", "×"],
    [18, 00, "南口", "×"],
    [19, 30, "南口", "×"],
    [21, 00, "南口", "×"],
  ];

  List campusFRCWeekdays = [
    [8, 35, "正門", "×"],
    [8, 45, "正門", "×"],
    [8, 55, "正門", "×"],
    [9, 15, "南門", "×"],
    [9, 25, "正門", "×"],
    [9, 45, "正門", "×"],
    [10, 15, "南門", "×"],
    [10, 25, "正門", "×"],
    [11, 45, "正門", "×"],
    [11, 55, "南門", "×"],
    [12, 05, "南門", "×"],
    [12, 15, "正門", "×"],
    [12, 45, "南門", "×"],
    [12, 55, "正門", "×"],
    [13, 05, "南門", "×"],
    [13, 35, "正門", "×"],
    [14, 00, "南門", "×"],
    [14, 20, "正門", "×"],
    [15, 15, "正門", "×"],
    [15, 40, "南門", "×"],
    [16, 00, "正門", "×"],
    [16, 25, "正門", "×"],
    [16, 35, "正門", "×"],
    [17, 00, "南門", "×"],
    [17, 10, "正門", "×"],
    [17, 45, "正門", "×"],
    [18, 00, "正門", "×"],
    [18, 10, "南門", "×"],
    [18, 20, "正門", "×"],
    [19, 40, "正門", "×"],
    [19, 50, "南門", "×"],
    [20, 05, "正門", "×"],
    [20, 25, "正門", "×"],
    [21, 20, "正門", "×"],
  ];

  List campusFRCSaturdays = [
    [8, 35, "正門", "×"],
    [8, 45, "正門", "×"],
    [8, 55, "正門", "×"],
    [9, 15, "南門", "×"],
    [9, 25, "正門", "×"],
    [9, 45, "正門", "×"],
    [10, 15, "南門", "×"],
    [10, 25, "正門", "×"],
    [11, 45, "正門", "×"],
    [11, 55, "南門", "×"],
    [12, 05, "南門", "×"],
    [12, 15, "正門", "×"],
    [12, 45, "南門", "×"],
    [12, 55, "正門", "×"],
    [13, 05, "南門", "×"],
    [13, 35, "正門", "×"],
    [14, 00, "南門", "×"],
    [14, 20, "正門", "×"],
    [15, 15, "正門", "×"],
    [15, 40, "南門", "×"],
    [16, 00, "正門", "×"],
    [16, 25, "正門", "×"],
    [16, 35, "正門", "×"],
    [17, 00, "南門", "×"],
    [17, 10, "正門", "×"],
    [17, 45, "正門", "×"],
    [18, 00, "正門", "×"],
    [18, 10, "南門", "×"],
    [18, 20, "正門", "×"],
    [19, 40, "正門", "×"],
    [19, 50, "南門", "×"],
    [20, 05, "正門", "×"],
    [20, 25, "正門", "×"],
    [21, 20, "正門", "×"],
  ];

  List frcCampusWeekdays = [
    [8, 40, "正門", "〇"],
    [8, 50, "正門", "×"],
    [9, 00, "南門", "×"],
    [9, 20, "正門", "×"],
    [9, 30, "正門", "〇"],
    [9, 50, "南門", "×"],
    [10, 20, "正門", "×"],
    [10, 30, "正門", "〇"],
    [11, 50, "南門", "×"],
    [12, 00, "南門", "×"],
    [12, 10, "正門", "〇"],
    [12, 20, "南門", "×"],
    [12, 50, "正門", "〇"],
    [13, 00, "南門", "×"],
    [13, 30, "正門", "〇"],
    [13, 40, "南門", "×"],
    [14, 05, "正門", "〇"],
    [14, 30, "正門", "〇"],
    [15, 20, "南門", "×"],
    [15, 45, "正門", "〇"],
    [16, 05, "正門", "〇"],
    [16, 30, "正門", "〇"],
    [16, 40, "南門", "×"],
    [17, 05, "正門", "〇"],
    [17, 25, "正門", "〇"],
    [17, 50, "正門", "〇"],
    [18, 05, "南門", "×"],
    [18, 15, "正門", "〇"],
    [18, 30, "正門", "〇"],
    [19, 45, "南門", "×"],
    [19, 55, "正門", "〇"],
    [20, 10, "正門", "〇"],
    [20, 30, "正門", "〇"],
    [21, 25, "正門", "〇"],
  ];

  List frcCampusSaturdays = [
    [8, 40, "正門", "〇"],
    [8, 50, "正門", "×"],
    [9, 00, "南門", "×"],
    [9, 20, "正門", "×"],
    [9, 30, "正門", "〇"],
    [9, 50, "南門", "×"],
    [10, 20, "正門", "×"],
    [10, 30, "正門", "〇"],
    [11, 50, "南門", "×"],
    [12, 00, "南門", "×"],
    [12, 10, "正門", "〇"],
    [12, 20, "南門", "×"],
    [12, 50, "正門", "〇"],
    [13, 00, "南門", "×"],
    [13, 30, "正門", "〇"],
    [13, 40, "南門", "×"],
    [14, 05, "正門", "〇"],
    [14, 30, "正門", "〇"],
    [15, 20, "南門", "×"],
    [15, 45, "正門", "〇"],
    [16, 05, "正門", "〇"],
    [16, 30, "正門", "〇"],
    [16, 40, "南門", "×"],
    [17, 05, "正門", "〇"],
    [17, 25, "正門", "〇"],
    [17, 50, "正門", "〇"],
    [18, 05, "南門", "×"],
    [18, 15, "正門", "〇"],
    [18, 30, "正門", "〇"],
    [19, 45, "南門", "×"],
    [19, 55, "正門", "〇"],
    [20, 10, "正門", "〇"],
    [20, 30, "正門", "〇"],
    [21, 25, "正門", "〇"],
  ];

  //特別ダイヤ
  List stationCampusSpecial = [
    [8, 15, "北口", "×"],
    [8, 25, "北口", "〇"],
    [8, 35, "北口", "×"],
    [8, 55, "北口", "×"],
    [9, 05, "北口", "×"],
    [9, 15, "北口", "×"],
    [9, 25, "北口", "×"],
    [9, 35, "北口", "×"],
    [9, 45, "北口", "×"],
    [10, 05, "北口", "〇"],
    [10, 25, "北口", "×"],
    [10, 55, "北口", "×"],
    [11, 25, "北口", "×"],
    [11, 55, "北口", "〇"],
    [12, 15, "北口", "×"],
    [12, 35, "北口", "×"],
    [12, 50, "南口", "×"],
    [13, 05, "南口", "×"],
    [13, 15, "南口", "×"],
    [13, 25, "南口", "×"],
    [13, 35, "北口", "〇"],
    [13, 55, "南口", "×"],
    [14, 25, "南口", "×"],
    [14, 55, "南口", "×"],
    [15, 35, "北口", "〇"],
    [15, 45, "南口", "×"],
    [16, 10, "南口", "×"],
    [16, 50, "南口", "×"],
    [17, 25, "北口", "〇"],
    [17, 45, "南口", "×"],
    [18, 00, "南口", "×"],
    [18, 35, "南口", "×"],
    [19, 15, "南口", "×"],
    [20, 15, "南口", "×"],
  ];

  //特別ダイヤ
  List campusStationSpecial = [
    [8, 45, "北口", "×"],
    [9, 35, "北口", "×"],
    [10, 05, "北口", "×"],
    [10, 35, "北口", "×"],
    [11, 05, "北口", "×"],
    [11, 25, "北口", "○"],
    [11, 55, "北口", "×"],
    [12, 15, "北口", "×"],
    [12, 35, "南口", "×"],
    [12, 50, "南口", "×"],
    [13, 05, "北口", "○"],
    [13, 40, "南口", "×"],
    [14, 10, "南口", "×"],
    [14, 40, "南口", "×"],
    [15, 05, "北口", "○"],
    [15, 30, "南口", "×"],
    [15, 40, "南口", "×"],
    [15, 45, "南口", "×"],
    [15, 50, "南口", "×"],
    [15, 55, "南口", "×"],
    [16, 15, "南口", "×"],
    [16, 35, "南口", "×"],
    [16, 55, "北口", "○"],
    [17, 15, "南口", "×"],
    [17, 30, "南口", "×"],
    [17, 45, "南口", "×"],
    [18, 00, "南口", "×"],
    [18, 20, "南口", "×"],
    [18, 40, "南口", "×"],
    [19, 00, "南口", "×"],
    [19, 20, "南口", "×"],
    [19, 40, "南口", "×"],
    [20, 00, "南口", "×"],
    [20, 20, "南口", "×"],
    [20, 40, "南口", "×"],
    [21, 10, "南口", "×"],
    [21, 40, "南口", "×"],
  ];

  List initCompact = [
    [
      "-",
      "-",
      "-",
      "-",
    ],
    [
      "-",
      "-",
      "-",
      "-",
    ],
    [
      "-",
      "-",
      "-",
      "-",
    ]
  ];

  Map timetable = {
    "fullTables": {
      "stationCampusWeekdays": {
        "table": stationCampusWeekdays,
        "dayOfWeek": "平日",
        "tableFormat": 0,
        "nextBusIndex": 1000,
      },
      "stationCampusSaturdays": {
        "table": stationCampusSaturdays,
        "dayOfWeek": "土曜日",
        "tableFormat": 0,
        "nextBusIndex": 1000,
      },
      "stationCampusSundaysHolidays": {
        "table": stationCampusSundaysHolidays,
        "dayOfWeek": "日曜日/祝日",
        "tableFormat": 0,
        "nextBusIndex": 1000,
      },
      "stationCampusSpecial": {
        "table": stationCampusSpecial,
        "dayOfWeek": "3/28特別",
        "tableFormat": 0,
        "nextBusIndex": 1000,
      },
      "campusStationWeekdays": {
        "table": campusStationWeekdays,
        "dayOfWeek": "平日",
        "tableFormat": 1,
        "nextBusIndex": 1000,
      },
      "campusStationSaturdays": {
        "table": campusStationSaturdays,
        "dayOfWeek": "土曜日",
        "tableFormat": 1,
        "nextBusIndex": 1000,
      },
      "campusStationSundaysHolidays": {
        "table": campusStationSundaysHolidays,
        "dayOfWeek": "日曜日/祝日",
        "tableFormat": 1,
        "nextBusIndex": 1000,
      },
      "campusStationSpecial": {
        "table": campusStationSpecial,
        "dayOfWeek": "3/28特別",
        "tableFormat": 1,
        "nextBusIndex": 1000,
      },
      "campusFRCWeekdays": {
        "table": campusFRCWeekdays,
        "dayOfWeek": "平日",
        "tableFormat": 2,
        "nextBusIndex": 1000,
      },
      "campusFRCSaturdays": {
        "table": campusFRCSaturdays,
        "dayOfWeek": "土曜日",
        "tableFormat": 2,
        "nextBusIndex": 1000,
      },
      "frcCampusWeekdays": {
        "table": frcCampusWeekdays,
        "dayOfWeek": "平日",
        "tableFormat": 3,
        "nextBusIndex": 1000,
      },
      "frcCampusSaturdays": {
        "table": frcCampusSaturdays,
        "dayOfWeek": "土曜日",
        "tableFormat": 3,
        "nextBusIndex": 1000,
      },
    },
    "compactTables": [
      for (int i = 0; i <= 3; i++) [for (var value in initCompact) List.from(value)]
    ],
    "tableInfo": {
      0: {"title": "小手指駅 → キャンパス", "string0": "発車時刻", "string1": "残り時間", "string2": "乗車場所", "string3": "車椅子"},
      1: {"title": "キャンパス → 小手指駅", "string0": "発車時刻", "string1": "残り時間", "string2": "降車場所", "string3": "車椅子"},
      2: {"title": "キャンパス → FRC", "string0": "発車時刻", "string1": "残り時間", "string2": "乗車場所", "string3": "接続"},
      3: {"title": "FRC → キャンパス", "string0": "発車時刻", "string1": "残り時間", "string2": "降車場所", "string3": "接続"},
      "tableVer": "2023春季休業期間",
      "selectedTableNames": [],
    }
  };

  var dt = DateTime.now();
  var holidaysOfMonth = NHolidayJp.getByMonth(dt.year, dt.month);
  List dateOfHolidaysOfMonth = [];
  for (int i = 0; i < holidaysOfMonth.length; i++) {
    dateOfHolidaysOfMonth.add(holidaysOfMonth[i].date);
  }

  if (dt.weekday == 7 || dateOfHolidaysOfMonth.contains(1) == true) {
    // 日曜日か祝日
    timetable["tableInfo"]["selectedTableNames"].add("stationCampusSundaysHolidays");
    timetable["tableInfo"]["selectedTableNames"].add("campusStationSundaysHolidays");
    timetable["tableInfo"]["selectedTableNames"].add("");
    timetable["tableInfo"]["selectedTableNames"].add("");
  } else if (dt.weekday >= 1 && dt.weekday <= 5) {
    // 平日
    timetable["tableInfo"]["selectedTableNames"].add("stationCampusWeekdays");
    timetable["tableInfo"]["selectedTableNames"].add("campusStationWeekdays");
    timetable["tableInfo"]["selectedTableNames"].add("campusFRCWeekdays");
    timetable["tableInfo"]["selectedTableNames"].add("frcCampusWeekdays");
  } else {
    // 土曜日
    timetable["tableInfo"]["selectedTableNames"].add("stationCampusSaturdays");
    timetable["tableInfo"]["selectedTableNames"].add("campusStationSaturdays");
    timetable["tableInfo"]["selectedTableNames"].add("campusFRCSaturdays");
    timetable["tableInfo"]["selectedTableNames"].add("frcCampusSaturdays");
  }

  // 3/28の特別ダイヤ
  if (dt.month == 3 && dt.day == 28) {
    timetable["tableInfo"]["selectedTableNames"].add("stationCampusSpecial");
    timetable["tableInfo"]["selectedTableNames"].add("campusStationSpecial");
  }
  return timetable;
}
