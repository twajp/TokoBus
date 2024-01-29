import 'package:flutter/material.dart';
import 'FullTimetableView.dart';

class CompactTimetableWidget extends StatelessWidget {
  final Map timetable;
  final double deviceHeight;
  final double deviceWidth;
  final int tableIndex;

  const CompactTimetableWidget({super.key, required this.timetable, required this.deviceHeight, required this.deviceWidth, required this.tableIndex});

  width1() {
    if (deviceHeight > deviceWidth) {
      return deviceWidth;
    } else {
      return deviceWidth / 2.2;
    }
  }

  width2() {
    if (deviceHeight > deviceWidth) {
      return deviceWidth;
    } else {
      return deviceHeight;
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color wasedaColor = Color.fromRGBO(142, 23, 40, 1);
    const Color darkGrey = Color.fromRGBO(44, 44, 46, 1);
    return GestureDetector(
      onTap: () {
        if (timetable["tableInfo"]["selectedTableNames"][tableIndex] != "") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FullTimetableView(timetable: timetable, deviceHeight: deviceHeight, deviceWidth: width2(), tableName: timetable["tableInfo"]["selectedTableNames"][tableIndex]),
              fullscreenDialog: true,
            ),
          );
        }
      },
      child: Column(
        children: [
          const Spacer(),
          Container(
            alignment: AlignmentDirectional.center,
            height: deviceHeight * 0.1,
            width: width1() * 0.9,
            child: Text(
              timetable["tableInfo"][tableIndex]["title"],
              style: const TextStyle(fontSize: 30),
              softWrap: false,
            ),
          ),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                alignment: AlignmentDirectional.center,
                color: darkGrey,
                height: deviceHeight * 0.06 * 4,
                width: width1() * (0.2 + 0.35 + 0.2 + 0.16) * 1.05,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: darkGrey,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.2,
                        child: Text(
                          timetable["tableInfo"][tableIndex]["string0"],
                          style: const TextStyle(fontSize: 17),
                          softWrap: false,
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: darkGrey,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.35,
                        child: Text(
                          timetable["tableInfo"][tableIndex]["string1"],
                          style: const TextStyle(fontSize: 17),
                          softWrap: false,
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: darkGrey,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.2,
                        child: Text(
                          timetable["tableInfo"][tableIndex]["string2"],
                          style: const TextStyle(fontSize: 17),
                          softWrap: false,
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: darkGrey,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.16,
                        child: Text(
                          timetable["tableInfo"][tableIndex]["string3"],
                          style: const TextStyle(fontSize: 17),
                          softWrap: false,
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
                        height: deviceHeight * 0.06,
                        width: width1() * 0.2,
                        child: Text(
                          timetable["compactTables"][tableIndex][0][0],
                          style: const TextStyle(fontSize: 17, color: Colors.grey),
                          softWrap: false,
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: darkGrey,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.35,
                        child: Text(
                          timetable["compactTables"][tableIndex][0][1],
                          style: const TextStyle(fontSize: 17, color: Colors.grey),
                          softWrap: false,
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: darkGrey,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.2,
                        child: Text(
                          timetable["compactTables"][tableIndex][0][2],
                          style: const TextStyle(fontSize: 17, color: Colors.grey),
                          softWrap: false,
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: darkGrey,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.16,
                        child: Text(
                          timetable["compactTables"][tableIndex][0][3],
                          style: const TextStyle(fontSize: 17, color: Colors.grey),
                          softWrap: false,
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
                        height: deviceHeight * 0.06,
                        width: width1() * 0.2,
                        child: Text(
                          timetable["compactTables"][tableIndex][1][0],
                          style: const TextStyle(fontSize: 17),
                          softWrap: false,
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: wasedaColor,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.35,
                        child: Text(
                          timetable["compactTables"][tableIndex][1][1],
                          style: const TextStyle(fontSize: 17),
                          softWrap: false,
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: wasedaColor,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.2,
                        child: Text(
                          timetable["compactTables"][tableIndex][1][2],
                          style: const TextStyle(fontSize: 17),
                          softWrap: false,
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: wasedaColor,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.16,
                        child: Text(
                          timetable["compactTables"][tableIndex][1][3],
                          style: const TextStyle(fontSize: 17),
                          softWrap: false,
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
                        height: deviceHeight * 0.06,
                        width: width1() * 0.2,
                        child: Text(
                          timetable["compactTables"][tableIndex][2][0],
                          style: const TextStyle(fontSize: 17),
                          softWrap: false,
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: darkGrey,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.35,
                        child: Text(
                          timetable["compactTables"][tableIndex][2][1],
                          style: const TextStyle(fontSize: 17),
                          softWrap: false,
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: darkGrey,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.2,
                        child: Text(
                          timetable["compactTables"][tableIndex][2][2],
                          style: const TextStyle(fontSize: 17),
                          softWrap: false,
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: darkGrey,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.16,
                        child: Text(
                          timetable["compactTables"][tableIndex][2][3],
                          style: const TextStyle(fontSize: 17),
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
