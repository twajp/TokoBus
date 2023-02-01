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
          return "${time.inSeconds%60}秒";
        }else {
          return "-${60-time.inSeconds%60}秒";
        }
      } else {
        if (time.isNegative == false){
          return "${time.inMinutes%60}分${time.inSeconds%60}秒";

        }else {
          return "-${60-time.inMinutes%60}分${60-time.inSeconds%60}秒";
        }
      }
    } else {
      if (time.isNegative == false){
        return "${time.inHours}時間${time.inMinutes%60}分${time.inSeconds%60}秒";

      }else{
        return "-${time.inHours}時間${60-time.inMinutes%60}分${60-time.inSeconds%60}秒";
      }
    }
  }

  for (int tableNum = 0; tableNum<3; tableNum++){
    //時刻と残り時間をdatetime型でリストに追加
    for (int i = 0; i < timetable[tableNum].length; i++) {
      var dtBus = lastMidnight.add(Duration(hours: timetable[tableNum][i][0], minutes: timetable[tableNum][i][1]));
      final Duration duration = dtBus.difference(now);
      timetable[tableNum][i].insert(2, dtBus);
      timetable[tableNum][i].insert(3, duration);
    }

    List timetableCompact = [[], [], []];
    const Duration zero = Duration(seconds: 0);
    for (int i = 0; i < timetable[tableNum].length; i++) {
      if (timetable[tableNum][i][3] > zero) {
        if (i == 0) {
          //　始発より前の時間の場合
          //時刻表示
          timetableCompact[0].insert(0, "-");
          timetableCompact[1].insert(0, DateFormat('HH:mm').format(timetable[tableNum][i][2]));
          timetableCompact[2].insert(0, DateFormat('HH:mm').format(timetable[tableNum][i + 1][2]));

          //残り時間表示
          timetableCompact[0].insert(1, "-");
          timetableCompact[1].insert(1, calcTimeRemaining(timetable[tableNum][i][3]));
          timetableCompact[2].insert(1, calcTimeRemaining(timetable[tableNum][i+1][3]));

          //発車場所/降車場所
          timetableCompact[0].insert(2, "-");
          timetableCompact[1].insert(2, timetable[tableNum][i][4]);
          timetableCompact[2].insert(2, timetable[tableNum][i + 1][4]);

          //車椅子対応or接続
          timetableCompact[0].insert(3, "-");
          timetableCompact[1].insert(3, timetable[tableNum][i][5]);
          timetableCompact[2].insert(3, timetable[tableNum][i + 1][5]);
          break;
        } else if (timetable[tableNum][i][3] > zero && i < timetable[tableNum].length - 1) {
          //通常時
          for (int j = 0; j < 3; j++) {
            timetableCompact[j].insert(0, DateFormat('HH:mm').format(timetable[tableNum][i - 1 + j][2]));
            timetableCompact[j].insert(1, calcTimeRemaining(timetable[tableNum][i - 1 + j][3]));
            timetableCompact[j].insert(2, timetable[tableNum][i - 1 + j][4]);
            timetableCompact[j].insert(3, timetable[tableNum][i - 1 + j][5]);
          }
          break;
        } else if (i == timetable[tableNum].length - 1) {
          // 次が最終便の場合
          //時刻表示
          timetableCompact[0].insert(0, DateFormat('HH:mm').format(timetable[tableNum][i - 1][2]));
          timetableCompact[1].insert(0, DateFormat('HH:mm').format(timetable[tableNum][i][2]));
          timetableCompact[2].insert(0, "-");

          //残り時間表示
          timetableCompact[0].insert(1, calcTimeRemaining(timetable[tableNum][i - 1][3]));
          timetableCompact[1].insert(1, calcTimeRemaining(timetable[tableNum][i][3]));
          timetableCompact[2].insert(1, "-");

          //発車場所/降車場所
          timetableCompact[0].insert(2, timetable[tableNum][i - 1][4]);
          timetableCompact[1].insert(2, timetable[tableNum][i][4]);
          timetableCompact[2].insert(2, "-");

          //車椅子対応or接続
          timetableCompact[0].insert(3, timetable[tableNum][i - 1][5]);
          timetableCompact[1].insert(3, timetable[tableNum][i][5]);
          timetableCompact[2].insert(3, "-");
          break;
        }
      } else if (i != 0) {
        //最終便の後の場合
        //時刻表示
        timetableCompact[0].insert(0, DateFormat('HH:mm').format(timetable[tableNum][i - 1][2]));
        timetableCompact[1].insert(0, "-");
        timetableCompact[2].insert(0, "-");

        //残り時間表示
        timetableCompact[0].insert(1, calcTimeRemaining(timetable[tableNum][i - 1][3]));
        timetableCompact[1].insert(1, "-");
        timetableCompact[2].insert(1, "-");

        //発車場所/降車場所
        timetableCompact[0].insert(2, timetable[tableNum][i - 1][4]);
        timetableCompact[1].insert(2, "-");
        timetableCompact[2].insert(2, "-");

        //車椅子対応or接続
        timetableCompact[0].insert(3, timetable[tableNum][i - 1][5]);
        timetableCompact[1].insert(3, "-");
        timetableCompact[2].insert(3, "-");
      }
    }
    timetable.add(timetableCompact);
  }

  return timetable;
}
