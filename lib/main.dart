import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:fleet_tracker/Model/Data/location_data.dart';
import 'package:fleet_tracker/Service/Package/BackgroundLocator/background_locator_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Route/router.dart';
import 'Service/Log/log_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await dotenv.load(fileName: kDebugMode ? '.env.develop' : '.env.release');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();

  /// 位置情報を強制的にSetする
  try {
    await LocationData().setData(force: true);
  } catch (e) {
    Log.echo('$e', symbol: '❗');
  }

  /// BackgroundLocatorServiceの初期化
  await BackgroundLocatorService().initialize();

  /// Isolateからのメッセージ受信を開始
  BackgroundLocatorService().observer();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
    );
  }
}
