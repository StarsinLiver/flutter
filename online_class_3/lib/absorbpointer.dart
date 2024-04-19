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
  var isCheck = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                print("1번 안 감싼것");
                setState(() {
                  // 재 빌드
                  isCheck = false;
                });
                print("isCheck : $isCheck");
              },
              child: Text("안녕"),
            ),
            AbsorbPointer(
              // true : 버튼 비활성화
              // false : 버튼 활성화
              absorbing: isCheck, // 실행이 안됨 (setState 활용해야함)
              child: ElevatedButton(
                onPressed: () {
                  print("2번 absorbPointer");
                },
                child: Text("클릭"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
