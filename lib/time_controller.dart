import 'dart:async';

import 'package:get/get.dart';
import 'package:timer/my_format.dart';

class SSController extends GetxController {
  RxString startTime = ''.obs;
  RxString stopTime = ''.obs;

  Timer? _timer;
  int remainingSeconds = 1;
  bool isRunning = false;
  bool isPaused = false;
  final time = ''.obs;

  void insertStartTime(DateTime dateTime) {
    if (isRunning == false || isPaused == true) {
      if (isPaused == false) {
        startTime.value = dateFormat(dateTime).toString();
        stopTime.value = '';
        stopTime.refresh();
        startTime.refresh();
      }
    }
  }

  void insertStopTime(DateTime dateTime) {
    stopTime.value = dateFormat(dateTime).toString();
    stop();
    stopTime.refresh();
  }

  void start() {
    if (isRunning == false) {
      insertStartTime(DateTime.now());
    }
    if (isRunning == isPaused) {
      isRunning = true;
      isPaused = false;
      _startTimer(remainingSeconds);
      super.onReady();
    }
  }

  void stop() {
    if (isRunning == true) {
      _timer!.cancel();
      remainingSeconds = 1;
      isRunning = false;
      isPaused = false;
      super.onClose();
    }
  }

  void pause() {
    if (isRunning == true) {
      _timer!.cancel();
      isPaused = true;
      super.onClose();
    }
  }

  _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      int hours = (remainingSeconds ~/ 3600) % 24;
      int minutes = (remainingSeconds ~/ 60) % 60;
      int seconds = (remainingSeconds % 60);
      int days = (remainingSeconds ~/ 86400);
      time.value = days < 1
          ? "${hours.toString()}시간${minutes.toString()}분${seconds.toString()}초"
          : "${days.toString()}일${hours.toString()}시간${minutes.toString()}분${seconds.toString()}초";
      remainingSeconds++;
    });
  }
}
