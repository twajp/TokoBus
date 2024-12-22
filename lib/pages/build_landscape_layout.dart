import 'package:flutter/material.dart';
import '../widgets/home_appbar.dart';
import '../widgets/compact_timetable_widget.dart';
import '../widgets/home_drawer.dart';

buildLandscapeLayout({required BuildContext context, required Size size, required timetable}) {
  return Scaffold(
    appBar: homeAppBar(context: context, timetable: timetable),
    drawer: HomeDrawer(context: context, timetable: timetable, height: size.height, width: size.height),
    backgroundColor: Theme.of(context).colorScheme.background,
    body: SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: <Widget>[
                    Expanded(child: CompactTimetableWidget(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width, tableIndex: 0)),
                    Expanded(child: CompactTimetableWidget(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width, tableIndex: 1)),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Expanded(child: CompactTimetableWidget(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width, tableIndex: 2)),
                    Expanded(child: CompactTimetableWidget(timetable: timetable, deviceHeight: size.height, deviceWidth: size.width, tableIndex: 3)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                '${timetable['tableInfo']['dayOfWeek']}   時刻表Ver: ${timetable['tableInfo']['tableVer']}',
                textAlign: TextAlign.center,
                style: Theme.of(context).primaryTextTheme.bodyMedium,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
