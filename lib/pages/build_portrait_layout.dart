import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import '../widgets/my_appbar.dart';
import '../widgets/compact_timetable_widget.dart';
import '../widgets/drawer_widget.dart';

final PageController controller = PageController(initialPage: 0);
final currentPageNotifier = ValueNotifier<int>(0);

buildPortraitLayout({required BuildContext context, required Size size, required timetable, required timetableInfoString}) {
  return Scaffold(
    appBar: myAppBar(context: context, timetable: timetable),
    drawer: drawerWidget(context: context, timetable: timetable, height: size.height, width: size.width),
    body: SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 7,
                child: PageView(
                  controller: controller,
                  onPageChanged: (int index) {
                    currentPageNotifier.value = index;
                  },
                  children: <Widget>[
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
              ),
            ],
          ),
          buildCircleIndicator(context: context, size: size),
        ],
      ),
    ),
  );
}

buildCircleIndicator({required BuildContext context, required Size size}) {
  int itemCount = 2;
  return Positioned(
    left: 0.0,
    right: 0.0,
    bottom: 0.0,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: CirclePageIndicator(
        itemCount: itemCount,
        dotColor: Theme.of(context).colorScheme.tertiary,
        selectedDotColor: Theme.of(context).colorScheme.onBackground,
        currentPageNotifier: currentPageNotifier,
      ),
    ),
  );
}
