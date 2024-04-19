import 'package:flutter/cupertino.dart';
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
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              // showDialog (alert 와 같은 느낌)
              // context : context
              // builder 빌드할 아이
              showDialog(
                context: context,
                builder: (context) => buildCupertinoAlertDialog(context),
              );
            },
            child: Text("버튼"),
          ),
        ),
      ),
    );
  }

  // 함수화
  AlertDialog buildAlertDialog(BuildContext context) {
    return AlertDialog(
      title: Text("alert 다이아로그"),
      backgroundColor: Colors.white,
      // 액션을 지정할 수 있음
      actions: <Widget>[
        TextButton(
          child: const Text('닫기'),
          onPressed: () {
            // 이전 화면 빌드 (pop : stack 자료형인듯)
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

CupertinoAlertDialog buildCupertinoAlertDialog(BuildContext context) {
  return CupertinoAlertDialog(
    title: Text("쿠퍼디노 다이아그램"),
    content: Text("내용오옹ㅇㅇㅇ"),
    actions: <Widget>[
      TextButton(onPressed: () {}, child: Text("적용")),
      TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("닫기")),
    ],
  );
}

// 얘는 뭐 얼캐 사용하지 ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ
CupertinoDialogAction buildCupertinoDialogAction(BuildContext context) {
  return CupertinoDialogAction(
    child: Container(
      height: 300,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(child: Text("안녕하세요오")),
          Expanded(child: Text("하하하핳")),
        ],
      ),
    ),
  );
}
