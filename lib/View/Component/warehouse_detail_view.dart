import 'package:flutter/material.dart';

import '../../Route/router.dart';
import '../../Service/Log/log_service.dart';

class WarehouseDetailView extends StatefulWidget {
  const WarehouseDetailView({super.key});

  @override
  State<WarehouseDetailView> createState() => _WarehouseDetailViewState();
}

class _WarehouseDetailViewState extends State<WarehouseDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('倉庫詳細'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Log.echo('トップへ');
            const HomeRoute().go(context);
          },
          child: const Text('トップへ'),
        ),
      ),
    );
  }
}
