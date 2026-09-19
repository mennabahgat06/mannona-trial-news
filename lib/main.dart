import 'package:flutter/material.dart';
import 'features/splash_screen/presentation/splash_screen.dart';

void main() {
  runApp(const MannonaNewsApp());
}

class MannonaNewsApp extends StatelessWidget {
  const MannonaNewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mannona-News',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
