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

class _Home extends StatelessWidget {
  const _Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // Container 는 자식에 크기를 맞추고 싶지 않다면 정렬을 하면 된다.
        body: Container(
          color: Colors.green,
          child: Align(
            child: Text("안녕"),
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
