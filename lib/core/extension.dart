import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  Size get mediaQuerySize => MediaQuery.of(this).size;
}
