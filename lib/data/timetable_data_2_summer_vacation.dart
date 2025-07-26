// timetableの構造メモ
//   timetable['fullTables']['stationCampusWeekdays' -> 'frcCampusSaturday']['table'] == [[int 時, int 分, DateTime 時刻, Duration 残り時間, String 時:分, String 残り時間, String 場所, String 車椅子対応], ...]
//   timetable['fullTables']['stationCampusWeekdays' -> 'frcCampusSaturday']['nextBusIndex'] == int
//   timetable['compactTables'][0 -> 3] == [[String 時:分, String 残り時間, String 場所, String 車椅子対応], * 3]
//   timetable['tableInfo'] == 下のコード参照
//   timetable['startDate'] == DateTime(year, month, day)
//   timetable['url']['waseda_bus_page']: 'https://.../バスページ/'
//   timetable['url']['default_pdf']: 'https://.../通常ダイヤ.pdf'
//   timetable['url']['special_pdf']: {DateTime(year, month, day): 'https://.../特別ダイヤ.pdf', ...}

// 時刻表更新時のチェックリスト
//   tableVer
//   startDate, code.dart
//   default_pdf
//   special_pdf
//   exceptionalHolidays
//   additionalHolidays
//   specialDates
//   exceptionalHolidays, additionalHolidaysは学部暦ではなく大学暦によって決定される
//     https://www.waseda.jp/top/about/work/organizations/academic-affairs-division/academic-calendar
//   noBusDates

Map timetableDataSummerVacation() {
  // 平日(休講日)
  List stationCampusWeekdays = [
    [07, 45, '北口', '×'],
    [08, 05, '北口', '×'],
    [08, 15, '北口', '×'],
    [08, 25, '北口', '○'],
    [08, 30, '北口', '×'],
    [08, 45, '北口', '×'],
    [09, 10, '北口', '×'],
    [09, 25, '北口', '×'],
    [09, 35, '北口', '×'],
    [09, 50, '北口', '×'],
    [10, 05, '北口', '×'],
    [10, 25, '北口', '×'],
    [10, 40, '北口', '○'],
    [10, 55, '北口', '×'],
    [11, 25, '北口', '×'],
    [11, 55, '北口', '○'],
    [12, 15, '北口', '×'],
    [12, 35, '北口', '×'],
    [12, 50, '北口', '×'],
    [13, 05, '北口', '○'],
    [13, 35, '南口', '×'],
    [13, 55, '南口', '×'],
    [14, 25, '南口', '×'],
    [14, 55, '南口', '×'],
    [15, 25, '南口', '×'],
    [15, 55, '南口', '×'],
    [16, 25, '北口', '○'],
    [16, 55, '南口', '×'],
    [17, 25, '南口', '×'],
    [17, 45, '北口', '○'],
    [18, 00, '南口', '×'],
    [18, 35, '南口', '×'],
    [19, 15, '南口', '×'],
    [20, 15, '南口', '×'],
  ];

  List stationCampusSaturdays = [
    [08, 15, '北口', '×'],
    [08, 55, '北口', '×'],
    [09, 45, '北口', '×'],
    [11, 25, '北口', '×'],
    [12, 15, '北口', '×'],
    [14, 45, '南口', '×'],
    [15, 45, '南口', '×'],
    [16, 45, '南口', '×'],
    [17, 25, '南口', '×'],
    [18, 15, '南口', '×'],
    [19, 45, '南口', '×'],
  ];

  List stationCampusSundaysHolidays = [for (var value in stationCampusSaturdays) List.from(value)];

  // 平日(授業日)
  List stationCampusSpecial = [
    [07, 45, '北口', '×'],
    [08, 00, '北口', '×'],
    [08, 06, '北口', '○'],
    [08, 12, '北口', '×'],
    [08, 18, '北口', '×'],
    [08, 21, '北口', '×'],
    [08, 25, '北口', '×'],
    [08, 35, '北口', '×'],
    [08, 50, '北口', '×'],
    [09, 05, '北口', '×'],
    [09, 20, '北口', '○'],
    [09, 35, '北口', '×'],
    [09, 45, '北口', '×'],
    [09, 55, '北口', '×'],
    [10, 00, '北口', '×'],
    [10, 06, '北口', '○'],
    [10, 09, '北口', '×'],
    [10, 12, '北口', '×'],
    [10, 15, '北口', '×'],
    [10, 30, '北口', '×'],
    [10, 55, '北口', '×'],
    [11, 25, '北口', '○'],
    [11, 45, '北口', '×'],
    [12, 05, '北口', '○'],
    [12, 20, '北口', '×'],
    [12, 35, '北口', '×'],
    [13, 05, '北口', '○'],
    [13, 35, '南口', '×'],
    [13, 55, '南口', '×'],
    [14, 20, '南口', '×'],
    [14, 55, '南口', '×'],
    [15, 35, '南口', '×'],
    [15, 50, '南口', '×'],
    [16, 10, '北口', '○'],
    [16, 50, '南口', '×'],
    [17, 25, '南口', '×'],
    [17, 50, '北口', '○'],
    [18, 10, '南口', '×'],
    [18, 30, '南口', '×'],
    [19, 15, '南口', '×'],
    [20, 15, '南口', '×'],
  ];

  // 平日(休講日)
  List campusStationWeekdays = [
    [08, 35, '北口', '×'],
    [09, 35, '北口', '×'],
    [10, 05, '北口', '×'],
    [10, 35, '北口', '×'],
    [11, 05, '北口', '×'],
    [11, 25, '北口', '○'],
    [12, 15, '北口', '×'],
    [12, 30, '北口', '○'],
    [13, 05, '北口', '×'],
    [13, 40, '南口', '×'],
    [14, 10, '南口', '×'],
    [14, 40, '南口', '×'],
    [15, 10, '南口', '×'],
    [15, 40, '南口', '×'],
    [16, 10, '南口', '×'],
    [16, 40, '南口', '×'],
    [17, 15, '北口', '×'],
    [17, 30, '南口', '×'],
    [17, 45, '南口', '×'],
    [18, 00, '南口', '×'],
    [18, 20, '南口', '×'],
    [18, 40, '南口', '×'],
    [19, 00, '南口', '×'],
    [19, 20, '南口', '×'],
    [19, 40, '南口', '×'],
    [20, 00, '南口', '×'],
    [20, 20, '南口', '×'],
    [20, 40, '南口', '×'],
    [21, 10, '南口', '×'],
    [21, 40, '南口', '×'],
  ];

  List campusStationSaturdays = [
    [08, 35, '北口', '×'],
    [09, 25, '北口', '×'],
    [11, 05, '北口', '×'],
    [11, 55, '北口', '×'],
    [14, 30, '南口', '×'],
    [15, 30, '南口', '×'],
    [16, 30, '南口', '×'],
    [17, 10, '南口', '×'],
    [18, 00, '南口', '×'],
    [19, 30, '南口', '×'],
    [21, 00, '南口', '×'],
  ];

  List campusStationSundaysHolidays = [for (var value in campusStationSaturdays) List.from(value)];

  // 平日(授業日)
  List campusStationSpecial = [
    [08, 45, '北口', '×'],
    [09, 35, '北口', '×'],
    [10, 05, '北口', '×'],
    [10, 35, '北口', '×'],
    [11, 05, '北口', '○'],
    [11, 15, '北口', '×'],
    [11, 45, '北口', '×'],
    [12, 05, '北口', '×'],
    [12, 25, '北口', '×'],
    [12, 50, '南口', '×'],
    [13, 05, '南口', '×'],
    [13, 20, '南口', '×'],
    [13, 40, '北口', '○'],
    [14, 05, '南口', '×'],
    [14, 30, '南口', '×'],
    [14, 40, '南口', '×'],
    [14, 50, '南口', '×'],
    [15, 05, '南口', '×'],
    [15, 15, '南口', '×'],
    [15, 20, '南口', '×'],
    [15, 25, '南口', '×'],
    [15, 50, '北口', '○'],
    [16, 10, '南口', '×'],
    [16, 20, '南口', '×'],
    [16, 35, '南口', '×'],
    [16, 55, '北口', '○'],
    [17, 00, '南口', '×'],
    [17, 09, '南口', '×'],
    [17, 15, '南口', '×'],
    [17, 21, '北口', '○'],
    [17, 30, '南口', '×'],
    [17, 45, '南口', '×'],
    [18, 00, '南口', '×'],
    [18, 10, '南口', '×'],
    [18, 20, '南口', '×'],
    [18, 30, '北口', '○'],
    [18, 40, '南口', '×'],
    [18, 50, '南口', '×'],
    [19, 00, '南口', '×'],
    [19, 05, '南口', '×'],
    [19, 10, '南口', '×'],
    [19, 15, '南口', '×'],
    [19, 30, '南口', '×'],
    [20, 00, '南口', '×'],
    [20, 20, '南口', '×'],
    [20, 40, '南口', '×'],
    [21, 10, '南口', '×'],
    [21, 40, '南口', '×'],
    [22, 00, '南口', '×'],
  ];

  List campusFRCWeekdays = [
    // 正門発
    [08, 35, '正門', '×'],
    [08, 45, '正門', '×'],
    [08, 55, '正門', '×'],
    [09, 25, '正門', '×'],
    [09, 45, '正門', '×'],
    [10, 25, '正門', '×'],
    [11, 45, '正門', '×'],
    [12, 15, '正門', '×'],
    [12, 55, '正門', '×'],
    [13, 35, '正門', '×'],
    [14, 20, '正門', '×'],
    [15, 15, '正門', '×'],
    [16, 00, '正門', '×'],
    [16, 25, '正門', '×'],
    [16, 35, '正門', '×'],
    [17, 10, '正門', '×'],
    [17, 45, '正門', '×'],
    [18, 00, '正門', '×'],
    [18, 20, '正門', '×'],
    [19, 40, '正門', '×'],
    [20, 05, '正門', '×'],
    [20, 25, '正門', '×'],
    [21, 20, '正門', '×'],
    // 南門発
    [09, 15, '南門', '×'],
    [10, 15, '南門', '×'],
    [11, 55, '南門', '×'],
    [12, 05, '南門', '×'],
    [12, 45, '南門', '×'],
    [13, 05, '南門', '×'],
    [14, 00, '南門', '×'],
    [15, 40, '南門', '×'],
    [17, 00, '南門', '×'],
    [18, 10, '南門', '×'],
    [19, 50, '南門', '×'],
  ];

  List campusFRCSaturdays = [
    // 正門発
    [08, 40, '正門', '×'],
    [09, 15, '正門', '×'],
    [09, 55, '正門', '×'],
    [11, 35, '正門', '×'],
    [11, 50, '正門', '×'],
    [12, 25, '正門', '×'],
    [13, 05, '正門', '×'],
    [15, 05, '正門', '×'],
    [16, 05, '正門', '×'],
    [17, 10, '正門', '×'],
    [19, 05, '正門', '×'],
    [20, 05, '正門', '×'],
    // 南門発
    [09, 00, '南門', '×'],
    [09, 40, '南門', '×'],
    [10, 50, '南門', '×'],
    [12, 15, '南門', '×'],
    [12, 55, '南門', '×'],
    [14, 20, '南門', '×'],
    [15, 20, '南門', '×'],
    [16, 20, '南門', '×'],
    [17, 00, '南門', '×'],
    [17, 50, '南門', '×'],
    [19, 20, '南門', '×'],
    [20, 40, '南門', '×'],
  ];

  List frcCampusWeekdays = [
    // 正門着
    [08, 40, '正門', '×'],
    [08, 50, '正門', '×'],
    [09, 20, '正門', '×'],
    [09, 30, '正門', '×'],
    [10, 20, '正門', '×'],
    [10, 30, '正門', '×'],
    [12, 10, '正門', '×'],
    [12, 50, '正門', '×'],
    [13, 30, '正門', '×'],
    [14, 05, '正門', '×'],
    [14, 30, '正門', '×'],
    [15, 45, '正門', '×'],
    [16, 05, '正門', '×'],
    [16, 30, '正門', '×'],
    [17, 05, '正門', '×'],
    [17, 25, '正門', '×'],
    [17, 50, '正門', '×'],
    [18, 15, '正門', '×'],
    [18, 30, '正門', '×'],
    [19, 55, '正門', '×'],
    [20, 10, '正門', '×'],
    [20, 30, '正門', '×'],
    [21, 25, '正門', '×'],
    // 南門着
    [09, 00, '南門', '×'],
    [09, 50, '南門', '×'],
    [11, 50, '南門', '×'],
    [12, 00, '南門', '×'],
    [12, 20, '南門', '×'],
    [13, 00, '南門', '×'],
    [13, 40, '南門', '×'],
    [15, 20, '南門', '×'],
    [16, 40, '南門', '×'],
    [18, 05, '南門', '×'],
    [19, 45, '南門', '×'],
  ];

  List frcCampusSaturdays = [
    // 正門着
    [09, 05, '正門', '×'],
    [09, 45, '正門', '×'],
    [10, 55, '正門', '×'],
    [11, 40, '正門', '×'],
    [12, 20, '正門', '×'],
    [13, 00, '正門', '×'],
    [14, 25, '正門', '×'],
    [15, 25, '正門', '×'],
    [16, 25, '正門', '×'],
    [17, 05, '正門', '×'],
    [17, 55, '正門', '×'],
    [19, 25, '正門', '×'],
    [20, 45, '正門', '×'],
    // 南門着
    [08, 45, '南門', '×'],
    [09, 20, '南門', '×'],
    [10, 00, '南門', '×'],
    [11, 55, '南門', '×'],
    [12, 30, '南門', '×'],
    [13, 10, '南門', '×'],
    [15, 10, '南門', '×'],
    [16, 10, '南門', '×'],
    [17, 40, '南門', '×'],
    [19, 10, '南門', '×'],
    [20, 10, '南門', '×'],
  ];

  List initCompact = [
    ['-', '-', '-', '-'],
    ['-', '-', '-', '-'],
    ['-', '-', '-', '-'],
  ];

  List sortTimetable(List table) {
    table.sort(
      (a, b) {
        int result = a[0].compareTo(b[0]);
        if (result != 0) return result;
        return a[1].compareTo(b[1]);
      },
    );
    return table;
  }

  campusFRCWeekdays = sortTimetable(campusFRCWeekdays);
  campusFRCSaturdays = sortTimetable(campusFRCSaturdays);
  frcCampusWeekdays = sortTimetable(frcCampusWeekdays);
  frcCampusSaturdays = sortTimetable(frcCampusSaturdays);

  Map timetable = {
    'fullTables': {
      'stationCampusWeekdays': {
        'table': stationCampusWeekdays,
        'dayOfWeek': '平日(休講日)',
        'tableFormat': 0,
        'nextBusIndex': 1000,
      },
      'stationCampusSaturdays': {
        'table': stationCampusSaturdays,
        'dayOfWeek': '土曜日',
        'tableFormat': 0,
        'nextBusIndex': 1000,
      },
      'stationCampusSundaysHolidays': {
        'table': stationCampusSundaysHolidays,
        'dayOfWeek': '日曜日/祝日',
        'tableFormat': 0,
        'nextBusIndex': 1000,
      },
      'stationCampusSpecial': {
        'table': stationCampusSpecial,
        'dayOfWeek': '平日(授業日)',
        'tableFormat': 0,
        'nextBusIndex': 1000,
      },
      'campusStationWeekdays': {
        'table': campusStationWeekdays,
        'dayOfWeek': '平日(休講日)',
        'tableFormat': 1,
        'nextBusIndex': 1000,
      },
      'campusStationSaturdays': {
        'table': campusStationSaturdays,
        'dayOfWeek': '土曜日',
        'tableFormat': 1,
        'nextBusIndex': 1000,
      },
      'campusStationSundaysHolidays': {
        'table': campusStationSundaysHolidays,
        'dayOfWeek': '日曜日/祝日',
        'tableFormat': 1,
        'nextBusIndex': 1000,
      },
      'campusStationSpecial': {
        'table': campusStationSpecial,
        'dayOfWeek': '平日(授業日)',
        'tableFormat': 1,
        'nextBusIndex': 1000,
      },
      'campusFRCWeekdays': {
        'table': campusFRCWeekdays,
        'dayOfWeek': '平日(休講日)',
        'tableFormat': 2,
        'nextBusIndex': 1000,
      },
      'campusFRCSaturdays': {
        'table': campusFRCSaturdays,
        'dayOfWeek': '土曜日',
        'tableFormat': 2,
        'nextBusIndex': 1000,
      },
      'frcCampusWeekdays': {
        'table': frcCampusWeekdays,
        'dayOfWeek': '平日(休講日)',
        'tableFormat': 3,
        'nextBusIndex': 1000,
      },
      'frcCampusSaturdays': {
        'table': frcCampusSaturdays,
        'dayOfWeek': '土曜日',
        'tableFormat': 3,
        'nextBusIndex': 1000,
      },
      '': {
        'table': [],
        'dayOfWeek': '運休',
        'tableFormat': 0,
        'nextBusIndex': 1000,
      },
    },
    'compactTables': [
      for (int i = 0; i <= 3; i++) [for (var value in initCompact) List.from(value)]
    ],
    'tableInfo': {
      0: {'title': '小手指駅 → キャンパス', 'string0': '発車時刻', 'string1': '残り時間', 'string2': '乗車場所', 'string3': '車椅子'},
      1: {'title': 'キャンパス → 小手指駅', 'string0': '発車時刻', 'string1': '残り時間', 'string2': '降車場所', 'string3': '車椅子'},
      2: {'title': 'キャンパス → FRC', 'string0': '発車時刻', 'string1': '残り時間', 'string2': '乗車場所', 'string3': '接続'},
      3: {'title': 'FRC → キャンパス', 'string0': '発車時刻', 'string1': '残り時間', 'string2': '降車場所', 'string3': '接続'},
      'tableVer': '2025年度夏季休業期間',
      'dayOfWeek': '',
      'selectedTableNames': [],
    },
    'startDate': DateTime(2025, 07, 30),
    'exceptions': {
      // 授業を行う祝日(時刻表PDFに大学暦に載っていない日があった場合)
      'exceptionalHolidays': [],

      // 追加で祝日扱いする日(時刻表PDFに大学暦に載っていない日があった場合)
      'additionalHolidays': [
        DateTime(2025, 08, 11),
        DateTime(2025, 08, 12),
        DateTime(2025, 08, 13),
        DateTime(2025, 08, 14),
        DateTime(2025, 08, 15),
        DateTime(2025, 08, 16),
        DateTime(2025, 09, 15),
        DateTime(2025, 09, 23),
      ],

      // 授業日ダイヤに切り替える日(特別ダイヤ)
      'specialDateName': '平日(授業日)',
      'specialDates': [
        DateTime(2025, 08, 18),
        DateTime(2025, 08, 19),
        DateTime(2025, 08, 20),
        DateTime(2025, 08, 21),
        DateTime(2025, 08, 22),
        DateTime(2025, 08, 25),
        DateTime(2025, 08, 26),
        DateTime(2025, 08, 27),
        DateTime(2025, 08, 28),
        DateTime(2025, 08, 29),
        DateTime(2025, 09, 01),
        DateTime(2025, 09, 02),
        DateTime(2025, 09, 03),
        DateTime(2025, 09, 04),
        DateTime(2025, 09, 05),
      ],

      // バス運休日(年末年始など)
      'noBusDates': [],
    },
    'url': {
      'waseda_bus_page': 'https://www.waseda.jp/fhum/hum/facility/bus-parking/',
      'default_pdf': 'https://www.waseda.jp/fhum/hum/assets/uploads/2025/07/School_Bus_Schedule_for_Summer_Vacation_from_30th_July_2025_to_1st_October_2025.pdf',
      'special_pdf': {
        DateTime(2024, 08, 02): 'https://www.waseda.jp/fhum/hum/assets/uploads/2025/07/School_Bus_Schedule_for_Summer_Vacation_from_30th_July_2025_to_1st_October_2025.pdf',
        DateTime(2024, 08, 03): 'https://www.waseda.jp/fhum/hum/assets/uploads/2025/07/School_Bus_Schedule_for_Summer_Vacation_from_30th_July_2025_to_1st_October_2025.pdf',
        DateTime(2024, 08, 23): 'https://www.waseda.jp/fhum/hum/assets/uploads/2025/07/School_Bus_Schedule_for_Summer_Vacation_from_30th_July_2025_to_1st_October_2025.pdf',
        DateTime(2024, 09, 06): 'https://www.waseda.jp/fhum/hum/assets/uploads/2025/07/School_Bus_Schedule_for_Summer_Vacation_from_30th_July_2025_to_1st_October_2025.pdf',
        DateTime(2024, 09, 08): 'https://www.waseda.jp/fhum/hum/assets/uploads/2025/07/School_Bus_Schedule_for_Summer_Vacation_from_30th_July_2025_to_1st_October_2025.pdf',
        DateTime(2024, 09, 09): 'https://www.waseda.jp/fhum/hum/assets/uploads/2025/07/School_Bus_Schedule_for_Summer_Vacation_from_30th_July_2025_to_1st_October_2025.pdf',
        DateTime(2024, 09, 10): 'https://www.waseda.jp/fhum/hum/assets/uploads/2025/07/School_Bus_Schedule_for_Summer_Vacation_from_30th_July_2025_to_1st_October_2025.pdf',
        DateTime(2024, 09, 13): 'https://www.waseda.jp/fhum/hum/assets/uploads/2025/07/School_Bus_Schedule_for_Summer_Vacation_from_30th_July_2025_to_1st_October_2025.pdf',
        DateTime(2024, 09, 27): 'https://www.waseda.jp/fhum/hum/assets/uploads/2025/07/School_Bus_Schedule_for_Summer_Vacation_from_30th_July_2025_to_1st_October_2025.pdf',
      },
    },
  };
  return timetable;
}
