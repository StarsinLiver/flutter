import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _Home(),
    );
  }
}

class _Home extends StatefulWidget {
  const _Home({super.key});

  @override
  State<_Home> createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  Color mColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              AnimatedDefaultTextStyle(
                style: TextStyle(color: mColor , fontSize: 50),
                duration: Duration(seconds: 2),
                child: Text("안녕"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    mColor = mColor == Colors.red ? Colors.blue : Colors.red;
                  });
                },
                child: Text("버튼"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
