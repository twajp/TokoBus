import 'package:flutter/material.dart';
import '../widgets/my_appbar.dart';
import '../widgets/compact_timetable_widget.dart';
import '../widgets/drawer_widget.dart';

buildLandscapeLayout({required BuildContext context, required Size size, required timetable, required timetableInfoString}) {
  return Scaffold(
    appBar: homeAppBar(context: context, timetable: timetable),
    drawer: homeDrawer(context: context, timetable: timetable, height: size.height, width: size.height),
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
                timetableInfoString,
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
