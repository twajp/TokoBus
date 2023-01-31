import 'package:intl/intl.dart';

void main() {
  List timetable = [
    [8, 00, "北口", "×"],
    [8, 05, "北口", "〇"],
    [8, 08, "北口", "×"],
    [8, 11, "北口", "×"],
    [8, 14, "北口", "×"],
    [8, 17, "北口", "×"],
    [8, 20, "北口", "×"],
    [8, 23, "北口", "×"],
    [8, 26, "北口", "×"],
    [8, 29, "北口", "×"],
    [8, 32, "北口", "×"],
    [8, 35, "北口", "×"],
    [8, 45, "北口", "×"],
    [8, 55, "北口", "×"],
    [9, 05, "北口", "×"],
    [9, 15, "北口", "×"],
    [9, 25, "北口", "×"],
    [9, 35, "北口", "×"],
    [9, 42, "北口", "〇"],
    [9, 45, "北口", "×"],
    [9, 48, "北口", "×"],
    [9, 51, "北口", "×"],
    [9, 55, "北口", "×"],
    [10, 02, "北口", "×"],
    [10, 05, "北口", "×"],
    [10, 08, "北口", "×"],
    [10, 11, "北口", "×"],
    [10, 14, "北口", "×"],
    [10, 17, "北口", "×"],
    [10, 20, "北口", "×"],
    [10, 25, "北口", "×"],
    [10, 35, "北口", "×"],
    [10, 50, "北口", "×"],
    [11, 05, "北口", "×"],
    [11, 20, "北口", "×"],
    [11, 35, "北口", "×"],
    [11, 45, "北口", "×"],
    [11, 55, "北口", "×"],
    [12, 05, "北口", "×"],
    [12, 10, "北口", "〇"],
    [12, 15, "北口", "×"],
    [12, 20, "北口", "×"],
    [12, 25, "北口", "×"],
    [12, 35, "北口", "×"],
    [12, 45, "北口", "×"],
    [12, 55, "北口", "×"],
    [13, 15, "北口", "〇"],
    [13, 25, "南口", "×"],
    [13, 35, "南口", "×"],
    [13, 45, "南口", "×"],
    [13, 50, "南口", "×"],
    [14, 00, "南口", "×"],
    [14, 05, "南口", "×"],
    [14, 10, "南口", "×"],
    [14, 15, "南口", "×"],
    [14, 20, "南口", "×"],
    [14, 25, "南口", "×"],
    [14, 35, "南口", "×"],
    [14, 45, "南口", "×"],
    [14, 55, "南口", "×"],
    [15, 05, "南口", "×"],
    [15, 15, "南口", "×"],
    [15, 40, "北口", "〇"],
    [15, 45, "南口", "×"],
    [16, 00, "南口", "×"],
    [16, 15, "南口", "×"],
    [16, 30, "南口", "×"],
    [16, 45, "南口", "×"],
    [16, 55, "南口", "×"],
    [17, 20, "北口", "〇"],
    [17, 45, "南口", "×"],
    [18, 15, "南口", "×"],
    [18, 45, "南口", "×"],
    [19, 20, "北口", "〇"],
    [19, 45, "南口", "×"],
    [20, 15, "南口", "×"]
  ];

  //現在時刻と0時0分の取得
  var now = DateTime.now();
  var lastMidnight = DateTime(now.year, now.month, now.day);

  //時刻と残り時間をdatetime型でリストに追加
  for (int i = 0; i < timetable.length; i++) {
    var dtBus = lastMidnight.add(Duration(hours: timetable[i][0], minutes: timetable[i][1]));
    final Duration duration = dtBus.difference(now);
    timetable[i].insert(2, dtBus);
    timetable[i].insert(3, duration);
  }



  List CulcCountdown(List timetable) {
    print(timetable.length);
    List timetableShow = [[],[],[]];
    const Duration zero = Duration(seconds: 0);
    for (int i = 0; i < timetable.length; i++) {
      if (timetable[i][3] > zero) {
        if (i == 0) { //　始発より前の時間の場合
          //時刻表示
          timetableShow[0].insert(0, "-");
          timetableShow[1].insert(0, DateFormat('hh:mm').format(timetable[i][2]));
          timetableShow[2].insert(0, DateFormat('hh:mm').format(timetable[i + 1][2]));

          //残り時間表示
          timetableShow[0].insert(1, "-");
          timetableShow[1].insert(1, "${timetable[i][3].inHours}:${timetable[i][3].inMinutes.remainder(60)}:${(timetable[i][3].inSeconds.remainder(60))}");
          timetableShow[2].insert(1, "${timetable[i + 1][3].inHours}:${timetable[i + 1][3].inMinutes.remainder(60)}:${(timetable[i + 1][3].inSeconds.remainder(60))}");

          //発車場所/降車場所
          timetableShow[0].insert(2, "-");
          timetableShow[1].insert(2, timetable[i][4]);
          timetableShow[2].insert(2, timetable[i + 1][4]);

          //車椅子対応or接続
          timetableShow[0].insert(3, "-");
          timetableShow[1].insert(3, timetable[i][5]);
          timetableShow[2].insert(3, timetable[i + 1][5]);
          break;
        } else if (timetable[i][3] > zero && i < timetable.length - 1) { //通常時
          for (int j = 0; j < 3; j++) {
            timetableShow[j].insert(0, DateFormat('hh:mm').format(timetable[i - 1 + j][2]));
            timetableShow[j].insert(1, "${timetable[i - 1 + j][3].inHours}:${timetable[i - 1 + j][3].inMinutes.remainder(60)}:${(timetable[i - 1 + j][3].inSeconds.remainder(60))}");
            timetableShow[j].insert(2, timetable[i - 1 + j][4]);
            timetableShow[j].insert(3, timetable[i - 1 + j][5]);
          }
          break;
        } else if (i == timetable.length - 1) { // 次が最終便の場合
          //時刻表示
          timetableShow[0].insert(0, DateFormat('hh:mm').format(timetable[i - 1][2]));
          timetableShow[1].insert(0, DateFormat('hh:mm').format(timetable[i][2]));
          timetableShow[2].insert(0, "-");

          //残り時間表示
          timetableShow[0].insert(1, "${timetable[i - 1][3].inHours}:${timetable[i - 1][3].inMinutes.remainder(60)}:${(timetable[i - 1][3].inSeconds.remainder(60))}");
          timetableShow[1].insert(1, "${timetable[i][3].inHours}:${timetable[i][3].inMinutes.remainder(60)}:${(timetable[i][3].inSeconds.remainder(60))}");
          timetableShow[2].insert(1, "-");

          //発車場所/降車場所
          timetableShow[0].insert(2, timetable[i - 1][4]);
          timetableShow[1].insert(2, timetable[i][4]);
          timetableShow[2].insert(2, "-");

          //車椅子対応or接続
          timetableShow[0].insert(3, timetable[i - 1][5]);
          timetableShow[1].insert(3, timetable[i][5]);
          timetableShow[2].insert(3, "-");
          break;
        }
      } else {//最終便の後の場合
        //時刻表示
        timetableShow[0].insert(0, DateFormat('hh:mm').format(timetable[i - 1][2]));
        timetableShow[1].insert(0, "-");
        timetableShow[2].insert(0, "-");

        //残り時間表示
        timetableShow[0].insert(1, "${timetable[i - 1][3].inHours}:${timetable[i - 1][3].inMinutes.remainder(60)}:${(timetable[i - 1][3].inSeconds.remainder(60))}");
        timetableShow[1].insert(1, "-");
        timetableShow[2].insert(1, "-");

        //発車場所/降車場所
        timetableShow[0].insert(2, timetable[i - 1][4]);
        timetableShow[1].insert(2, "-");
        timetableShow[2].insert(2, "-");

        //車椅子対応or接続
        timetableShow[0].insert(3, timetable[i - 1][5]);
        timetableShow[1].insert(3, "-");
        timetableShow[2].insert(3, "-");
      }
    }
    return timetableShow;
  }
  print(CulcCountdown(timetable));
}
