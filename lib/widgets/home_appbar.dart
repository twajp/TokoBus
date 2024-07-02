import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

homeAppBar({required BuildContext context, required timetable}) {
  return AppBar(
    title: Image.asset('assets/icon/icon_transparent.png', height: kToolbarHeight),
    centerTitle: true,
    actions: [
      PopupMenuButton(
        icon: Icon(
          Icons.more_vert,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        color: Theme.of(context).colorScheme.secondary,
        itemBuilder: (context) {
          return [
            const PopupMenuItem<int>(
              value: 0,
              child: Text('大学公式PDFを開く'),
            ),
            const PopupMenuItem<int>(
              value: 1,
              child: Text('問い合わせ / 不具合報告'),
            ),
            const PopupMenuItem<int>(
              value: 2,
              child: Text('TokoBusについて'),
            ),
          ];
        },
        onSelected: (value) {
          if (value == 0) {
            myLaunchUrl(timetable['pdf_url']['default']);
          } else if (value == 1) {
            myLaunchUrl('https://twajp.github.io/TokoBusWebsite/support');
          } else if (value == 2) {
            myLaunchUrl('https://twajp.github.io/TokoBusWebsite/');
          }
        },
      ),
    ],
  );
}

Future<void> myLaunchUrl(url) async {
  if (!await launch(url)) {
    throw Exception('Could not launch $url');
  }
}
