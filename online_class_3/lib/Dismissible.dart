import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

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
        body: buildSwipeTo(),
      ),
    );
  }

  SwipeTo buildSwipeTo() {
    return SwipeTo(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          child: Text('👈🏿 Swipe me Left | YOU |Swipe me right 👉🏿'),
        ),
        onLeftSwipe: (details) {
          print('Callback from Swipe To Left');
        },
        onRightSwipe: (details) {
          print('Callback from Swipe To Right');
        },
      );
  }

  ListView buildListView() {
    return ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          // 왠만하면 다른 라이브러리 사용하자 ㅋㅋ
          return Dismissible(
            // ValueKey 는 String 타입을 받지만 index 라는 숫자도 String 타입으로 변환되어 들어감
            key: ValueKey(index),
            // 백그라운드 설정
            background: Container(
              color: Colors.red,
            ),
            // child 필수 값
            child: ListTile(
              leading: Icon(Icons.account_balance_sharp),
              title: Text("번호 : $index"),
            ),
          );
        },
      );
  }
}
