import 'package:fleet_tracker/Controller/top_loading_controller.dart';
import 'package:fleet_tracker/Service/Log/log_service.dart';
import 'package:fleet_tracker/gen/assets.gen.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class TopLoadingView extends StatelessWidget {
  const TopLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      TopLoadingController(context).firstLoad();
    } catch (e) {
      Log.echo('TopLoading Error: $e', symbol: '❌');
    }

    final double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: deviceHeight,
            child: Assets.images.topLoading.background.image(
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Assets.images.topLoading.main.image(),
                ),
                SizedBox(height: deviceHeight * 0.1),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(ColorName.splashMain),
                        strokeWidth: 3.0,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      '起動中...',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
