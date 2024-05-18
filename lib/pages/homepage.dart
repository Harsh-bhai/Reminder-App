import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/components/bottom_navigation_bar.dart';
import 'package:reminder_app/components/buttom_sheet.dart';
import 'package:reminder_app/components/mydrawer.dart';
import 'package:reminder_app/components/set_reminder.dart';
import 'package:reminder_app/models/reminder.dart';
import 'package:flutter/services.dart';
import 'package:reminder_app/services/local_notifications.dart';
import 'package:reminder_app/services/time_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ReminderModel> reminders = [
    ReminderModel(id: 1, title: "Meeting", time: "10:00", period: 'AM'),
    ReminderModel(id: 2, title: "Call Mom", time: "12:30", period: 'PM'),
    ReminderModel(id: 3, title: "Buy Groceries", time: "3:00", period: 'PM'),
  ];

  @override
  Widget build(BuildContext context) {
    TimeNotifier timeNotifier = Provider.of<TimeNotifier>(context);
    // dark mode
    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
      statusBarIconBrightness:
          Brightness.dark, // Dark icons for light status bar
    ));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade400,
        title: const Text('Reminders'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.dark_mode_sharp, color: Colors.white),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple.shade400,
        foregroundColor: Colors.white,
        onPressed: () {

          // Show the full-screen dialog
          MyBottomSheet(context,null,timeNotifier);
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      drawer: const Expanded(
        child: MyDrawer(),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
      body: ListView.builder(
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(reminders[index].title),
            trailing: Text(
              "${reminders[index].time} ${reminders[index].period}",
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            leading: const Icon(Icons.notifications),
            onTap: () {
              LocalNotifications.showSimpleNotification(reminders[index]);
            },
          );
        },
      ),
    );
  }
}
