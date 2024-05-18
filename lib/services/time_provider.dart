import 'package:flutter/material.dart';

class TimeNotifier extends ChangeNotifier {

  TimeOfDay? _time = TimeOfDay.now();

  TimeOfDay? get time => _time;

  void setTime(TimeOfDay? time) {
    _time = time;
    notifyListeners();
  }

}