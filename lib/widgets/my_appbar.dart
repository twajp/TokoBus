import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

myAppBar({required BuildContext context, required timetable}) {
  return AppBar(
    title: Image.asset('assets/icon/icon_transparent.png', height: kToolbarHeight),
    backgroundColor: Theme.of(context).colorScheme.background,
    centerTitle: true,
    actions: [
      PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (context) {
          return [
            const PopupMenuItem<int>(
              value: 0,
              child: Text("大学公式PDFを開く"),
            ),
            const PopupMenuItem<int>(
              value: 1,
              child: Text("時刻表の間違いを報告する"),
            ),
            const PopupMenuItem<int>(
              value: 2,
              child: Text("TokoBusについて"),
            ),
          ];
        },
        onSelected: (value) {
          if (value == 0) {
            myLaunchUrl(timetable["pdf_url"]["default"]);
          } else if (value == 1) {
            myLaunchUrl("https://twajp.github.io/TokoBusWebsite/support");
          } else if (value == 2) {
            myLaunchUrl("https://twajp.github.io/TokoBusWebsite/");
          }
        },
      ),
    ],
  );
}

Future<void> myLaunchUrl(url) async {
  if (!await launch(url)) {
    throw Exception("Could not launch $url");
  }
}
