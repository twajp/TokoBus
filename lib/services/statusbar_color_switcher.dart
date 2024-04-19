import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

statusBarColorSwitcher({required BuildContext context}) {
  switch (Theme.of(context).brightness) {
    case Brightness.light:
      return const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light, // for iOS
        statusBarIconBrightness: Brightness.dark, // for Android
      );
    case Brightness.dark:
      return const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark, // for iOS
        statusBarIconBrightness: Brightness.light, // for Android
      );
  }
}
