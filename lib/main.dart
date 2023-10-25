import 'package:flutter/material.dart';
import 'package:toonflix/widgets/button.dart';
import 'package:toonflix/widgets/currencycard.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

//이 앱의 모든 것의 시작이 App widget이라는 뜻
//이 앱의 Root Widget은 materialApp 혹은 cupertionApp 중 하나를 선택해서 return 해야함
//각자 구글/ios임

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF181818),
        body: Container(),
      ),
    );
  }
}
