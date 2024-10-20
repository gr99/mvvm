import 'package:flutter/material.dart';
import 'package:my_test_project/core/services/logging_service.dart';
import 'package:my_test_project/features/home_screen/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crash Logger Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                throw Exception('This is a test exception');
              },
              child: const Text('Trigger Exception'),
            ),
            ElevatedButton(
              onPressed: () {
                LoggingService.logUserAction('User pressed the log action button');
              },
              child: const Text('Log User Action'),
            ),
          ],
        ),
      ),
    );
  }
}
