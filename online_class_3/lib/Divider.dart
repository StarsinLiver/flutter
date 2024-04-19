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
          // 가운데 정렬을 위한 width infinity
          width: double.infinity,
          child: Column(
            // 가운데 정렬
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(), // SizedBox 에 Expanded를 준 위젯이다.
              Container(
                color: Colors.blue,
                height: 100,
                width: 300,
              ),
              Divider(
                height: 30,
                color: Colors.black,
                thickness: 5,
                indent: 10, // 왼쪽에 공간이 생김
                endIndent: 10, // 오른쪽에 공간이 생김
              ),
              Container(
                color: Colors.red,
                height: 100,
                width: 300,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
