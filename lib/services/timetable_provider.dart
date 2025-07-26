import 'package:nholiday_jp/nholiday_jp.dart';
import '../data/timetable_data_1_semester.dart';
import '../data/timetable_data_2_summer_vacation.dart';
import '../data/timetable_data_3_winter_vacation.dart';
import '../data/timetable_data_4_spring_vacation.dart';
import '../data/holiday_config.dart';

Map timetableProvider() {
  DateTime now = DateTime.now();

  // 時刻表をリストとして定義
  List<Map> timetables = [
    timetableDataSemester(),
    timetableDataSummerVacation(),
    timetableDataWinterVacation(),
    timetableDataSpringVacation(),
  ];

  // 'startDate'でソート（降順：最新の'startDate'が先頭になる）
  timetables.sort((a, b) => b['startDate'].compareTo(a['startDate']));

  Map timetable = {};
  // 現在の時刻に合う時刻表を選択
  for (final tt in timetables) {
    if (now.isAfter(tt['startDate'])) {
      timetable = tt;
      break;
    }
  }

  List<DateTime> holidays = NHolidayJp.getByYear(now.year).map((holiday) => DateTime(now.year, holiday.month, holiday.date)).toList();

  if (now.weekday == DateTime.sunday || holidays.contains(DateTime(now.year, now.month, now.day))) {
    // 日曜日か祝日
    timetable['tableInfo']['selectedTableNames'].add('stationCampusSundaysHolidays');
    timetable['tableInfo']['selectedTableNames'].add('campusStationSundaysHolidays');
    timetable['tableInfo']['selectedTableNames'].add('');
    timetable['tableInfo']['selectedTableNames'].add('');
    timetable['tableInfo']['dayOfWeek'] = '${timetable['fullTables']['stationCampusSundaysHolidays']['dayOfWeek']}ダイヤ';
  } else if (now.weekday >= DateTime.monday && now.weekday <= DateTime.friday) {
    // 平日
    timetable['tableInfo']['selectedTableNames'].add('stationCampusWeekdays');
    timetable['tableInfo']['selectedTableNames'].add('campusStationWeekdays');
    timetable['tableInfo']['selectedTableNames'].add('campusFRCWeekdays');
    timetable['tableInfo']['selectedTableNames'].add('frcCampusWeekdays');
    timetable['tableInfo']['dayOfWeek'] = '${timetable['fullTables']['stationCampusWeekdays']['dayOfWeek']}ダイヤ';
  } else if (now.weekday == DateTime.saturday) {
    // 土曜日
    timetable['tableInfo']['selectedTableNames'].add('stationCampusSaturdays');
    timetable['tableInfo']['selectedTableNames'].add('campusStationSaturdays');
    timetable['tableInfo']['selectedTableNames'].add('campusFRCSaturdays');
    timetable['tableInfo']['selectedTableNames'].add('frcCampusSaturdays');
    timetable['tableInfo']['dayOfWeek'] = '${timetable['fullTables']['stationCampusSaturdays']['dayOfWeek']}ダイヤ';
  }

  if (exceptionalHolidays.contains(DateTime(now.year, now.month, now.day)) || timetable['exceptions']['exceptionalHolidays'].contains(DateTime(now.year, now.month, now.day))) {
    if (now.weekday >= DateTime.monday && now.weekday <= DateTime.friday) {
      // 授業を行う祝日(平日)
      timetable['tableInfo']['selectedTableNames'][0] = 'stationCampusWeekdays';
      timetable['tableInfo']['selectedTableNames'][1] = 'campusStationWeekdays';
      timetable['tableInfo']['selectedTableNames'][2] = 'campusFRCWeekdays';
      timetable['tableInfo']['selectedTableNames'][3] = 'frcCampusWeekdays';
      timetable['tableInfo']['dayOfWeek'] = '${timetable['fullTables']['stationCampusWeekdays']['dayOfWeek']}ダイヤ';
    } else if (now.weekday == DateTime.saturday) {
      // 授業を行う祝日(土曜日)
      timetable['tableInfo']['selectedTableNames'][0] = 'stationCampusSaturdays';
      timetable['tableInfo']['selectedTableNames'][1] = 'campusStationSaturdays';
      timetable['tableInfo']['selectedTableNames'][2] = 'campusFRCSaturdays';
      timetable['tableInfo']['selectedTableNames'][3] = 'frcCampusSaturdays';
      timetable['tableInfo']['dayOfWeek'] = '${timetable['fullTables']['stationCampusSaturdays']['dayOfWeek']}ダイヤ';
    }
  }
  if (additionalHolidays.contains(DateTime(now.year, now.month, now.day)) || timetable['exceptions']['additionalHolidays'].contains(DateTime(now.year, now.month, now.day))) {
    // 臨時の休業日、追加で祝日扱いする日
    timetable['tableInfo']['selectedTableNames'][0] = 'stationCampusSundaysHolidays';
    timetable['tableInfo']['selectedTableNames'][1] = 'campusStationSundaysHolidays';
    timetable['tableInfo']['selectedTableNames'][2] = '';
    timetable['tableInfo']['selectedTableNames'][3] = '';
    timetable['tableInfo']['dayOfWeek'] = '${timetable['fullTables']['stationCampusSundaysHolidays']['dayOfWeek']}ダイヤ';
  }
  if (timetable['exceptions']['specialDates'].contains(DateTime(now.year, now.month, now.day))) {
    // 特別ダイヤに切り替える日
    timetable['tableInfo']['selectedTableNames'][0] = 'stationCampusSpecial';
    timetable['tableInfo']['selectedTableNames'][1] = 'campusStationSpecial';
    timetable['tableInfo']['dayOfWeek'] = '${timetable['fullTables']['stationCampusSpecial']['dayOfWeek']}ダイヤ';
  }
  if (timetable['exceptions']['noBusDates'].contains(DateTime(now.year, now.month, now.day))) {
    // バス運休日(年末年始など)
    timetable['tableInfo']['selectedTableNames'][0] = '';
    timetable['tableInfo']['selectedTableNames'][1] = '';
    timetable['tableInfo']['selectedTableNames'][2] = '';
    timetable['tableInfo']['selectedTableNames'][3] = '';
    timetable['tableInfo']['dayOfWeek'] = '${timetable['fullTables']['']['dayOfWeek']}';
  }
  return timetable;
}
