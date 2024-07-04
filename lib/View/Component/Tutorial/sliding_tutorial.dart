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
    Navigator.pop(context);
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
    final imageName = Assets.images.icons.sunIcon.path;
    if (index < 3) {
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
