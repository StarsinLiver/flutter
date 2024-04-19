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
    return Scaffold(
      body: SafeArea(
        // 주석의 밑과 같이도 구성할 수 도 있다.
        // child: Container(
        //   child: Text("안녕"),
        //   color: Colors.green,
        //   constraints: BoxConstraints(minHeight: 55 , minWidth: 100),
        // ),
        child: ConstrainedBox(
          // ConstrainedBox 를 쓸바엔 BoxConstraints 를 쓰자
          // minWidth , minHeight
          // maxWidth , maxHeight 를 지정 할 수 있다.
          constraints: BoxConstraints(
            minWidth: 500,
          ),
          child: ElevatedButton(
            child: Text("Hello EveryOne"),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
