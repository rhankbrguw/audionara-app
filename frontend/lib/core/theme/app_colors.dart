import 'package:flutter/material.dart';

/// AudioNara brand color palette.
/// These are immutable constants — never reference Colors.* directly in widgets.
abstract final class AppColors {
  /// Primary action color — buttons, active states, highlighted icons.
  static const Color primary = Color(0xFF676DE5);

  /// Secondary accent — gradients, secondary buttons, chip fills.
  static const Color secondary = Color(0xFF777DE7);

  /// Surface color — cards, sheets, elevated containers.
  static const Color surface = Color(0xFFA9ADF0);

  /// App background — the base canvas of every screen.
  static const Color background = Color(0xFFDCDDF9);

  /// On-primary — text/icons placed on top of [primary].
  static const Color onPrimary = Colors.white;

  /// On-background — default body text color.
  static const Color onBackground = Color(0xFF1A1A2E);
}
