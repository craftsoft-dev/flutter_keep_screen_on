import 'dart:async';

import 'package:flutter/material.dart';

import 'package:keep_screen_on/keep_screen_on.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool? _isKeepScreenOn;
  DateTime? _changeAt;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('KeepScreenOn Plugin Example App'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    title: Text('Keep screen on'),
                    subtitle: (_isKeepScreenOn == null) ? Text('Unknown') : Text(_isKeepScreenOn.toString()),
                  ),
                  ListTile(
                    title: Text('Change date and time'),
                    subtitle: Text(_changeAt.toString()),
                  ),
                  ListTile(
                    title: Text('Elapsed time'),
                    subtitle: ElapsedTimeText(_changeAt),
                  )
                ],
              ),

              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.arrow_upward),
                    label: Text('Turn on'),
                    onPressed: () {
                      KeepScreenOn.turnOn(true).then((value) async {
                        final isOn = await KeepScreenOn.isOn;
                        setState(() {
                          _isKeepScreenOn = isOn;
                          _changeAt = DateTime.now();
                        });
                      });
                    },
                  ),

                  ElevatedButton.icon(
                    icon: Icon(Icons.arrow_downward),
                    label: Text('Turn off'),
                    onPressed: () {
                      KeepScreenOn.turnOn(false).then((value) async {
                        final isOn = await KeepScreenOn.isOn;
                        setState(() {
                          _isKeepScreenOn = isOn;
                          _changeAt = DateTime.now();
                        });
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ElapsedTimeText extends StatefulWidget {
  final DateTime? startAt;

  ElapsedTimeText(this.startAt);

  @override
  _ElapsedTimeTextState createState() => _ElapsedTimeTextState();
}

class _ElapsedTimeTextState extends State<ElapsedTimeText> {

  Timer? _timer;
  String _elapsedText = '';

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), updateElapsed);
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_elapsedText);
  }

  void updateElapsed(Timer _timer) {
    if (widget.startAt == null) {
      return;
    }

    final elapsed = DateTime.now().difference(widget.startAt!);

    setState(() {
      _elapsedText = elapsed.inHours.toString()
          + ':' + formatTwoDigits(elapsed.inMinutes.remainder(60))
          + ':' + formatTwoDigits(elapsed.inSeconds.remainder(60));
    });
  }

  static String formatTwoDigits(int num) {
    return num.toString().padLeft(2, '0');
  }
}