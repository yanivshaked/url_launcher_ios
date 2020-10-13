import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:url_launcher_ios/url_launcher_ios.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> openUrl() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await UrlLauncherIos.launch("http://www.cnn.com");
    } on PlatformException {
      print('Failed to open URL.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: InkWell(
            child: Icon(Icons.add_circle, color: Colors.blue, size: 24),
            onTap: openUrl,
          ),
        ),
      ),
    );
  }
}
