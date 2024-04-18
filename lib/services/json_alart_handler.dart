import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

Future<void> jsonAlertHandler({required BuildContext context}) async {
  Map<String, dynamic> jsonData = {};

  final url = Uri.parse("https://raw.githubusercontent.com/twajp/TokoBus/main/data/dialog.json");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonBody = json.decode(response.body);
    jsonData = jsonBody;
    if (jsonData["flag"] == true) {
      _showJsonAlert(context: context, jsonData: jsonData);
    }
  } else {
    throw Exception("Failed to load JSON data");
  }
}

void _showJsonAlert({required BuildContext context, required Map<String, dynamic> jsonData}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(jsonData["title"]),
        content: Text(jsonData["content"]),
        actions: [
          TextButton(
            child: const Text("閉じる"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          if (jsonData["url"] != "") ...{
            TextButton(
              onPressed: () async {
                await launch(jsonData["url"]);
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text("開く"),
            ),
          },
        ],
      );
    },
  );
}
