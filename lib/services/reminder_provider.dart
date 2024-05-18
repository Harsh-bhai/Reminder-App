import 'package:flutter/material.dart';
import 'package:reminder_app/models/reminder.dart';

class ReminderNotifier extends ChangeNotifier {
  final List<ReminderModel> _reminders = [];
  List<ReminderModel> get reminders => _reminders;

  void addReminder(ReminderModel reminder) {
    _reminders.add(reminder); 
    notifyListeners();
  }
  
  void deleteReminder(int id) {
    _reminders.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void updateReminder(ReminderModel reminder) {
    _reminders.removeWhere((element) => element.id == reminder.id);
    _reminders.add(reminder);
    notifyListeners();
  }

  void clearReminders() {
    _reminders.clear();
    notifyListeners();
  }


}