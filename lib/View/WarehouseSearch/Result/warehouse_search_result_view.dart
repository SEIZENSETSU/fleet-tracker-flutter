import 'package:fleet_tracker/Route/router.dart';
import 'package:flutter/material.dart';

class WarehouseSearchResultView extends StatefulWidget {
  const WarehouseSearchResultView({super.key});

  @override
  State<WarehouseSearchResultView> createState() =>
      _WarehouseSearchResultViewState();
}

class _WarehouseSearchResultViewState extends State<WarehouseSearchResultView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('倉庫検索結果'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            const WarehouseDetailRoute().push(context);
          },
          child: const Text('倉庫詳細'),
        ),
      ),
    );
  }
}
