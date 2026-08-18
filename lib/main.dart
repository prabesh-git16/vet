import 'package:flutter/material.dart';

import 'screens/auth/login_page.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const PawCareApp());
}

class PawCareApp extends StatelessWidget {
  const PawCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PawCare Veterinary Clinic',
      theme: AppTheme.lightTheme,
      home: const LoginPage(),
    );
  }
}
