import 'package:flutter/material.dart';
import 'fullTimetableView.dart';

class compactTimetableWidget extends StatelessWidget {
  final List timetable;
  final Size size;
  final int tableIndex;
  const compactTimetableWidget({Key? key, required this.timetable, required this.size, required this.tableIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color wasedaColor = Color.fromRGBO(142, 23, 40, 1);
    const Color darkGrey = Color.fromRGBO(44, 44, 46, 1);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => fullTimetableView(timetable: timetable, size: size, tableIndex: tableIndex),
            fullscreenDialog: true,
          ),
        );
      },
      child: Container(
        //color: Colors.black,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(),
            Container(
              alignment: AlignmentDirectional.center,
              height: size.height * 0.1,
              width: size.width * 0.9,
              child: Text(
                timetable[8][tableIndex]["title"],
                style: TextStyle(fontSize: 30),
              ),
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  alignment: AlignmentDirectional.center,
                  color: darkGrey,
                  height: size.height * 0.06 * 4,
                  width: size.width * (0.2 + 0.35 + 0.2 + 0.16) * 1.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            alignment: AlignmentDirectional.center,
                            color: darkGrey,
                            height: size.height * 0.06,
                            width: size.width * 0.2,
                            child: Text(
                              timetable[8][tableIndex]["string0"],
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          Container(
                            alignment: AlignmentDirectional.center,
                            color: darkGrey,
                            height: size.height * 0.06,
                            width: size.width * 0.2,
                            child: Text(
                              "${timetable[tableIndex+4][0][0]}",
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          Container(
                            alignment: AlignmentDirectional.center,
                            color: wasedaColor,
                            height: size.height * 0.06,
                            width: size.width * 0.2,
                            child: Text(
                              "${timetable[tableIndex+4][1][0]}",
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          Container(
                            alignment: AlignmentDirectional.center,
                            color: darkGrey,
                            height: size.height * 0.06,
                            width: size.width * 0.2,
                            child: Text(
                              "${timetable[tableIndex+4][2][0]}",
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: AlignmentDirectional.center,
                          color: darkGrey,
                          height: size.height * 0.06,
                          width: size.width * 0.35,
                          child: Text(
                            timetable[8][tableIndex]["string1"],
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Container(
                          alignment: AlignmentDirectional.center,
                          color: darkGrey,
                          height: size.height * 0.06,
                          width: size.width * 0.35,
                          child: Text(
                            "${timetable[tableIndex+4][0][1]}",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Container(
                          alignment: AlignmentDirectional.center,
                          color: wasedaColor,
                          height: size.height * 0.06,
                          width: size.width * 0.35,
                          child: Text(
                            "${timetable[tableIndex+4][1][1]}",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Container(
                          alignment: AlignmentDirectional.center,
                          color: darkGrey,
                          height: size.height * 0.06,
                          width: size.width * 0.35,
                          child: Text(
                            "${timetable[tableIndex+4][2][1]}",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: AlignmentDirectional.center,
                          color: darkGrey,
                          height: size.height * 0.06,
                          width: size.width * 0.2,
                          child: Text(
                            timetable[8][tableIndex]["string2"],
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Container(
                          alignment: AlignmentDirectional.center,
                          color: darkGrey,
                          height: size.height * 0.06,
                          width: size.width * 0.2,
                          child: Text(
                            "${timetable[tableIndex+4][0][2]}",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Container(
                          alignment: AlignmentDirectional.center,
                          color: wasedaColor,
                          height: size.height * 0.06,
                          width: size.width * 0.2,
                          child: Text(
                            "${timetable[tableIndex+4][1][2]}",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Container(
                          alignment: AlignmentDirectional.center,
                          color: darkGrey,
                          height: size.height * 0.06,
                          width: size.width * 0.2,
                          child: Text(
                            "${timetable[tableIndex+4][2][2]}",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: AlignmentDirectional.center,
                          color: darkGrey,
                          height: size.height * 0.06,
                          width: size.width * 0.16,
                          child: Text(
                            timetable[8][tableIndex]["string3"],
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Container(
                          alignment: AlignmentDirectional.center,
                          color: darkGrey,
                          height: size.height * 0.06,
                          width: size.width * 0.16,
                          child: Text(
                            "${timetable[tableIndex+4][0][3]}",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Container(
                          alignment: AlignmentDirectional.center,
                          color: wasedaColor,
                          height: size.height * 0.06,
                          width: size.width * 0.16,
                          child: Text(
                            "${timetable[tableIndex+4][1][3]}",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Container(
                          alignment: AlignmentDirectional.center,
                          color: darkGrey,
                          height: size.height * 0.06,
                          width: size.width * 0.16,
                          child: Text(
                            "${timetable[tableIndex+4][2][3]}",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            if(tableIndex%2==1)...{
              Container(
                alignment: Alignment.center,
                height: 50,
                child: Text("${timetable[8]["tableVer"]} ${timetable[8]["dayOfWeek"]}ダイヤ"),
              ),
            }
          ],
        ),
      ),
    );
  }
}