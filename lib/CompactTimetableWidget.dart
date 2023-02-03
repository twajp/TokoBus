import 'package:flutter/material.dart';
import 'FullTimetableView.dart';

class CompactTimetableWidget extends StatelessWidget {
  final List timetable;
  final Size size;
  final int tableIndex;

  const CompactTimetableWidget({Key? key, required this.timetable, required this.size, required this.tableIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color wasedaColor = Color.fromRGBO(142, 23, 40, 1);
    const Color darkGrey = Color.fromRGBO(44, 44, 46, 1);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullTimetableView(timetable: timetable, size: size, tableIndex: tableIndex),
            fullscreenDialog: true,
          ),
        );
      },
      child: Column(
        children: [
          const Spacer(),
          Container(
            alignment: AlignmentDirectional.center,
            height: size.height * 0.1,
            width: size.width * 0.9,
            child: Text(
              timetable[8][tableIndex]["title"],
              style: const TextStyle(fontSize: 30),
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
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: darkGrey,
                        height: size.height * 0.06,
                        width: size.width * 0.2,
                        child: Text(
                          timetable[8][tableIndex]["string0"],
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: darkGrey,
                        height: size.height * 0.06,
                        width: size.width * 0.35,
                        child: Text(
                          timetable[8][tableIndex]["string1"],
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: darkGrey,
                        height: size.height * 0.06,
                        width: size.width * 0.2,
                        child: Text(
                          timetable[8][tableIndex]["string2"],
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: darkGrey,
                        height: size.height * 0.06,
                        width: size.width * 0.16,
                        child: Text(
                          timetable[8][tableIndex]["string3"],
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: darkGrey,
                        height: size.height * 0.06,
                        width: size.width * 0.2,
                        child: Text(
                          timetable[tableIndex + 4][0][0],
                          style: const TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: darkGrey,
                        height: size.height * 0.06,
                        width: size.width * 0.35,
                        child: Text(
                          timetable[tableIndex + 4][0][1],
                          style: const TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: darkGrey,
                        height: size.height * 0.06,
                        width: size.width * 0.2,
                        child: Text(
                          timetable[tableIndex + 4][0][2],
                          style: const TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: darkGrey,
                        height: size.height * 0.06,
                        width: size.width * 0.16,
                        child: Text(
                          timetable[tableIndex + 4][0][3],
                          style: const TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: wasedaColor,
                        height: size.height * 0.06,
                        width: size.width * 0.2,
                        child: Text(
                          timetable[tableIndex + 4][1][0],
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: wasedaColor,
                        height: size.height * 0.06,
                        width: size.width * 0.35,
                        child: Text(
                          timetable[tableIndex + 4][1][1],
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: wasedaColor,
                        height: size.height * 0.06,
                        width: size.width * 0.2,
                        child: Text(
                          timetable[tableIndex + 4][1][2],
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: wasedaColor,
                        height: size.height * 0.06,
                        width: size.width * 0.16,
                        child: Text(
                          timetable[tableIndex + 4][1][3],
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: darkGrey,
                        height: size.height * 0.06,
                        width: size.width * 0.2,
                        child: Text(
                          timetable[tableIndex + 4][2][0],
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: darkGrey,
                        height: size.height * 0.06,
                        width: size.width * 0.35,
                        child: Text(
                          timetable[tableIndex + 4][2][1],
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: darkGrey,
                        height: size.height * 0.06,
                        width: size.width * 0.2,
                        child: Text(
                          timetable[tableIndex + 4][2][2],
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: darkGrey,
                        height: size.height * 0.06,
                        width: size.width * 0.16,
                        child: Text(
                          timetable[tableIndex + 4][2][3],
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          if (tableIndex % 2 == 1) ...{
            Container(
              alignment: Alignment.center,
              height: 50,
              child: Text("${timetable[8]["tableVer"]} ${timetable[8]["dayOfWeek"]}ダイヤ"),
            ),
          }
        ],
      ),
    );
  }
}
