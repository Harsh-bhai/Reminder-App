import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder_app/models/drawer_items.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<DrawerItems> drawerItems = [
      DrawerItems(title: "About", icon: const Icon(Icons.info), onTap: () {}),
      DrawerItems(title: "Daily Reminders", icon: const Icon(Icons.alarm), onTap: () {}),
      DrawerItems(title: "Settings", icon: const Icon(Icons.settings), onTap: () {}),
    ];
    return Drawer(
      child: ListView.builder(
        itemCount: drawerItems.length + 1, // Adding 1 for DrawerHeader
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          if (index == 0) {
            // DrawerHeader goes here
            return const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Text(
                'Reminder',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            );
          } else {
            // Other drawer items
            final itemIndex = index - 1;
            return ListTile(
              leading: Icon(drawerItems[itemIndex].icon.icon,size: 30),
              title: Text(drawerItems[itemIndex].title,style: const TextStyle(fontSize: 20),),
              onTap: drawerItems[itemIndex].onTap,
            );
          }
        },
      ),
    );
  }
}
