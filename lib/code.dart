import 'package:intl/intl.dart';
import 'timetables.dart';

Map code() {
  Map timetable = timetables();

  //現在時刻と0時0分の取得
  var now = DateTime.now();
  var lastMidnight = DateTime(now.year, now.month, now.day);

  String calcTimeRemaining(Duration time) {
    if (time.isNegative == false) {
      int secondsFull = time.inSeconds;
      int seconds = secondsFull % 60;
      int minutes = secondsFull ~/ 60 % 60;
      int hours = secondsFull / 60 ~/ 60;
      if (hours == 0) {
        if (minutes == 0) {
          return "$seconds秒";
        } else {
          return "$minutes分$seconds秒";
        }
      } else {
        return "$hours時間$minutes分$seconds秒";
      }
    } else {
      int secondsFull = time.inSeconds - 1;
      int seconds = secondsFull % 60;
      int minutes = secondsFull ~/ 60 % 60;
      int hours = secondsFull / 60 ~/ 60;
      if (hours == 0) {
        if (minutes == 0) {
          return "-${(60 - seconds) % 60}秒";
        } else {
          return "-${(60 - minutes) % 60}分${(60 - seconds) % 60}秒";
        }
      } else {
        return "$hours時間${(60 - minutes) % 60}分${(60 - seconds) % 60}秒";
      }
    }
  }

  for (var key in timetable["fullTables"].keys) {
    //時刻と残り時間をdatetime型でリストに追加
    for (int i = 0; i < timetable["fullTables"][key]["table"].length; i++) {
      var dtBus = lastMidnight.add(Duration(hours: timetable["fullTables"][key]["table"][i][0], minutes: timetable["fullTables"][key]["table"][i][1]));
      final Duration duration = dtBus.difference(now);
      timetable["fullTables"][key]["table"][i].insert(2, dtBus);
      timetable["fullTables"][key]["table"][i].insert(3, duration);
      timetable["fullTables"][key]["table"][i].insert(4, DateFormat('HH:mm').format(timetable["fullTables"][key]["table"][i][2]));
      timetable["fullTables"][key]["table"][i].insert(5, calcTimeRemaining(timetable["fullTables"][key]["table"][i][3]));
    }
  }

  int tableIndex = 0;
  // for (int tableIndex = 0; tableIndex <= 3; tableIndex++) {
  for (var tableName in timetable["tableInfo"]["selectedTables"]["tableNames"]) {
    //日曜・祝日の場合何もせずreturn
    // String tableName = timetable["tableInfo"]["selectedTables"]["tableNames"][tableIndex];
    if (tableName == "") {
      return timetable;
      // break;
    }

    const Duration zero = Duration(seconds: 0);
    for (int i = 0; i < timetable["fullTables"][tableName]["table"].length; i++) {
      //timetableの長さ分ループ
      if (timetable["fullTables"][tableName]["table"][i][3] > zero) {
        timetable["fullTables"][tableName]["nextBusIndex"] = i;
        if (i == 0) {
          //始発より前の時間の場合
          //時刻表示
          timetable["compactTables"][tableIndex][0][0] = "-";
          timetable["compactTables"][tableIndex][1][0] = timetable["fullTables"][tableName]["table"][i][4];
          timetable["compactTables"][tableIndex][2][0] = timetable["fullTables"][tableName]["table"][i + 1][4];

          //残り時間表示
          timetable["compactTables"][tableIndex][0][1] = "-";
          timetable["compactTables"][tableIndex][1][1] = timetable["fullTables"][tableName]["table"][i][5];
          timetable["compactTables"][tableIndex][2][1] = timetable["fullTables"][tableName]["table"][i + 1][5];

          //発車場所/降車場所
          timetable["compactTables"][tableIndex][0][2] = "-";
          timetable["compactTables"][tableIndex][1][2] = timetable["fullTables"][tableName]["table"][i][6];
          timetable["compactTables"][tableIndex][2][2] = timetable["fullTables"][tableName]["table"][i + 1][6];

          //車椅子対応or接続
          timetable["compactTables"][tableIndex][0][3] = "-";
          timetable["compactTables"][tableIndex][1][3] = timetable["fullTables"][tableName]["table"][i][7];
          timetable["compactTables"][tableIndex][2][3] = timetable["fullTables"][tableName]["table"][i + 1][7];

          break;
        } else if (timetable["fullTables"][tableName]["table"][i][3] > zero && i < timetable["fullTables"][tableName]["table"].length - 1) {
          //通常時
          for (int j = 0; j < 3; j++) {
            timetable["compactTables"][tableIndex][j][0] = timetable["fullTables"][tableName]["table"][i - 1 + j][4];
            timetable["compactTables"][tableIndex][j][1] = timetable["fullTables"][tableName]["table"][i - 1 + j][5];
            timetable["compactTables"][tableIndex][j][2] = timetable["fullTables"][tableName]["table"][i - 1 + j][6];
            timetable["compactTables"][tableIndex][j][3] = timetable["fullTables"][tableName]["table"][i - 1 + j][7];
          }
          break;
        } else if (i == timetable["fullTables"][tableName]["table"].length - 1) {
          // 次が最終便の場合
          //時刻表示
          timetable["compactTables"][tableIndex][0][0] = timetable["fullTables"][tableName]["table"][i - 1][4];
          timetable["compactTables"][tableIndex][1][0] = timetable["fullTables"][tableName]["table"][i][4];
          timetable["compactTables"][tableIndex][2][0] = "-";

          //残り時間表示
          timetable["compactTables"][tableIndex][0][1] = timetable["fullTables"][tableName]["table"][i - 1][5];
          timetable["compactTables"][tableIndex][1][1] = timetable["fullTables"][tableName]["table"][i][5];
          timetable["compactTables"][tableIndex][2][1] = "-";

          //発車場所/降車場所
          timetable["compactTables"][tableIndex][0][2] = timetable["fullTables"][tableName]["table"][i - 1][6];
          timetable["compactTables"][tableIndex][1][2] = timetable["fullTables"][tableName]["table"][i][6];
          timetable["compactTables"][tableIndex][2][2] = "-";

          //車椅子対応or接続
          timetable["compactTables"][tableIndex][0][3] = timetable["fullTables"][tableName]["table"][i - 1][7];
          timetable["compactTables"][tableIndex][1][3] = timetable["fullTables"][tableName]["table"][i][7];
          timetable["compactTables"][tableIndex][2][3] = "-";
          break;
        }
      } else {
        //最終便の後の場合
        //時刻表示
        timetable["compactTables"][tableIndex][0][0] = timetable["fullTables"][tableName]["table"].last[4];
        timetable["compactTables"][tableIndex][1][0] = "-";
        timetable["compactTables"][tableIndex][2][0] = "-";

        //残り時間表示
        timetable["compactTables"][tableIndex][0][1] = timetable["fullTables"][tableName]["table"].last[5];
        timetable["compactTables"][tableIndex][1][1] = "-";
        timetable["compactTables"][tableIndex][2][1] = "-";

        //発車場所/降車場所
        timetable["compactTables"][tableIndex][0][2] = timetable["fullTables"][tableName]["table"].last[6];
        timetable["compactTables"][tableIndex][1][2] = "-";
        timetable["compactTables"][tableIndex][2][2] = "-";

        //車椅子対応or接続
        timetable["compactTables"][tableIndex][0][3] = timetable["fullTables"][tableName]["table"].last[7];
        timetable["compactTables"][tableIndex][1][3] = "-";
        timetable["compactTables"][tableIndex][2][3] = "-";
      }
    }
    tableIndex++;
  }
  return timetable;
}
