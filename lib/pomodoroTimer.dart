import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: const Color(0xFFE7626C),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFF232B55),
          ),
        ),
        cardColor: const Color(0xFFF4EDDB),
      ),
      home: const Pomodoros(),
    );
  }
}

class Pomodoros extends StatefulWidget {
  const Pomodoros({super.key});

  @override
  State<Pomodoros> createState() => _PomodorosState();
}

class _PomodorosState extends State<Pomodoros> {
  static const defalutFocusTime = 2500;
  static const defalutRestTime = 300;
  static const focus = 'focus';
  static const rest = 'rest';
  int focusTime = defalutFocusTime;
  int restTime = defalutRestTime;
  bool isRunning = false;
  String current = focus;
  int totalRound = 0;
  int totalGoal = 0;
  late Timer focusTimer;
  late Timer restTimer;

  void _handleTimerOptionSelected(int minute) {
    setState(() {
      focusTime = minute * 60;
    });
  }

  void onTick(Timer timer) {
    if (focusTime == 0) {
      restTimer = Timer.periodic(const Duration(seconds: 1), onRest);
      focusTimer.cancel();
      setState(() {
        totalRound = totalRound + 1;
        isRunning = false;
        focusTime = defalutFocusTime;
        //타이머 하나가 끝나면 reset하는 과정
      });
    } else {
      setState(() {
        focusTime = focusTime - 1;
      });
    }
    if (totalRound == 4) {
      totalRound = 0;
      totalGoal = totalGoal + 1;
    }
  }

  void onRest(Timer timer) {
    if (restTime == 0) {
      restTimer.cancel();
      setState(() {
        restTime = defalutRestTime;
        current = focus;
        isRunning = false;
      });
    } else {
      setState(() {
        restTime = restTime - 1;
      });
    }
  }

  void onStartPressed() {
    setState(() {
      if (current == focus) {
        focusTimer = Timer.periodic(const Duration(seconds: 1), onTick);
      }
      if (current == rest) {
        restTimer = Timer.periodic(const Duration(seconds: 1), onRest);
      }
      isRunning = true;
    });
  }

  void onPausePressed() {
    if (focusTimer.isActive) {
      focusTimer.cancel();
    } else if (restTimer.isActive) {
      restTimer.cancel();
    }
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    if (isRunning && focusTimer.isActive) {
      focusTimer.cancel();
    } else if (isRunning && restTimer.isActive) {
      restTimer.cancel();
    }

    setState(() {
      isRunning = false;
      focusTime = defalutFocusTime;
      restTime = defalutRestTime;
      current = focus;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'POMOTIMER',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    format(focusTime),
                    style: TextStyle(
                        color: Theme.of(context).cardColor,
                        fontSize: 80,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Flexible(
                child: Row(
                  children: [
                    TimerOption(
                      minute: 15,
                      onTimeSelected: _handleTimerOptionSelected,
                    ),
                    const SizedBox(width: 10),
                    TimerOption(
                      minute: 20,
                      onTimeSelected: _handleTimerOptionSelected,
                    ),
                    const SizedBox(width: 10),
                    TimerOption(
                      minute: 25,
                      onTimeSelected: _handleTimerOptionSelected,
                    ),
                    const SizedBox(width: 10),
                    TimerOption(
                      minute: 30,
                      onTimeSelected: _handleTimerOptionSelected,
                    ),
                    const SizedBox(width: 10),
                    TimerOption(
                      minute: 35,
                      onTimeSelected: _handleTimerOptionSelected,
                    ),
                    const SizedBox(width: 10)
                  ],
                ),
              ),
              const SizedBox(height: 40),
              IconButton(
                onPressed: isRunning ? onPausePressed : onStartPressed,
                icon: Icon(isRunning ? Icons.pause_circle : Icons.play_circle),
                color: Theme.of(context).primaryColorLight,
                iconSize: 100,
              ),
              IconButton(
                onPressed: onResetPressed,
                icon: const Icon(Icons.refresh),
                color: Theme.of(context).primaryColorLight,
                iconSize: 20,
              ),
              Flexible(
                flex: 2,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "$totalRound/4",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 30,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Round",
                            style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("$totalGoal/12",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600)),
                          Text(
                            "Goal",
                            style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

typedef TimeSelectedCallback = void Function(int minute);

class TimerOption extends StatelessWidget {
  final int minute;
  final TimeSelectedCallback onTimeSelected;

  const TimerOption({
    super.key,
    required this.minute,
    required this.onTimeSelected,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onTimeSelected(minute);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).primaryColorLight,
              width: 3.0,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            '$minute',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ));
  }
}
