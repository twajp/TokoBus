import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

statusBarColorSwitcher({required BuildContext context}) {
  switch (Theme.of(context).brightness) {
    case Brightness.light:
      return SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light, // for iOS
        statusBarIconBrightness: Brightness.dark, // for Android
        systemNavigationBarColor: Theme.of(context).colorScheme.background,
      );
    case Brightness.dark:
      return SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark, // for iOS
        statusBarIconBrightness: Brightness.light, // for Android
        systemNavigationBarColor: Theme.of(context).colorScheme.background,
      );
  }
}
