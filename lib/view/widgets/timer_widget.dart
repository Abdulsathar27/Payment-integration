import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {
  final int seconds;
  const TimerWidget({super.key, required this.seconds});

  @override
  Widget build(BuildContext context) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return Column(
      children: [
        const Text(
          "Transactions Expires In",
          style: TextStyle(color: Colors.white70, fontSize: 18),
        ),
        const SizedBox(height: 10),
        Text(
          "$minutes:${remainingSeconds.toString().padLeft(2, '0')}",
          style: const TextStyle(
            color: Colors.red,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
