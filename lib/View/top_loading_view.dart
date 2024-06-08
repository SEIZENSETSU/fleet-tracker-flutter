import 'package:fleet_tracker/Controller/top_loading_controller.dart';
import 'package:flutter/material.dart';

class TopLoadingView extends StatelessWidget {
  const TopLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    TopLoadingController(context).firstLoad();

    return const Scaffold(
      body: Center(child: Text('TopLoadingView')),
    );
  }
}
