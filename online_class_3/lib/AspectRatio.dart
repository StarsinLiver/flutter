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
        body: Container(
          color: Colors.blue,
          width: 300,
          height: 600,
          // Container 는 부모 크기만큼 확장 , 자식이 있다면 그만큼 축소
          // 만약 크기를 지정한 것을 사용하고 싶다면 (위치를 지정하면 됨)
          // 크기가 있어도 위치를 지정하지 않으면 부모의 크기만큼 확장
          child: AspectRatio(
            aspectRatio: 1 / 1.5,
            child: Container(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
