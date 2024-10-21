import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_test_project/core/services/api_service.dart';
import 'package:my_test_project/features/imageview/View/ImageListScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/services/logging_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runZonedGuarded(() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      LoggingService.logError(navigatorKey.currentState!.overlay!.context,
          details.exceptionAsString(), details.stack);
    };
    LoggingService.init();
    await resetPreferences();
    runApp(const MyApp());
  }, (error, stack) {
    LoggingService.logError(
        navigatorKey.currentState!.overlay!.context, error.toString(), stack);
  });
}

Future<void> resetPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('logs');
  await prefs.setBool('isLoggingEnabled', false);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crash Logger',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: navigatorKey, // Set the navigator key here
      home: ImageListScreen(),
    );
  }
}
