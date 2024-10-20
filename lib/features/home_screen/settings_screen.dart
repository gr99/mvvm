import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isLoggingEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadLoggingPreference();
  }

  Future<void> _loadLoggingPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggingEnabled = prefs.getBool('isLoggingEnabled') ?? false;
    });
  }

  Future<void> _toggleLogging(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggingEnabled = value;
      prefs.setBool('isLoggingEnabled', value);
    });
  }

  Future<void> _sendLogs() async {
    final prefs = await SharedPreferences.getInstance();
    final logs = prefs.getStringList('logs') ?? [];
    print( {'logs': logs});
    print('Logs sent successfully');
    prefs.remove('logs'); // Clear logs after sending


    // final dio = Dio();
    // dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    //
    // try {
    //   final response = await dio.post(
    //     'http://your-backend-url/api/logs',
    //     data: {'logs': logs},
    //   );
    //
    //   if (response.statusCode == 200) {
    //     print('Logs sent successfully');
    //     prefs.remove('logs'); // Clear logs after sending
    //   } else {
    //     print('Failed to send logs');
    //   }
    // } catch (e) {
    //   print('Failed to send logs: $e');
    // }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Enable Logging'),
            trailing: Switch(
              value: _isLoggingEnabled,
              onChanged: _toggleLogging,
            ),
          ),
          ElevatedButton(
            onPressed: _sendLogs,
            child: Text('Send Logs'),
          ),
        ],
      ),
    );
  }
}
