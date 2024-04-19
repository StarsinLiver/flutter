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
  double boxOpacity = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              AnimatedOpacity(
                opacity: boxOpacity, // 이 값을 바꾸면 됨
                duration: Duration(seconds: 2),
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    boxOpacity = boxOpacity == 1 ? 0.2 : 1;
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
