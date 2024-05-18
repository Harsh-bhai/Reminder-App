import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/services/local_notifications.dart';
import 'package:reminder_app/services/reminder_provider.dart';
import "package:reminder_app/services/time_provider.dart";
import 'pages/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotifications.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => TimeNotifier()),
      ChangeNotifierProvider(create: (context) => ReminderNotifier()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
