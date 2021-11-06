import 'package:flutter/material.dart';

ListTile listTileCustom(String title, Widget leading, Function onTap) {
  return ListTile(
    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
    title: Text(title, style: TextStyle(color: Colors.black)),
    leading: leading,
    onTap: (onTap as void Function()?),
  );
}
