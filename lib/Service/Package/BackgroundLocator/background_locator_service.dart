import 'package:background_task/background_task.dart';
import 'package:flutter/material.dart';

class BackgroundLocatorService {
  Future<void> backgroundHandler(Location data) async {
    debugPrint('🍑backgroundHandler: ${DateTime.now()}, $data');
  }
}
