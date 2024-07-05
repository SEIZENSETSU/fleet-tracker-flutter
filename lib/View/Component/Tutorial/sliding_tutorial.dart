import 'package:fleet_tracker/Constants/Enum/shared_preferences_keys_enum.dart';
import 'package:fleet_tracker/Route/router.dart';
import 'package:fleet_tracker/Service/Log/log_service.dart';
import 'package:fleet_tracker/Service/Package/SharedPreferences/shared_preferences_service.dart';
import 'package:fleet_tracker/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class SlidingTutorial extends StatefulWidget {
  final ValueNotifier<double> notifier;
  final int pageCount;

  SlidingTutorial({
    super.key,
    required this.notifier,
    required this.pageCount,
  });

  @override
  State<SlidingTutorial> createState() => _TutorialState();
}

class _TutorialState extends State<SlidingTutorial> {
  final _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    _pageController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onFinishTutorial() async {
    // 設定を変更する
    // Topまで戻る
    SharedPreferencesService prefs = SharedPreferencesService();
    bool isFirstBoot =
        await prefs.getBool(SharedPreferencesKeysEnum.isFirstBoot.name) ?? true;
    Log.echo("isFirstBoot: $isFirstBoot");
    if (isFirstBoot) {
      await prefs.setBool(SharedPreferencesKeysEnum.isFirstBoot.name, false);
      // ignore: use_build_context_synchronously, prefer_const_constructors
      HomeRoute().go(context);
      return;
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: List<Widget>.generate(
        widget.pageCount,
        (index) => _getPageByIndex(index),
      ),
    );
  }

  Widget _getPageByIndex(int index) {
    final imageName = 'assets/images/tutorial/${index + 1}.png';
    if (index < 4) {
      return Image.asset(
        imageName,
        alignment: Alignment.center,
        fit: BoxFit.contain,
      );
    } else {
      return GestureDetector(
        onTap: () {
          _onFinishTutorial();
        }, // handle your image tap here
        child: Image.asset(
          imageName,
          key: Key("tutorialLastPage"),
          alignment: Alignment.center,
          fit: BoxFit.contain,
        ),
      );
    }
  }

  void _onScroll() {
    widget.notifier?.value = _pageController.page!;
  }
}
