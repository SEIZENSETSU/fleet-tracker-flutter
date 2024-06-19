import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomScaffold extends StatelessWidget {
  CustomScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.floatingActionButton,
    this.backgroundColor = ColorName.scaffoldBackground,
  });

  PreferredSizeWidget? appBar;
  Widget body;
  FloatingActionButton? floatingActionButton;
  Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: floatingActionButton,
      appBar: appBar,
      body: body,
    );
  }
}
