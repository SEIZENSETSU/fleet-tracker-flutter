import 'package:fleet_tracker/gen/assets.gen.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';

import 'View/Component/CustomWidget/custom_text.dart';
import 'View/Component/Tutorial/sliding_tutorial.dart';

class TutorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<double> notifier = ValueNotifier(0);
    int pageCount = 5;

    /// Android系の戻るボタンを機能させなくさせる。
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorName.tutorialBackground,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: SlidingTutorial(
                  pageCount: pageCount,
                  notifier: notifier,
                ),
              ),
              Container(
                width: double.infinity,
                height: 40,
                child: SlidingIndicator(
                  indicatorCount: pageCount,
                  notifier: notifier,
                  inactiveIndicatorSize: 20,
                  inActiveIndicator: const Icon(
                    Icons.radio_button_unchecked,
                    color: Colors.white,
                    size: 24,
                  ),
                  activeIndicatorSize: 20,
                  activeIndicator: const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 24,
                  ),
                  margin: 8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
