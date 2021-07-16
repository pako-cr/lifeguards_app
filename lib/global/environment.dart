import 'package:flutter/material.dart';
import 'dart:io';

class Environment {
  static String apiUrl =
      Platform.isAndroid ? '192.168.0.109:3000' : 'localhost:3000';

  static String socketUrl =
      Platform.isAndroid ? '192.168.0.109:3000' : 'http://localhost:3000';

  static Color backgroundColor = Color(0xffF2F2F2);
  static Color enabledColor = Colors.red[900] ?? Colors.red;
  static Color disabledColor = Colors.grey[400] ?? Colors.grey;
}
