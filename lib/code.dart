import 'package:intl/intl.dart';
import 'timetables.dart';

List code() {
  List timetable = timetables();

  //現在時刻と0時0分の取得
  var now = DateTime.now();
  var lastMidnight = DateTime(now.year, now.month, now.day);

  String calcTimeRemaining(Duration time) {
    if (time.inHours == 0) {
      if (time.inMinutes == 0) {
        if (time.isNegative == false) {
          return "${time.inSeconds % 60}秒";
        } else {
          return "-${60 - time.inSeconds % 60 - 1}秒";
        }
      } else {
        if (time.isNegative == false) {
          return "${time.inMinutes % 60}分${time.inSeconds % 60}秒";
        } else {
          return "-${60 - time.inMinutes % 60 - 1}分${60 - time.inSeconds % 60 - 1}秒";
        }
      }
    } else {
      if (time.isNegative == false) {
        return "${time.inHours}時間${time.inMinutes % 60}分${time.inSeconds % 60}秒";
      } else {
        return "${time.inHours}時間${60 - time.inMinutes % 60 - 1}分${60 - time.inSeconds % 60 - 1}秒";
      }
    }
  }

  for (int tableIndex = 0; tableIndex <= 3; tableIndex++) {
    //時刻と残り時間をdatetime型でリストに追加
    for (int i = 0; i < timetable[tableIndex].length; i++) {
      var dtBus = lastMidnight.add(Duration(hours: timetable[tableIndex][i][0], minutes: timetable[tableIndex][i][1]));
      final Duration duration = dtBus.difference(now);
      timetable[tableIndex][i].insert(2, dtBus);
      timetable[tableIndex][i].insert(3, duration);
      timetable[tableIndex][i].insert(4, DateFormat('HH:mm').format(timetable[tableIndex][i][2]));
      timetable[tableIndex][i].insert(5, calcTimeRemaining(timetable[tableIndex][i][3]));
    }

    const Duration zero = Duration(seconds: 0);
    for (int i = 0; i < timetable[tableIndex].length; i++) {
      //timetableの長さ分ループ
      if (timetable[tableIndex][i][3] > zero) {
        timetable[8][tableIndex]["nextBusIndex"] = i;
        if (i == 0) {
          //始発より前の時間の場合
          //時刻表示
          timetable[tableIndex + 4][0][0] = "-";
          timetable[tableIndex + 4][1][0] = timetable[tableIndex][i][4];
          timetable[tableIndex + 4][2][0] = timetable[tableIndex][i + 1][4];

          //残り時間表示
          timetable[tableIndex + 4][0][1] = "-";
          timetable[tableIndex + 4][1][1] = timetable[tableIndex][i][5];
          timetable[tableIndex + 4][2][1] = timetable[tableIndex][i + 1][5];

          //発車場所/降車場所
          timetable[tableIndex + 4][0][2] = "-";
          timetable[tableIndex + 4][1][2] = timetable[tableIndex][i][6];
          timetable[tableIndex + 4][2][2] = timetable[tableIndex][i + 1][6];

          //車椅子対応or接続
          timetable[tableIndex + 4][0][3] = "-";
          timetable[tableIndex + 4][1][3] = timetable[tableIndex][i][7];
          timetable[tableIndex + 4][2][3] = timetable[tableIndex][i + 1][7];

          //print(timetable[tableIndex+4]);
          break;
        } else if (timetable[tableIndex][i][3] > zero && i < timetable[tableIndex].length - 1) {
          //通常時
          for (int j = 0; j < 3; j++) {
            timetable[tableIndex + 4][j][0] = timetable[tableIndex][i - 1 + j][4];
            timetable[tableIndex + 4][j][1] = timetable[tableIndex][i - 1 + j][5];
            timetable[tableIndex + 4][j][2] = timetable[tableIndex][i - 1 + j][6];
            timetable[tableIndex + 4][j][3] = timetable[tableIndex][i - 1 + j][7];
          }
          break;
        } else if (i == timetable[tableIndex].length - 1) {
          // 次が最終便の場合
          //時刻表示
          timetable[tableIndex + 4][0][0] = timetable[tableIndex][i - 1][4];
          timetable[tableIndex + 4][1][0] = timetable[tableIndex][i][4];
          timetable[tableIndex + 4][2][0] = "-";

          //残り時間表示
          timetable[tableIndex + 4][0][1] = timetable[tableIndex][i - 1][5];
          timetable[tableIndex + 4][1][1] = timetable[tableIndex][i][5];
          timetable[tableIndex + 4][2][1] = "-";

          //発車場所/降車場所
          timetable[tableIndex + 4][0][2] = timetable[tableIndex][i - 1][6];
          timetable[tableIndex + 4][1][2] = timetable[tableIndex][i][6];
          timetable[tableIndex + 4][2][2] = "-";

          //車椅子対応or接続
          timetable[tableIndex + 4][0][3] = timetable[tableIndex][i - 1][7];
          timetable[tableIndex + 4][1][3] = timetable[tableIndex][i][7];
          timetable[tableIndex + 4][2][3] = "-";
          break;
        }
      } else {
        //最終便の後の場合
        //時刻表示
        timetable[tableIndex + 4][0][0] = timetable[tableIndex].last[4];
        timetable[tableIndex + 4][1][0] = "-";
        timetable[tableIndex + 4][2][0] = "-";

        //残り時間表示
        timetable[tableIndex + 4][0][1] = timetable[tableIndex].last[5];
        timetable[tableIndex + 4][1][1] = "-";
        timetable[tableIndex + 4][2][1] = "-";

        //発車場所/降車場所
        timetable[tableIndex + 4][0][2] = timetable[tableIndex].last[6];
        timetable[tableIndex + 4][1][2] = "-";
        timetable[tableIndex + 4][2][2] = "-";

        //車椅子対応or接続
        timetable[tableIndex + 4][0][3] = timetable[tableIndex].last[7];
        timetable[tableIndex + 4][1][3] = "-";
        timetable[tableIndex + 4][2][3] = "-";
      }
    }
  }
  return timetable;
}
