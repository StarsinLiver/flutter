import 'dart:math';

import 'package:flutter/material.dart';

// key란?

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
  List<Widget> boxs = [
    // MyBoxKey(ValueKey("1")),
    // MyBoxKey(ValueKey("2")),
    MyBoxConstructor(Colors.red),
    MyBoxConstructor(Colors.blue),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.change_circle_outlined),
          onPressed: () {
            setState(() {
              boxs.insert(1, boxs.removeAt(0));
              //Widget b = boxs.removeAt(0);
              //boxs.add(b);
            });
          },
        ),
        body: Row(children: boxs),
      ),
    );
  }
}

// StatelessWidget 은 타입을 비교 후 랜더링
// StatefulWidget 은 키 값을 비교 -> 따라서 이 상태로 StatefulWidget 으로 변경시 에러
// 만약 StatefulWidget 으로 하고 싶다면 키를 생성
// class MyBox extends StatelessWidget {
//   Color mColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: mColor,
//       height: 150,
//       width: 150,
//     );
//   }
// }

// StatefulWidget -> 키 값을 비교하고 랜더링
class MyBoxKey extends StatefulWidget {
  // 자식의 생성자가 실행될 때 부모의 생성자가 먼저 실행됨.
  // 자식의 스택보다 부모의 생성자가 먼저 실행됨.
  Color mColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];

  MyBoxKey(Key key):super(key : key);
  //{super(key);} -> 오류

  @override
  State<MyBoxKey> createState() => _MyBoxKeyState();
}

class _MyBoxKeyState extends State<MyBoxKey> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.mColor,
      height: 150,
      width: 150,
    );
  }
}

// StatefulWidget -> 생성자 값을 비교하고 랜더링
class MyBoxConstructor extends StatefulWidget {
  // 자식의 생성자가 실행될 때 부모의 생성자가 먼저 실행됨.
  // 자식의 스택보다 부모의 생성자가 먼저 실행됨.
  Color mColor;

  MyBoxConstructor(this.mColor);
  //{super(key);} -> 오류

  @override
  State<MyBoxConstructor> createState() => _MyBoxConstructorState();
}

class _MyBoxConstructorState extends State<MyBoxConstructor> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.mColor,
      height: 150,
      width: 150,
    );
  }
}
