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
        body: Column(
          children: [
            Container(
              height: 500,
              width: 500,
              color: Colors.red,
              child: FittedBox(
                fit: BoxFit.fill, // 이 부분 조정
                child: Image.asset('assets/image.jpeg'),
              ),
            ),
            Spacer(),
            Image.asset('assets/image.jpeg'),
          ],
        ),
      ),
    );
  }
}
