import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

Future<void> jsonAlertHandler({required BuildContext context}) async {
  Map<String, dynamic> jsonData = {};

  final url = Uri.parse('https://raw.githubusercontent.com/twajp/TokoBus/master/data/dialog.json');
  // final url = Uri.parse('https://gist.githubusercontent.com/twajp/5effe414d9a1f1f711c5a1075d195646/raw/a8166965bf1266433e42b12f42b13adf6c01e138/dialog.json');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonBody = json.decode(response.body);
    jsonData = jsonBody;
    if (jsonData['flag'] == true) {
      _showJsonAlert(context: context, jsonData: jsonData);
    }
  } else {
    throw Exception('Failed to load JSON data');
  }
}

void _showJsonAlert({required BuildContext context, required Map<String, dynamic> jsonData}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(jsonData['title']),
        content: Text(jsonData['content']),
        actions: [
          TextButton(
            child: Text(
              '閉じる',
              style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          if (jsonData['url'] != '') ...{
            TextButton(
              onPressed: () async {
                await launch(jsonData['url']);
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                '開く',
                style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
              ),
            ),
          },
        ],
      );
    },
  );
}
