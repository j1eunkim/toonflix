import 'package:flutter/material.dart';
import 'package:toonflix/screens/home_screen.dart';
import 'package:toonflix/services/api_service.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  //key는 id처럼 식별하는 데에 쓰임.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
