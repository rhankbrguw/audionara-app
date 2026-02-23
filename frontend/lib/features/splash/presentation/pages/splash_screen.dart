import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

// Navigation delay is a presentation concern; Future.delayed is intentional
// here — no business logic gates the transition.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) context.go('/player');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeOut,
          builder: (context, opacity, child) => Opacity(
            opacity: opacity,
            child: child,
          ),
          child: Image.asset(
            'assets/images/logo.png',
            width: 160,
            height: 160,
            semanticLabel: 'AudioNara logo',
            // Branded fallback prevents a crash if the asset is absent in CI
            // or an unsigned debug build where assets haven't been bundled.
            errorBuilder: (context, error, stackTrace) => Container(
              width: 160,
              height: 160,
              decoration: const BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.music_note_rounded,
                size: 72,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
