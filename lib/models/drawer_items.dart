import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DrawerItems {
  String title;
  Icon icon;
  VoidCallback onTap;
  DrawerItems({required this.title, required this.icon, required this.onTap});
}