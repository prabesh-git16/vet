import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../admin/admin_home.dart';
import '../client/client_home.dart';
import '../doctor/doctor_home.dart';

enum LoginRole { client, doctor, admin }

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginRole selectedRole = LoginRole.client;

  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void login() {
    Widget page;

    switch (selectedRole) {
      case LoginRole.client:
        page = const ClientHome();
        break;

      case LoginRole.doctor:
        page = const DoctorHome();
        break;

      case LoginRole.admin:
        page = const AdminHome();
        break;
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Column(
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: AppTheme.softGreen,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(
                      Icons.pets,
                      size: 50,
                      color: AppTheme.primary,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'PawCare',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                  ),

                  const Text(
                    'Veterinary Clinic',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),

                  const SizedBox(height: 35),

                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextField(
                    controller: passwordController,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Login as',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SegmentedButton<LoginRole>(
                    expandedInsets: EdgeInsets.zero,
                    segments: const [
                      ButtonSegment(
                        value: LoginRole.client,
                        label: Text('Client'),
                        icon: Icon(Icons.person),
                      ),
                      ButtonSegment(
                        value: LoginRole.doctor,
                        label: Text('Doctor'),
                        icon: Icon(Icons.medical_services),
                      ),
                      ButtonSegment(
                        value: LoginRole.admin,
                        label: Text('Admin'),
                        icon: Icon(Icons.admin_panel_settings),
                      ),
                    ],
                    selected: {selectedRole},
                    onSelectionChanged: (value) {
                      setState(() {
                        selectedRole = value.first;
                      });
                    },
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                      ),
                      onPressed: login,
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Demo mode — any email and password will work.',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
