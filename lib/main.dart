import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: WorkTimer(),
      ),
    );
  }
}

class WorkTimer extends StatefulWidget {
  const WorkTimer({Key? key}) : super(key: key);

  @override
  State<WorkTimer> createState() => _WorkTimerState();
}

class _WorkTimerState extends State<WorkTimer> {
  Timer? _timer;

  var _time = 0;
  var _isRunning = false;

  String _workTime = '';

  void _start() {
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        _time++;
        print('$_time');
      });
    });
  }

  void _pause() {
    _timer?.cancel();
  }

  void _clickButton() {
    _isRunning = !_isRunning;

    if (_isRunning) {
      _start();
    } else {
      _pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  Widget buildBody() {
    int _sec = _time % 60;
    int _min = (_time ~/ 60) % 60;
    int _h = _time ~/ 3600;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 80,
            child: Center(
              child: Text(
                '$_h시간 $_min분 $_sec초',
                style: TextStyle(fontSize: 40),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _clickButton();
              });
            },
            child: Container(
              color: Colors.blueAccent,
              width: 100,
              height: 40,
              child: Center(
                child: Text(
                  _isRunning == true ? '중지' : '시작',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
