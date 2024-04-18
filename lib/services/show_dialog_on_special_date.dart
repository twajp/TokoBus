import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void showDialogOnSpecialDate({required BuildContext context, required timetable}) {
  DateTime currentDate = DateTime.now();
  String url = timetable["pdf_url"]["default"];
  if (timetable["pdf_url"]["special"].containsKey(DateTime(currentDate.year, currentDate.month, currentDate.day))) {
    url = timetable["pdf_url"]["special"][DateTime(currentDate.year, currentDate.month, currentDate.day)];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("本日は特別ダイヤです"),
          content: const Text("本日の特別ダイヤは未対応です。\n大学ウェブサイトのPDFを確認しますか？"),
          actions: [
            TextButton(
              child: const Text("閉じる"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: () async {
                await launch(url);
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text("開く"),
            ),
          ],
        );
      },
    );
  }
}
