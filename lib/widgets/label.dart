import 'package:flutter/material.dart';

import '../services/setup_service.dart';
import '../utils/app_settings.dart';

Container label(
    {required String label,
    Color? color,
    TextStyle? style,
    AlignmentGeometry? aligment}) {
  return Container(
    alignment: aligment,
    child: Text(label,
        style: style ??
            TextStyle(
                color:
                    color ?? appService<AppSettings>().appTheme!.primaryColor,
                fontSize: 12)),
  );
}
