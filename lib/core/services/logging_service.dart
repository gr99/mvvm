import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoggingService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  static Future<void> logError(BuildContext context, String error, StackTrace? stackTrace) async {
    bool consent = await showErrorDialog(context);
    if (consent) {
      await _prefs?.setBool('isLoggingEnabled', true);
      await _log('Error: $error\nStack trace: ${stackTrace.toString()}');
      await _sendLogsToServer();
    }
  }

  static Future<void> logUserAction(String action) async {
    await _log('User Log: $action');
  }

  static Future<void> _log(String log) async {
    final isLoggingEnabled = _prefs?.getBool('isLoggingEnabled') ?? false;
    if (isLoggingEnabled) {
      final logs = _prefs?.getStringList('logs') ?? [];
      logs.add(log);
      await _prefs?.setStringList('logs', logs);
    }
    print(log);
  }

  static Future<void> _sendLogsToServer() async {
    final logs = _prefs?.getStringList('logs') ?? [];
    print({'logs': logs});

    // final dio = Dio();
    // dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    // try {
    //   final response = await dio.post(
    //     'http://your-backend-url/api/logs',
    //     data: {'logs': logs},
    //   );
    //
    //   if (response.statusCode == 200) {
        print('Logs sent successfully');
        _prefs?.remove('logs'); // Clear logs after sending
    //   } else {
    //     print('Failed to send logs');
    //   }
    // } catch (e) {
    //   print('Failed to send logs: $e');
    // }
  }


  static Future<bool> showErrorDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error occurred'),
          content: const Text('An error occurred. Would you like to send the logs to the server?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    ) ?? false;
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
