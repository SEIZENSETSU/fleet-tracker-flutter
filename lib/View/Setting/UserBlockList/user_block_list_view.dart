import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:flutter/material.dart';

class UserBlockListView extends StatefulWidget {
  const UserBlockListView({super.key});

  @override
  State<UserBlockListView> createState() => _UserBlockListViewState();
}

class _UserBlockListViewState extends State<UserBlockListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'ブロックリスト',
      ),
    );
  }
}
