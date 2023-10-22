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

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  bool? _isKeepScreenOn;
  bool? _isAllowLockWhileScreenOn;
  DateTime? _changeAt;
  DateTime? _pausedAt;

  final _appLifecycleStateHistories = <AppLifecycleStateHistory>[];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final stateHistory = AppLifecycleStateHistory(
      time: DateTime.now(),
      state: state,
    );
    if (context.mounted) {
      setState(() {
        _appLifecycleStateHistories.add(stateHistory);
      });
    } else {
      _appLifecycleStateHistories.add(stateHistory);
    }
    
    if (state == AppLifecycleState.paused) {
      setState(() {
        _pausedAt = DateTime.now();
      });
    }
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    title: Text('Keep screen on'),
                    subtitle: (_isKeepScreenOn == null) ? Text('Unknown') : Text(_isKeepScreenOn.toString()),
                  ),
                  ListTile(
                    title: Text('FLAG_ALLOW_LOCK_WHILE_SCREEN_ON'),
                    subtitle: (_isAllowLockWhileScreenOn == null) ? Text('Unknown') : Text(_isAllowLockWhileScreenOn.toString()),
                  ),
                  ListTile(
                    title: Text('Change date and time'),
                    subtitle: Text(_changeAt.toString()),
                  ),
                  ListTile(
                    title: Text('Elapsed time'),
                    subtitle: ElapsedTimeText(_changeAt),
                  ),
                  ListTile(
                    title: Text('Paused at(The app moves to the background)'),
                    subtitle: Text(_pausedAt.toString()),
                  )
                ],
              ),

              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.lightbulb),
                    label: Text('Turn on and allowLockWhileScreenOn'),
                    onPressed: () {
                      KeepScreenOn.turnOn(withAllowLockWhileScreenOn: true)
                          .then((value) => _refreshState());
                    },
                  ),

                  ElevatedButton.icon(
                    icon: Icon(Icons.lightbulb_outline),
                    label: Text('Turn off and allowLockWhileScreenOn'),
                    onPressed: () {
                      KeepScreenOn.turnOff(withAllowLockWhileScreenOn: true)
                          .then((value) => _refreshState());
                    },
                  ),

                  ElevatedButton.icon(
                    icon: Icon(Icons.lightbulb),
                    label: Text('Turn on'),
                    onPressed: () {
                      KeepScreenOn.turnOn().then((value) => _refreshState());
                    },
                  ),

                  ElevatedButton.icon(
                    icon: Icon(Icons.lightbulb_outline),
                    label: Text('Turn off'),
                    onPressed: () {
                      KeepScreenOn.turnOff().then((value) => _refreshState());
                    },
                  ),
                ],
              ),

              const Text('AppLifecycleState'),
              Flexible(
                child: ListView.builder(
                  reverse: true,
                  itemBuilder: (context, index) {
                    final item = _appLifecycleStateHistories.elementAt(index);

                    final leadingStyle = DefaultTextStyle.of(context).style.copyWith(
                      color: item.stateColor,
                      fontWeight: FontWeight.bold,
                    );

                    return ListTile(
                      leading: Text(item.state.name, style: leadingStyle),
                      title: Text(item.time.toLocal().toString(), textAlign: TextAlign.end),
                      dense: true,
                    );
                  },
                  itemCount: _appLifecycleStateHistories.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refreshState() {

    return Future.wait([
      KeepScreenOn.isOn,
      KeepScreenOn.isAllowLockWhileScreenOn,
    ]).then((values) {
      setState(() {
        _isKeepScreenOn = values.elementAtOrNull(0) ?? false;
        _isAllowLockWhileScreenOn = values.elementAtOrNull(1) ?? false;
        _changeAt = DateTime.now();
        });
    });
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
  String _elapsedText = 'null';

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

class AppLifecycleStateHistory {
  final DateTime time;
  final AppLifecycleState state;

  AppLifecycleStateHistory({
    required this.time,
    required this.state,
  });

  Color get stateColor {
    switch (state) {
      case AppLifecycleState.detached:
        return Colors.red;
      case AppLifecycleState.resumed:
        return Colors.green;
      case AppLifecycleState.inactive:
        return Colors.grey;
      case AppLifecycleState.hidden:
        return Colors.orange;
      case AppLifecycleState.paused:
        return Colors.indigo;
      default:
        return Colors.black;
    }
  }
}
