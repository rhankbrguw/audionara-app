// Brand palette constants — single source of truth for all color decisions.
// Never reference Colors.* or raw hex values outside this file.
import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color primary    = Color(0xFF676DE5);
  static const Color secondary  = Color(0xFF777DE7);
  static const Color surface    = Color(0xFFA9ADF0);
  static const Color background = Color(0xFFDCDDF9);
  static const Color onPrimary  = Colors.white;
  static const Color onBackground = Color(0xFF1A1A2E);
}
