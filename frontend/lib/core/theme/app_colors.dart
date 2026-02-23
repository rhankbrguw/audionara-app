// Brand palette constants — single source of truth for all color decisions.
// Never reference Colors.* or raw hex values outside this file.
import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color primary    = Color(0xFF676DE5);
  static const Color secondary  = Color(0xFF777DE7);
  static const Color accent     = Color(0xFF4A4E9A);
  static const Color surface    = Color(0xFFA9ADF0);
  static const Color surfaceVariant = Color(0xFF8B91D8);
  static const Color background = Color(0xFFDCDDF9);
  static const Color onPrimary  = Colors.white;
  static const Color onBackground = Color(0xFF1A1A2E);
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF4A4E9A);
}
