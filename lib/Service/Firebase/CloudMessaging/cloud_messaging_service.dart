import 'package:firebase_messaging/firebase_messaging.dart';

import '../../Log/log_service.dart';

class CloudMessagingService {
  final messaging = FirebaseMessaging.instance;
  Future<void> initalize() async {
    final token = await messaging.getToken();
    Log.echo('🍑  FCM TOKEN:${token!}');
  }
}
