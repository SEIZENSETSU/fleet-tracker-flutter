import 'package:fleet_tracker/Route/router.dart';
import 'package:flutter/material.dart';

class WarehouseSearchTopView extends StatefulWidget {
  const WarehouseSearchTopView({super.key});

  @override
  State<WarehouseSearchTopView> createState() => _WarehouseSearchTopViewState();
}

class _WarehouseSearchTopViewState extends State<WarehouseSearchTopView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('倉庫検索'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            const WarehouseSearchResultRoute().push(context);
          },
          child: const Text('倉庫検索'),
        ),
      ),
    );
  }
}
