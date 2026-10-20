
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const TaskInventoryApp());
}

class TaskInventoryApp extends StatelessWidget {
  const TaskInventoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task & Inventory Manager',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3155FF),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

