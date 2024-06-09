import 'package:fleet_tracker/Route/router.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class TopLoadingController {
  final BuildContext context;
  TopLoadingController(this.context);

  Future<void> firstLoad() async {
    /// 画面を縦向きに固定
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    await Future.delayed(const Duration(seconds: 2, milliseconds: 500));
    // ignore: use_build_context_synchronously, prefer_const_constructors
    HomeRoute().go(context);
  }
}
