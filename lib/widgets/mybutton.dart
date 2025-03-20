import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/mycolors.dart';

Widget myButton(VoidCallback work, {required label, color = mainColor}) {
  return MaterialButton(
    onPressed: work,
    color: color,
    minWidth: 300,
    child: Text(label),
  );
}
