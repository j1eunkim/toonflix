import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
//이 앱의 모든 것의 시작(root)이 App widget이라는 뜻

  bool showTitle = true;
  void toggleTItle() {
    setState(() {
      showTitle = !showTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFF4EDDB),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showTitle ? const MyLargeTitle() : const Text('nothing'),
              IconButton(
                onPressed: toggleTItle,
                icon: const Icon(Icons.remove_red_eye),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyLargeTitle extends StatefulWidget {
  const MyLargeTitle({
    super.key,
  });

  @override
  State<MyLargeTitle> createState() => _MyLargeTitleState();
}

class _MyLargeTitleState extends State<MyLargeTitle> {
  @override
  void initState() {
    super.initState();
  }
//init method는 부모요소에 의존하는 데이터를 초기화해야할 때 사용
//initState는 한번만 그리고 build보다 항상 먼저 호출되어야 함

  @override
  void dispose() {
    super.dispose();
  }
//dispose는 위젯이 스크린에서 제거될 때 호출되는 method
//일종의 cancle

  @override
  Widget build(BuildContext context) {
//부모 요소가 AppState
//MyLargeTitle이 이 부모요소에 접근하기 위해 필요한 것이 BuildState
//context란 MyLargeTitle Text의 부모 요소의 모든 정보를 담고 있음
//즉 context에는 위젯 트리에 대한 정보가 있는 것(부모요소의 부모요소, 그위의 부모요소 등까지)
    return Text(
      'My Large Title',
      style: TextStyle(
        fontSize: 30,
        color: Theme.of(context).textTheme.titleLarge?.color,
      ),
    );
  }
}
