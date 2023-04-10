import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timer/time_controller.dart';

void main() async {
  await GetStorage.init();
  Get.put<SSController>(SSController());
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
  // Timer? _timer;
  //
  // var _time = 0;
  // var _isRunning = false;
  //
  // String _workTime = '';
  //
  // void _start() {
  //   _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
  //     setState(() {
  //       _time++;
  //       print('$_time');
  //     });
  //   });
  // }
  //
  // void _pause() {
  //   _timer?.cancel();
  // }
  //
  // void _clickButton() {
  //   _isRunning = !_isRunning;
  //
  //   if (_isRunning) {
  //     _start();
  //   } else {
  //     _pause();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  Widget buildBody() {
    // int _sec = _time % 60;
    // int _min = (_time ~/ 60) % 60;
    // int _h = _time ~/ 3600;
    final controller = Get.find<SSController>();
    return Center(
      child: Obx(
        () {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
                child: Center(
                  child: Text(
                    '${controller.time.value}',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  setState(
                    () {
                      controller.isRunning == true
                          ? controller.stop()
                          : controller.start();
                    },
                  );
                },
                child: Container(
                  color: Colors.blueAccent,
                  width: 100,
                  height: 40,
                  child: Center(
                    child: Text(
                      controller.isRunning == true ? '종료' : '시작',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  setState(
                    () {
                      controller.isPaused == true
                          ? controller.start()
                          : controller.pause();
                    },
                  );
                },
                child: Container(
                  color: Colors.blueAccent,
                  width: 100,
                  height: 40,
                  child: Center(
                    child: Text(
                      controller.isPaused == true ? '재개' : '중지',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
