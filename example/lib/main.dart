import 'package:flutter/material.dart';

import 'package:dixa_flutter/dixa_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _dixaFlutterPlugin = DixaFlutter();

  @override
  void initState() {
    super.initState();

    const dixaApiKey = "<dixaApiKey>";
    _dixaFlutterPlugin.configure(apiKey: dixaApiKey);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            TextButton(
              onPressed: () async {
                await _dixaFlutterPlugin.updateUserCredentials(
                  username: "Juan",
                  email: "juan@gmail.com",
                );
                _dixaFlutterPlugin.openMessenger();
              },
              child: const Text("show messenger"),
            ),
            TextButton(
              onPressed: () async {
                _dixaFlutterPlugin.clearUserCredentials();
              },
              child: const Text("clear username"),
            ),
          ],
        ),
      ),
    );
  }
}
