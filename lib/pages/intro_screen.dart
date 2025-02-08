import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreenPage extends StatelessWidget {
  const IntroScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pageDecoration = PageDecoration(
      titleTextStyle: Theme.of(context).textTheme.headlineMedium!,
      bodyTextStyle: Theme.of(context).textTheme.bodyLarge!,
      titlePadding: const EdgeInsets.only(top: 80.0, bottom: 30.0),
      bodyPadding: const EdgeInsets.symmetric(horizontal: 24.0),
      imagePadding: const EdgeInsets.all(16.0),
      contentMargin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
    );

    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "TokoBusへようこそ",
          body: "早稲田大学所沢キャンパスの非公式スクールバス時刻表アプリです。",
          // image: Center(child: Image.asset("assets/icon/icon_transparent.png", height: 170)),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "ご注意",
          body: "本アプリは学生が趣味で開発している非公式なものです。\n"
              "テストなど重要な日には、公式サイトも併用することを推奨します。\n"
              "本アプリの不具合等によるいかなる損害についても一切の責任を負いかねます。",
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "お願い",
          body: "時刻表の間違いやアプリの不具合がございましたら、右上のメニューからご報告ください。\n",
          decoration: pageDecoration,
        ),
      ],
      onDone: () async {
        final navigator = Navigator.of(context);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('haveSeenIntro', true);
        navigator.pop();
      },

      // back: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface),
      // next: Icon(Icons.arrow_forward, color: Theme.of(context).colorScheme.onSurface),
      // done: Icon(Icons.done, color: Theme.of(context).colorScheme.onSurface),

      showBackButton: true,
      back: _buildCircularButton(
        context,
        Icons.arrow_back,
        Theme.of(context).colorScheme.secondary,
      ),
      next: _buildCircularButton(
        context,
        Icons.arrow_forward,
        Theme.of(context).colorScheme.primary,
      ),
      done: _buildCircularButton(
        context,
        Icons.done,
        Theme.of(context).colorScheme.primary,
      ),
      dotsDecorator: DotsDecorator(
        activeColor: Theme.of(context).colorScheme.onTertiary,
        color: Theme.of(context).colorScheme.tertiary,
        activeSize: const Size(12.0, 12.0),
        size: const Size(8.0, 8.0),
      ),
    );
  }

  Widget _buildCircularButton(BuildContext context, IconData icon, Color bgColor) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor,
      ),
      padding: const EdgeInsets.all(14.0),
      child: Icon(
        icon,
        color: Theme.of(context).colorScheme.onPrimary,
        size: 28,
      ),
    );
  }
}
