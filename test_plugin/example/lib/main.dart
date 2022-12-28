import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_plugin/test_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _testPlugin = TestPlugin();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _onShowPlatformVersionPressed(context),
                  child: const Text('Get OS version'),
                ),
                ElevatedButton(
                  onPressed: () => _onShowModelPressed(context),
                  child: const Text('Get device name'),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  void _onShowModelPressed(BuildContext context) async {
    var modelName = await _getModelName();

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(modelName)));
  }

  void _onShowPlatformVersionPressed(BuildContext context) async {
    var platformVersion = await _getPlatformVersion();

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(platformVersion)));
  }

  Future<String> _getModelName() async {
    String model;

    try {
      model = await _testPlugin.getModelName() ?? 'Unknown model version';
    } on PlatformException {
      model = 'Failed to get device info.';
    }

    return model;
  }

  Future<String> _getPlatformVersion() async {
    String model;

    try {
      model =
          await _testPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      model = 'Failed to get platform version.';
    }

    return model;
  }
}
