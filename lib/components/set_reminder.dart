import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetReminder extends StatefulWidget {
  const SetReminder({super.key});

  @override
  State<SetReminder> createState() => SetReminderState();
}

class SetReminderState extends State<SetReminder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextButton(
          onPressed: () => ShowDialog(context),
          child: const Text('Show Dialog'),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog.fullscreen(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('This is a fullscreen dialog.'),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
          ),
          child: const Text('Show Fullscreen Dialog'),
        ),
      ],
    );
  }

  Future<String?> ShowDialog(BuildContext context) {
    return showDialog<String>(
          context: context,
          builder: (BuildContext context) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('This is a typical dialog.'),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}