import 'package:intl/intl.dart';
import 'timetables.dart';

List code() {
  List timetable = timetables();
  // timetableの構造メモ
  // timetable[0->3] == [[int 時, int 分, DateTime 時刻, Duration 残り時間, String 時:分, String 残り時間, String 場所, String 車椅子対応], ...]
  // timetable[4->7] == [[String 時:分, String 残り時間, String 場所, String 車椅子対応], * 3]



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

  for (int tableNum = 0; tableNum <= 3; tableNum++) {
    //時刻と残り時間をdatetime型でリストに追加
    for (int i = 0; i < timetable[tableNum].length; i++) {
      var dtBus = lastMidnight.add(Duration(hours: timetable[tableNum][i][0], minutes: timetable[tableNum][i][1]));
      final Duration duration = dtBus.difference(now);
      timetable[tableNum][i].insert(2, dtBus);
      timetable[tableNum][i].insert(3, duration);
      timetable[tableNum][i].insert(4, DateFormat('HH:mm').format(timetable[tableNum][i][2]));
      timetable[tableNum][i].insert(5, calcTimeRemaining(timetable[tableNum][i][3]));
    }

    List timetableCompact = [
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
    const Duration zero = Duration(seconds: 0);
    for (int i = 0; i < timetable[tableNum].length; i++) {
      //timetableの長さ分ループ
      if (timetable[tableNum][i][3] > zero) {
        timetable[4][tableNum]["nextBusIndex"] = i;
        if (i == 0) {
          //　始発より前の時間の場合
          //時刻表示
          timetableCompact[0][0] = "-";
          timetableCompact[1][0] = DateFormat('HH:mm').format(timetable[tableNum][i][2]);
          timetableCompact[2][0] = DateFormat('HH:mm').format(timetable[tableNum][i + 1][2]);

          //残り時間表示
          timetableCompact[0][1] = "-";
          timetableCompact[1][1] = calcTimeRemaining(timetable[tableNum][i][3]);
          timetableCompact[2][1] = calcTimeRemaining(timetable[tableNum][i + 1][3]);

          //発車場所/降車場所
          timetableCompact[0][2] = "-";
          timetableCompact[1][2] = timetable[tableNum][i][6];
          timetableCompact[2][2] = timetable[tableNum][i + 1][6];

          //車椅子対応or接続
          timetableCompact[0][3] = "-";
          timetableCompact[1][3] = timetable[tableNum][i][7];
          timetableCompact[2][3] = timetable[tableNum][i + 1][7];
          break;
        } else if (timetable[tableNum][i][3] > zero && i < timetable[tableNum].length - 1) {
          //通常時
          for (int j = 0; j < 3; j++) {
            timetableCompact[j][0] = DateFormat('HH:mm').format(timetable[tableNum][i - 1 + j][2]);
            timetableCompact[j][1] = calcTimeRemaining(timetable[tableNum][i - 1 + j][3]);
            timetableCompact[j][2] = timetable[tableNum][i - 1 + j][6];
            timetableCompact[j][3] = timetable[tableNum][i - 1 + j][7];
          }
          break;
        } else if (i == timetable[tableNum].length - 1) {
          // 次が最終便の場合
          //時刻表示
          timetableCompact[0][0] = DateFormat('HH:mm').format(timetable[tableNum][i - 1][2]);
          timetableCompact[1][0] = DateFormat('HH:mm').format(timetable[tableNum][i][2]);
          timetableCompact[2][0] = "-";

          //残り時間表示
          timetableCompact[0][1] = calcTimeRemaining(timetable[tableNum][i - 1][3]);
          timetableCompact[1][1] = calcTimeRemaining(timetable[tableNum][i][3]);
          timetableCompact[2][1] = "-";

          //発車場所/降車場所
          timetableCompact[0][2] = timetable[tableNum][i - 1][6];
          timetableCompact[1][2] = timetable[tableNum][i][6];
          timetableCompact[2][2] = "-";

          //車椅子対応or接続
          timetableCompact[0][3] = timetable[tableNum][i - 1][7];
          timetableCompact[1][3] = timetable[tableNum][i][7];
          timetableCompact[2][3] = "-";
          break;
        }
      } else {
        //最終便の後の場合
        //時刻表示
        timetableCompact[0][0] = DateFormat('HH:mm').format(timetable[tableNum].last[2]);
        timetableCompact[1][0] = "-";
        timetableCompact[2][0] = "-";

        //残り時間表示
        timetableCompact[0][1] = calcTimeRemaining(timetable[tableNum].last[3]);
        timetableCompact[1][1] = "-";
        timetableCompact[2][1] = "-";

        //発車場所/降車場所
        timetableCompact[0][2] = timetable[tableNum].last[6];
        timetableCompact[1][2] = "-";
        timetableCompact[2][2] = "-";

        //車椅子対応or接続
        timetableCompact[0][3] = timetable[tableNum].last[7];
        timetableCompact[1][3] = "-";
        timetableCompact[2][3] = "-";
      }
    }
    timetable.insert(tableNum + 4, timetableCompact);
  }

  //print(tableInfo);
  //timetable.insert(8, tableInfo);

  //print(timetable[4][0]);
  //print(timetable[0][0]);
  //print(timetable[8][0]["nextBusIndex"].runtimeType);
  return timetable;
}
