import 'package:flutter/material.dart';

import '../../../../../Controller/Setting/License/license_controller.dart';
import '../../../../../gen/assets.gen.dart';

class LicenseView extends StatefulWidget {
  const LicenseView({super.key});

  @override
  State<LicenseView> createState() => _LicenseViewState();
}

class _LicenseViewState extends State<LicenseView> {
  late LicenseController _controller;

  @override
  void initState() {
    super.initState();
    _controller = LicenseController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _controller.getAppVersion(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return LicensePage(
              applicationName: 'FleetTracker', // アプリの名前
              applicationVersion: _controller.applicationVersion, // バージョン
              applicationIcon: Assets.images.icons.cloudIcon.image(
                width: 100,
                height: 100,
              ),
              applicationLegalese: 'All rights reserved', // 著作権表示
            );
          } else {
            return const Center(child: Text('Error'));
          }
        },
      ),
    );
  }
}
