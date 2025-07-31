import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shared/theme/app_theme.dart';
import 'features/onboarding/presentation/pages/onboarding_page.dart';

void main() {
  runApp(const ProviderScope(child: RidefiApp()));
}

class RidefiApp extends StatelessWidget {
  const RidefiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RideFi - Flight Search',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const OnboardingPage(),
    );
  }
}






