import 'package:flutter/material.dart';
import '../pages/full_timetable_page.dart';

Widget homeDrawer({required BuildContext context, required timetable, required height, required width}) {
  final String weekdaysTimetableName = timetable["fullTables"]["stationCampusWeekdays"]["dayOfWeek"] + "ダイヤ";
  final String saturdaysTimetableName = timetable["fullTables"]["stationCampusSaturdays"]["dayOfWeek"] + "ダイヤ";
  final String sundaysHolidaysTimetableName = timetable["fullTables"]["stationCampusSundaysHolidays"]["dayOfWeek"] + "ダイヤ";
  String specialTimetableName;
  if (timetable["fullTables"].containsKey("stationCampusSpecial")) {
    specialTimetableName = timetable["fullTables"]["stationCampusSpecial"]["dayOfWeek"] + "ダイヤ";
  } else {
    specialTimetableName = "";
  }
  return Drawer(
    backgroundColor: Theme.of(context).colorScheme.background,
    child: SafeArea(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              border: const Border(bottom: BorderSide.none),
            ),
            child: Center(
              child: Image.asset('assets/icon/icon_transparent.png'),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  ExpansionTile(
                    title: Text(weekdaysTimetableName),
                    leading: const Icon(Icons.school),
                    textColor: Theme.of(context).colorScheme.onBackground,
                    iconColor: Theme.of(context).colorScheme.onBackground,
                    collapsedTextColor: Theme.of(context).colorScheme.onBackground,
                    collapsedIconColor: Theme.of(context).colorScheme.onBackground,
                    initiallyExpanded: true,
                    childrenPadding: const EdgeInsets.only(left: 56),
                    children: [
                      ListTile(
                        title: Text(timetable["tableInfo"][0]["title"]),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullTimetableView(tableName: "stationCampusWeekdays", timetable: timetable, deviceHeight: height, deviceWidth: width),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: Text(timetable["tableInfo"][1]["title"]),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullTimetableView(tableName: "campusStationWeekdays", timetable: timetable, deviceHeight: height, deviceWidth: width),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: Text(timetable["tableInfo"][2]["title"]),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullTimetableView(tableName: "campusFRCWeekdays", timetable: timetable, deviceHeight: height, deviceWidth: width),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: Text(timetable["tableInfo"][3]["title"]),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullTimetableView(tableName: "frcCampusWeekdays", timetable: timetable, deviceHeight: height, deviceWidth: width),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  if (specialTimetableName != "") ...{
                    ExpansionTile(
                      title: Text(specialTimetableName),
                      leading: const Icon(Icons.school),
                      textColor: Theme.of(context).colorScheme.onBackground,
                      iconColor: Theme.of(context).colorScheme.onBackground,
                      collapsedTextColor: Theme.of(context).colorScheme.onBackground,
                      collapsedIconColor: Theme.of(context).colorScheme.onBackground,
                      childrenPadding: const EdgeInsets.only(left: 56),
                      children: [
                        ListTile(
                          title: Text(timetable["tableInfo"][0]["title"]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullTimetableView(tableName: "stationCampusSpecial", timetable: timetable, deviceHeight: height, deviceWidth: width),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: Text(timetable["tableInfo"][1]["title"]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullTimetableView(tableName: "campusStationSpecial", timetable: timetable, deviceHeight: height, deviceWidth: width),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  },
                  ExpansionTile(
                    title: Text(saturdaysTimetableName),
                    leading: const Icon(Icons.weekend),
                    textColor: Theme.of(context).colorScheme.onBackground,
                    iconColor: Theme.of(context).colorScheme.onBackground,
                    collapsedTextColor: Theme.of(context).colorScheme.onBackground,
                    collapsedIconColor: Theme.of(context).colorScheme.onBackground,
                    childrenPadding: const EdgeInsets.only(left: 56),
                    children: [
                      ListTile(
                        title: Text(timetable["tableInfo"][0]["title"]),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullTimetableView(tableName: "stationCampusSaturdays", timetable: timetable, deviceHeight: height, deviceWidth: width),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: Text(timetable["tableInfo"][1]["title"]),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullTimetableView(tableName: "campusStationSaturdays", timetable: timetable, deviceHeight: height, deviceWidth: width),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: Text(timetable["tableInfo"][2]["title"]),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullTimetableView(tableName: "campusFRCSaturdays", timetable: timetable, deviceHeight: height, deviceWidth: width),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: Text(timetable["tableInfo"][3]["title"]),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullTimetableView(tableName: "frcCampusSaturdays", timetable: timetable, deviceHeight: height, deviceWidth: width),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(sundaysHolidaysTimetableName),
                    leading: const Icon(Icons.weekend),
                    textColor: Theme.of(context).colorScheme.onBackground,
                    iconColor: Theme.of(context).colorScheme.onBackground,
                    collapsedTextColor: Theme.of(context).colorScheme.onBackground,
                    collapsedIconColor: Theme.of(context).colorScheme.onBackground,
                    childrenPadding: const EdgeInsets.only(left: 56),
                    children: [
                      ListTile(
                        title: Text(timetable["tableInfo"][0]["title"]),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullTimetableView(tableName: "stationCampusSundaysHolidays", timetable: timetable, deviceHeight: height, deviceWidth: width),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: Text(timetable["tableInfo"][1]["title"]),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullTimetableView(tableName: "campusStationSundaysHolidays", timetable: timetable, deviceHeight: height, deviceWidth: width),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
