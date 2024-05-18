// bottom_sheet_functions.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/models/reminder.dart';
import 'package:reminder_app/services/reminder_provider.dart';
import 'package:reminder_app/services/time_provider.dart';

// ignore: non_constant_identifier_names
void MyBottomSheet(
    BuildContext context, TimeOfDay? selectedTime, TimeNotifier timeNotifier) {
  TextEditingController titlecontroller = TextEditingController();
  int id = DateTime.now().microsecond % 1000;
  ReminderNotifier reminderNotifier =
      Provider.of<ReminderNotifier>(context, listen: false);
  timeNotifier.setTime(null);
  TimeOfDay? selectedTime;
  showModalBottomSheet(
    backgroundColor: Colors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return Consumer<TimeNotifier>(
          builder: (context, TimeNotifier timeNotifier, child) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: titlecontroller,
                      decoration: const InputDecoration(
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        labelText: 'Title for reminder',
                      ),
                    ),
                  ),
                  if (selectedTime ==
                      null) // Render the "Select Time" button conditionally
                    ElevatedButton(
                      onPressed: () async {
                        selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        timeNotifier.setTime(selectedTime);
                        // setterState(() {});
                      },
                      child: const Text('Select Time'),
                    ),
                  if (timeNotifier.time != null) ...[
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildDigitBox(timeNotifier.time!.hour ~/ 10),
                        const SizedBox(width: 5),
                        _buildDigitBox(timeNotifier.time!.hour % 10),
                        const SizedBox(width: 5),
                        const Text(':'),
                        const SizedBox(width: 5),
                        _buildDigitBox(timeNotifier.time!.minute ~/ 10),
                        const SizedBox(width: 5),
                        _buildDigitBox(timeNotifier.time!.minute % 10),
                        const SizedBox(width: 5),
                        _buildAmPmBox(timeNotifier.time!.period == DayPeriod.am
                            ? 'AM'
                            : 'PM'),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                  ],
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      reminderNotifier.addReminder(ReminderModel(
                          id: id,
                          title: capitalize(titlecontroller.text),
                          time:
                              timeNotifier.time!.format(context).split(" ")[0],
                          period: timeNotifier.time!
                              .format(context)
                              .split(" ")[1]));
                      // i want to show snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: _buildRemainingTimeText(timeNotifier.time!),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            margin: const EdgeInsets.all(16.0),
          ),
        );
                      Navigator.of(context).pop();
                    },
                    child: const Text('Set Reminder'),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    },
  );
}

Widget _buildDigitBox(int digit) {
  return Container(
    width: 40,
    height: 40,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      '$digit',
      style: const TextStyle(fontSize: 24),
    ),
  );
}

Widget _buildAmPmBox(String text) {
  return Container(
    width: 40,
    height: 40,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      text,
      style: const TextStyle(fontSize: 20),
    ),
  );
}

Widget _buildRemainingTimeText(TimeOfDay selectedTime) {
  final now = TimeOfDay.now();
  final currentTime = DateTime(0, 0, 0, now.hour, now.minute);
  final selectedDateTime =
      DateTime(0, 0, 0, selectedTime.hour, selectedTime.minute);
  Duration difference = selectedDateTime.difference(currentTime);
  if (difference.isNegative) {
    difference = const Duration(hours: 24) + difference;
  }
  final hours = difference.inHours;
  final minutes = difference.inMinutes.remainder(60);

  return Text(
    'You will be reminded in '
    '${hours != 0 ? '$hours hours and ' : ''}'
    '${minutes != 0 ? '$minutes minutes.' : 'a minute.'}',
    style: const TextStyle(fontSize: 16),
    textAlign: TextAlign.center,
  );
}

String capitalize(String s) {
  if (s.isEmpty) {
    return s;
  }
  return s[0].toUpperCase() + s.substring(1);
}
